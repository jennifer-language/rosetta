use io;

# A function returns one value; several travel in a struct.
def struct SumDiff {
    sum as int,
    diff as int
};

func sumDiff(a as int, b as int) {
    return SumDiff{sum: $a + $b, diff: $a - $b};
}

def r as SumDiff init sumDiff(33, 12);
io.printf("%d %d\n", $r.sum, $r.diff);
