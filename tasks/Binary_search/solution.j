use io;

# Both versions search a sorted list between inclusive bounds and return the
# index of the value, or -1 when it is absent. The midpoint is taken as
# low + (high - low) // 2, which cannot overflow.

func searchIter(xs as list of int, value as int) {
    def low as int init 0;
    def high as int init len($xs) - 1;
    while ($low <= $high) {
        def mid as int init $low + ($high - $low) // 2;
        if ($xs[$mid] > $value) {
            $high = $mid - 1;
        } elseif ($xs[$mid] < $value) {
            $low = $mid + 1;
        } else {
            return $mid;
        }
    }
    return -1;
}

func searchRec(xs as list of int, value as int, low as int, high as int) {
    if ($high < $low) {
        return -1;
    }
    def mid as int init $low + ($high - $low) // 2;
    if ($xs[$mid] > $value) {
        return searchRec($xs, $value, $low, $mid - 1);
    }
    if ($xs[$mid] < $value) {
        return searchRec($xs, $value, $mid + 1, $high);
    }
    return $mid;
}

func report(how as string, value as int, at as int) {
    if ($at < 0) {
        io.printf("%s: %d is not in the list\n", $how, $value);
    } else {
        io.printf("%s: %d is at index %d\n", $how, $value, $at);
    }
}

def primes as list of int init [2, 3, 5, 7, 11, 13, 17, 19, 23, 29];
for (def value in [13, 2, 29, 4, 30]) {
    report("iterative", $value, searchIter($primes, $value));
    report("recursive", $value, searchRec($primes, $value, 0, len($primes) - 1));
}
