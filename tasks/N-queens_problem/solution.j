use io;
use strings;

# cols[r] is the column of the queen in row r.
func safe(cols as list of int, col as int) {
    def row as int init len($cols);
    for (def r in 0..$row) {
        def c as int init $cols[$r];
        if ($c == $col or $c - $col == $row - $r or $col - $c == $row - $r) {
            return false;
        }
    }
    return true;
}

def struct Search {
    count as int,
    first as list of int
};

func place(n as int, cols as list of int, s as Search) {
    if (len($cols) == $n) {
        if ($s.count == 0) {
            $s.first = $cols;
        }
        $s.count = $s.count + 1;
        return $s;
    }
    for (def col in 0..$n) {
        if (safe($cols, $col)) {
            def next as list of int init $cols;
            $next[] = $col;
            $s = place($n, $next, $s);
        }
    }
    return $s;
}

def empty as Search;
def eight as Search init place(8, [], $empty);
for (def c in $eight.first) {
    io.printf("%s\n", strings.replicate(". ", $c) + "Q " + strings.replicate(". ", 7 - $c));
}
for (def n in 1..11) {
    io.printf("%d: %d\n", $n, place($n, [], $empty).count);
}
