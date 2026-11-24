use convert;
use io;

# Declaration: def NAME as TYPE. Without init a variable holds its type's
# zero value. A variable is read with the $ sigil; the def names it bare.
def count as int;
def name as string init "Jennifer";
def ratio as float init 0.5;
def ok as bool init true;
def xs as list of int init [1, 2, 3];
def ages as map of string to int init {"ada": 36};
io.printf("%d %s %f %t %a %v\n", $count, $name, $ratio, $ok, $xs, $ages);

# Assignment uses the sigil too. There is no += or ++.
$count = $count + 1;

# A variable keeps its declared type. Conversions are spelled out, and one
# that cannot be made is an error.
try {
    $count = convert.toInt("forty-two");
} catch (e) {
    io.printf("\"forty-two\" is not an int\n");
}

# Constants are UPPER_CASE, read without the sigil, and deep: no element of a
# const list can change either.
def const LIMITS as list of int init [10, 20];
io.printf("%d\n", LIMITS[1]);

# Structs, with value semantics: assignment copies.
def struct Point {
    x as int,
    y as int
};

def p as Point init Point{x: 1, y: 2};
def q as Point init $p;
$q.x = 99;
io.printf("%d %d\n", $p.x, $q.x);

# Scope: a def inside a block ends with the block. A name may not shadow
# another one in scope; a function cannot reuse a top-level name either.
if ($ok) {
    def inner as int init 7;
    io.printf("%d\n", $inner);
}

func double(n as int) {
    return $n * 2;
}

io.printf("%d\n", double($count));

# Interpolation in "..." strings; '...' strings are raw.
def n as int init len($xs);
io.printf("{$name} has {$n} items, '{$name}' is literal\n");
io.printf('{$name}' + "\n");
io.printf("%s\n", convert.typeOf($ages));
