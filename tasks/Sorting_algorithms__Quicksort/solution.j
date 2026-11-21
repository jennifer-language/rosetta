use io;
use lists;

# Allocates new lists: values are copied anyway (assignment and arguments copy).
func quicksort(xs as list of int) {
    if (len($xs) <= 1) {
        return $xs;
    }
    def pivot as int init $xs[len($xs) // 2];
    def less as list of int;
    def same as list of int;
    def more as list of int;
    for (def x in $xs) {
        if ($x < $pivot) {
            $less[] = $x;
        } elseif ($x > $pivot) {
            $more[] = $x;
        } else {
            $same[] = $x;
        }
    }
    return lists.concat(lists.concat(quicksort($less), $same), quicksort($more));
}

def xs as list of int init [65, 2, -31, 0, 99, 2, 83, 782, 1];
io.printf("%a\n", quicksort($xs));
io.printf("%a\n", $xs);
