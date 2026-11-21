use io;

# int is 64-bit signed. >> is the arithmetic (sign-filling) shift. There is
# no logical right shift and no rotate operator: both are written with a
# mask. Shifting bits out of the top is not an overflow error.
def const MIN as int init -9223372036854775807 - 1;

func shiftRightLogical(a as int, n as int) {
    if ($n == 0) {
        return $a;
    }
    # Clear the n sign-filled top bits.
    return ($a >> $n) & ~ (MIN >> ($n - 1));
}

func rotateLeft(a as int, n as int) {
    def k as int init $n % 64;
    if ($k == 0) {
        return $a;
    }
    return ($a << $k) | shiftRightLogical($a, 64 - $k);
}

func rotateRight(a as int, n as int) {
    return rotateLeft($a, 64 - $n % 64);
}

func bitwise(a as int, b as int) {
    io.printf("a = %d, b = %d\n", $a, $b);
    io.printf("a and b: %d\n", $a & $b);
    io.printf("a or b: %d\n", $a | $b);
    io.printf("a xor b: %d\n", $a ^ $b);
    io.printf("not a: %d\n", ~ $a);
    io.printf("a << b: %d\n", $a << $b);
    io.printf("a >> b (arithmetic): %d\n", $a >> $b);
    io.printf("a >> b (logical): %d\n", shiftRightLogical($a, $b));
    io.printf("a rotated left by b: %d\n", rotateLeft($a, $b));
    io.printf("a rotated right by b: %d\n", rotateRight($a, $b));
}

bitwise(-255, 2);
