use io;
use lists;

func twice(f as func, x as int) {
    return $f($f($x));
}

func square(n as int) {
    return $n * $n;
}

func isOdd(n as int) {
    return $n % 2 == 1;
}

func add(a as int, b as int) {
    return $a + $b;
}

# A bare function name is the function as a value.
io.printf("%d\n", twice(square, 3));

def xs as list of int init [1, 2, 3, 4, 5];
io.printf("%a\n", lists.map($xs, square));
io.printf("%a\n", lists.filter($xs, isOdd));
io.printf("%d\n", lists.reduce($xs, add, 0));

# Function values can be stored and called through a variable.
def f as func init square;
io.printf("%d\n", $f(12));
