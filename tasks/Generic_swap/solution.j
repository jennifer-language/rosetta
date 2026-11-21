use io;

# Jennifer has neither generic functions nor references: arguments are
# copies, so no function can swap its caller's variables. A swap is three
# assignments, for any type.
def a as string init "first";
def b as string init "second";
def tmp as string init $a;
$a = $b;
$b = $tmp;
io.printf("%s %s\n", $a, $b);

# A function can return the pair swapped; it is written per type.
def struct IntPair {
    first as int,
    second as int
};

func swapped(p as IntPair) {
    return IntPair{first: $p.second, second: $p.first};
}

def p as IntPair init swapped(IntPair{first: 1, second: 2});
io.printf("%d %d\n", $p.first, $p.second);
