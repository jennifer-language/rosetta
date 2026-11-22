use io;

def const LIMIT as int init 100000;

# The hailstone sequence from n down to 1, both ends included.
func hailstone(n as int) {
    if ($n < 1) {
        throw Error{kind: "value", message: "not a positive integer: {$n}"};
    }
    def seq as list of int init [$n];
    while ($n != 1) {
        if ($n % 2 == 0) {
            $n = $n // 2;
        } else {
            $n = 3 * $n + 1;
        }
        $seq[] = $n;
    }
    return $seq;
}

def s as list of int init hailstone(27);
def n as int init len($s);
io.printf("27: %d elements, starting %v, ending %v\n", $n, $s[..4], $s[$n - 4..]);

# The lengths below LIMIT: a sequence that drops below its start reuses the
# length already found there.
def lengths as list of int init [0, 1];
def best as int init 1;
for (def start in 2..LIMIT) {
    def m as int init $start;
    def steps as int init 0;
    while ($m >= $start) {
        if ($m % 2 == 0) {
            $m = $m // 2;
        } else {
            $m = 3 * $m + 1;
        }
        $steps = $steps + 1;
    }
    $lengths[] = $steps + $lengths[$m];
    if ($lengths[$start] > $lengths[$best]) {
        $best = $start;
    }
}
io.printf("below %d: %d, with %d elements\n", LIMIT, $best, $lengths[$best]);
