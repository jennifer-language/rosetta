use io;

# Jennifer has one integer type, int: 64-bit signed. There are no 32-bit or
# unsigned integers. Integer arithmetic that overflows is a runtime error
# (kind "runtime"), never a silent wrap-around.
func show(expr as string, f as func) {
    try {
        io.printf("%s = %d\n", $expr, $f());
    } catch (e) {
        io.printf("%s: %s\n", $expr, $e.message);
    }
}

# 64-bit signed: every row is an error.
func neg64() {
    return -(-9223372036854775807 - 1);
}

func add64() {
    return 5000000000000000000 + 5000000000000000000;
}

func sub64() {
    return -9223372036854775807 - 9223372036854775807;
}

func mul64() {
    return 3037000500 * 3037000500;
}

func div64() {
    return (-9223372036854775807 - 1) // -1;
}

show("-(-9223372036854775807 - 1)", neg64);
show("5000000000000000000 + 5000000000000000000", add64);
show("-9223372036854775807 - 9223372036854775807", sub64);
show("3037000500 * 3037000500", mul64);
show("(-9223372036854775807 - 1) // -1", div64);

# 64-bit unsigned: 18446744073709551615 and 10000000000000000000 do not fit
# in int, so those rows do not even load ("invalid int literal ... value out
# of range"). The last row is an overflow like the signed ones.
func mulU64() {
    return 4294967296 * 4294967296;
}

show("4294967296 * 4294967296", mulU64);

# 32-bit signed and unsigned: the results fit in int and are exact.
io.printf("%d\n", -(-2147483647 - 1));
io.printf("%d\n", 2000000000 + 2000000000);
io.printf("%d\n", -2147483647 - 2147483647);
io.printf("%d\n", 46341 * 46341);
io.printf("%d\n", (-2147483647 - 1) // -1);
io.printf("%d\n", -4294967295);
io.printf("%d\n", 3000000000 + 3000000000);
io.printf("%d\n", 2147483647 - 4294967295);
io.printf("%d\n", 65537 * 65537);
