use io;

# Iterative. Negative n follows F(-n) = (-1)^(n+1) * F(n).
# F(92) is the largest that fits in int; F(93) overflows, which is an error.
func fib(n as int) {
    if ($n < 0) {
        def f as int init fib(-$n);
        if ($n % 2 == 0) {
            return -$f;
        }
        return $f;
    }
    if ($n == 0) {
        return 0;
    }
    def a as int init 0;
    def b as int init 1;
    for (def i in 1..$n) {
        def next as int init $a + $b;
        $a = $b;
        $b = $next;
    }
    return $b;
}

for (def n in -8..16) {
    io.printf("F(%d) = %d\n", $n, fib($n));
}
io.printf("F(92) = %d\n", fib(92));
try {
    fib(93);
} catch (e) {
    io.printf("F(93): %s\n", $e.message);
}
