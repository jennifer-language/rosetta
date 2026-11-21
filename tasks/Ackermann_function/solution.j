use io;

func ackermann(m as int, n as int) {
    if ($m == 0) {
        return $n + 1;
    }
    if ($n == 0) {
        return ackermann($m - 1, 1);
    }
    return ackermann($m - 1, ackermann($m, $n - 1));
}

for (def m in 0..4) {
    for (def n in 0..5) {
        io.printf("A(%d, %d) = %d\n", $m, $n, ackermann($m, $n));
    }
}

# The recursion is as deep as the result, and the call depth is capped:
# runaway recursion is a catchable error of kind "limit".
try {
    ackermann(4, 1);
} catch (e) {
    io.printf("A(4, 1): %s (%s)\n", $e.message, $e.kind);
}
