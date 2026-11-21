use io;

# An enum's variants carry no number: they are values of their own type,
# compared with == and dispatched with match.
def enum Fruit {
    Apple,
    Banana,
    Cherry
};

def f as Fruit init Fruit.Banana;
io.printf("%v %t\n", $f, $f == Fruit.Banana);

# Explicit values are constants.
def const APPLE as int init 1;
def const BANANA as int init 2;
def const CHERRY as int init 4;
io.printf("%d\n", APPLE | CHERRY);
