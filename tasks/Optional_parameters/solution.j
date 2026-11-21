use io;
use lists;
use strings;

# No optional or named parameters. A struct of options does the job: a
# function returns the defaults, and the caller changes only what it needs.
# The ordering is a key function (string -> string); lists.sortBy takes a
# key, not a comparator.
def struct SortOptions {
    ordering as func,
    column as int,
    reverse as bool
};

def struct Keyed {
    key as string,
    row as list of string
};

func lexicographic(s as string) {
    return $s;
}

func caseless(s as string) {
    return strings.lower($s);
}

func defaults() {
    return SortOptions{ordering: lexicographic, column: 0, reverse: false};
}

func keyOf(k as Keyed) {
    return $k.key;
}

func sortTable(rows as list of list of string, opts as SortOptions) {
    # sortBy's key function cannot see opts (no closures), so the keys are
    # computed first.
    def keyed as list of Keyed;
    for (def r in $rows) {
        $keyed[] = Keyed{key: $opts.ordering($r[$opts.column]), row: $r};
    }
    def out as list of list of string;
    for (def k in lists.sortBy($keyed, keyOf)) {
        $out[] = $k.row;
    }
    if ($opts.reverse) {
        return lists.reverse($out);
    }
    return $out;
}

def table as list of list of string init [["a", "b", "c"], ["", "q", "z"], ["zap", "zip", "Zot"]];

io.printf("%a\n", sortTable($table, defaults()));

def byThird as SortOptions init defaults();
$byThird.column = 2;
io.printf("%a\n", sortTable($table, $byThird));

$byThird.ordering = caseless;
io.printf("%a\n", sortTable($table, $byThird));

def reversed as SortOptions init defaults();
$reversed.reverse = true;
io.printf("%a\n", sortTable($table, $reversed));
