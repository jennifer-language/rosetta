#!/usr/bin/env bash
# SPDX-License-Identifier: MIT-0
#
# Print a task's Rosetta Code section, ready to paste into the task page:
#
#   tools/wiki.sh FizzBuzz
#
# The output is expected.txt; a task with expected.grep instead is run (a
# network task needs the network). The version is JENNIFER_VERSION, the
# release the solutions were last checked on.

set -euo pipefail

cd "$(dirname "$0")/.."
t="${1:?usage: tools/wiki.sh <task directory name>}"
d="tasks/$t"
[ -f "$d/solution.j" ] || { echo "wiki.sh: no $d/solution.j" >&2; exit 1; }

printf '=={{header|Jennifer}}==\n'
printf '{{works with|Jennifer|%s}}\n' "$(cat JENNIFER_VERSION)"
printf '<syntaxhighlight lang="jennifer">\n'
cat "$d/solution.j"
printf '</syntaxhighlight>\n{{out}}\n<pre>\n'
# <pre> still decodes entities: escape & and < so the output shows as printed.
if [ -f "$d/expected.txt" ]; then
    cat "$d/expected.txt"
else
    args=()
    if [ -f "$d/args" ]; then
        mapfile -t args <"$d/args"
    fi
    (cd "$d" && "${JENNIFER:-jennifer}" run solution.j "${args[@]}")
fi | sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g'
printf '</pre>\n'
