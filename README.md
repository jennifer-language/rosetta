# Jennifer on Rosetta Code

Solutions to [Rosetta Code](https://rosettacode.org/) tasks in
[Jennifer](https://jennifer-lang.dev/), as posted under
[Category:Jennifer](https://rosettacode.org/wiki/Category:Jennifer). This repo
is the master copy: every solution is formatted, linted, run and compared with
its posted output before it goes on the wiki, and again on each release.

Last checked on Jennifer **0.26.0** (`JENNIFER_VERSION`).

## Layout

```
tasks/<Page_name>/      one directory per task page; spaces as "_", "/" as "__"
    solution.j          the code as posted
    expected.txt        the output as posted (with "unordered": as sorted lines)
    expected.grep       instead, for output that changes: regexes to match
    network             a task that needs the network
    args                command-line arguments for the run, one per line
pending/<Page_name>/    solutions blocked by a missing feature (see its README)
tools/check.sh          check every solution (or the tasks named)
tools/wiki.sh <task>    print the task's wiki section, ready to paste
tools/install-jennifer.sh  install a release or a commit (CI)
```

## Checking

```sh
tools/check.sh                      # every task but the network ones
ROSETTA_NETWORK=1 tools/check.sh    # all of them
JENNIFER=/path/to/jennifer tools/check.sh FizzBuzz
```

CI runs the check on the release in `JENNIFER_VERSION` and on the
interpreter's `main` branch, also weekly, so a language change shows which
posted solutions to update.

## Adding a task

1. Read the task page: a solution does what the task asks, not what its name
   suggests.
2. Write `tasks/<Page_name>/solution.j`, run it, save its output as
   `expected.txt` (or write `expected.grep`), and run `tools/check.sh <task>`.
3. Post `tools/wiki.sh <task>` as a `=={{header|Jennifer}}==` section, in
   alphabetical order among the other languages.

After a release: raise `JENNIFER_VERSION`, run the check, and update the
changed solutions and their `{{works with}}` line on the wiki.

## License

The solutions here are under the [MIT No Attribution license](LICENSE)
(MIT-0): copy them into any project without conditions. The copies on Rosetta
Code are under the wiki's page license, GNU FDL 1.3, as well. Changes others
make on the wiki are under the GFDL only and come into this repo only when
they are trivial or their author agrees.
