use io;

# "to" is a keyword, so the pegs are src, dst and via.
func hanoi(n as int, src as string, dst as string, via as string) {
    if ($n == 0) {
        return;
    }
    hanoi($n - 1, $src, $via, $dst);
    io.printf("Move disk %d from %s to %s\n", $n, $src, $dst);
    hanoi($n - 1, $via, $dst, $src);
}

hanoi(4, "A", "C", "B");
