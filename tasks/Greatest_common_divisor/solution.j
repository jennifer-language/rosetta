use io;

# Euclid's algorithm on the absolute values, so the result is never negative.
# gcd(0, 0) is 0; gcd(n, 0) is |n|.
func gcd(a as int, b as int) {
    if ($a < 0) {
        $a = -$a;
    }
    if ($b < 0) {
        $b = -$b;
    }
    while ($b != 0) {
        def r as int init $a % $b;
        $a = $b;
        $b = $r;
    }
    return $a;
}

for (def pair in [[40902, 24140], [1071, 462], [-12, 18], [0, 7], [0, 0]]) {
    def g as int init gcd($pair[0], $pair[1]);
    io.printf("gcd(%d, %d) = %d\n", $pair[0], $pair[1], $g);
}
