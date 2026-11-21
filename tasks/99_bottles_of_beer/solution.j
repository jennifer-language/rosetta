use io;

func bottles(n as int) {
    if ($n == 0) {
        return "no more bottles";
    }
    if ($n == 1) {
        return "1 bottle";
    }
    return "{$n} bottles";
}

for (def n as int init 99; $n > 0; $n = $n - 1) {
    def now as string init bottles($n);
    def left as string init bottles($n - 1);
    io.printf("%s of beer on the wall,\n%s of beer.\n", $now, $now);
    io.printf("Take one down, pass it around,\n%s of beer on the wall.\n\n", $left);
}
