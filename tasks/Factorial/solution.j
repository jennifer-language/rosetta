use io;

func factorial(n as int) {
    if ($n < 0) {
        throw Error{kind: "value", message: "factorial of a negative number"};
    }
    def result as int init 1;
    for (def i as int init 2; $i <= $n; $i = $i + 1) {
        $result = $result * $i;
    }
    return $result;
}

func factorialRec(n as int) {
    if ($n < 2) {
        return 1;
    }
    return $n * factorialRec($n - 1);
}

for (def n in 0..21) {
    io.printf("%d! = %d\n", $n, factorial($n));
}
io.printf("10! = %d (recursive)\n", factorialRec(10));

# int is 64-bit and overflow is an error, not a wrap-around.
for (def n in [21, -1]) {
    try {
        factorial($n);
    } catch (e) {
        io.printf("%d!: %s (%s)\n", $n, $e.message, $e.kind);
    }
}
