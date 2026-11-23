#!/usr/bin/env bash
# SPDX-License-Identifier: MIT-0
#
# Check every solution: formatted, lint-clean, and printing what was posted.
#
#   tools/check.sh                    # every task without a network marker
#   ROSETTA_NETWORK=1 tools/check.sh  # the network tasks as well
#   tools/check.sh FizzBuzz JSON      # only these tasks
#
# Per task directory (tasks/<Page_name>/, "/" in the page name as "__"):
#   solution.j      the code as posted
#   expected.txt    the output as posted, compared exactly ...
#   unordered       ... or, with this marker, compared as sorted lines
#   expected.grep   for output that changes (dates, web pages): every line is
#                   an extended regex that some output line must match
#   network         needs the network; skipped unless ROSETTA_NETWORK=1
#   args            command-line arguments for the run, one per line
#   stdin           the run's standard input (otherwise it reads nothing)
#
# JENNIFER picks the interpreter (default: jennifer on PATH).

set -euo pipefail

cd "$(dirname "$0")/.."
jennifer="${JENNIFER:-jennifer}"
"$jennifer" version

if [ "$#" -gt 0 ]; then
    tasks=()
    for t in "$@"; do tasks+=("tasks/$t"); done
else
    tasks=(tasks/*/)
fi

fail=0
note() { printf '%s\n' "$*" >&2; fail=1; }

files=()
for d in "${tasks[@]}"; do
    d="${d%/}"
    [ -f "$d/solution.j" ] || { note "FAIL $d: no solution.j"; continue; }
    files+=("$d/solution.j")
done

unformatted="$("$jennifer" fmt -l "${files[@]}")"
[ -z "$unformatted" ] || note "needs jennifer fmt: $unformatted"
"$jennifer" lint "${files[@]}" || note "lint failed"

out="$(mktemp)"
trap 'rm -f "$out"' EXIT
passed=0
skipped=0
for f in "${files[@]}"; do
    d="$(dirname "$f")"
    t="$(basename "$d")"
    if [ -e "$d/network" ] && [ "${ROSETTA_NETWORK:-}" != 1 ]; then
        echo "skip $t (network)"
        skipped=$((skipped + 1))
        continue
    fi
    args=()
    if [ -f "$d/args" ]; then
        mapfile -t args <"$d/args"
    fi
    # Run from the task directory, as a reader would.
    input=/dev/null
    if [ -f "$d/stdin" ]; then
        input="$d/stdin"
    fi
    if ! (cd "$d" && timeout 120 "$jennifer" run solution.j "${args[@]}") <"$input" >"$out" 2>&1; then
        note "FAIL $t: exit status $?"
        sed 's/^/    /' "$out" | tail -20 >&2
        continue
    fi
    if [ -f "$d/expected.txt" ]; then
        if [ -e "$d/unordered" ]; then
            diff <(sort "$d/expected.txt") <(sort "$out") >/dev/null ||
                { note "FAIL $t: output differs (as sorted lines)"; continue; }
        else
            if ! cmp -s "$d/expected.txt" "$out"; then
                note "FAIL $t: output differs"
                diff -u "$d/expected.txt" "$out" | head -40 >&2 || true
                continue
            fi
        fi
    elif [ -f "$d/expected.grep" ]; then
        missing=0
        while IFS= read -r re; do
            [ -n "$re" ] || continue
            grep -Eq -- "$re" "$out" || { note "FAIL $t: no line matches /$re/"; missing=1; }
        done <"$d/expected.grep"
        [ "$missing" = 0 ] || continue
    else
        note "FAIL $t: no expected.txt or expected.grep"
        continue
    fi
    passed=$((passed + 1))
done

echo "$passed passed, $skipped skipped"
exit "$fail"
