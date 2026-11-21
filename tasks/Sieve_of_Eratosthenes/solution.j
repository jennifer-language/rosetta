use io;

func sieve(limit as int) {
    def composite as list of bool;
    for (def i in 0..$limit + 1) {
        $composite[] = false;
    }
    def primes as list of int;
    for (def n in 2..$limit + 1) {
        if ($composite[$n]) {
            continue;
        }
        $primes[] = $n;
        # Cross off from n * n; for n past the square root there is nothing left.
        for (def m as int init $n * $n; $m <= $limit; $m = $m + $n) {
            $composite[$m] = true;
        }
    }
    return $primes;
}

io.printf("%a\n", sieve(100));
