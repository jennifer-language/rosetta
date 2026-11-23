use io;
use maps;

# A map has a key type and a value type, and keeps its keys in insertion
# order. It can start from a literal or empty.
def ages as map of string to int init {"Ada": 36, "Grace": 85};
def empty as map of string to int;

$ages["Alan"] = 41;
$ages["Ada"] = 37;
$empty["one"] = 1;
io.printf("%v, %d entries\n", $ages, len($ages));
io.printf("%v\n", $empty);
io.printf("Grace: %d\n", $ages["Grace"]);
io.printf("has Linus: %v\n", maps.has($ages, "Linus"));

# Reading a missing key is an error, not a default value.
try {
    io.printf("%d\n", $ages["Linus"]);
} catch (e) {
    io.printf("%s: %s\n", $e.kind, $e.message);
}

# Removing a key gives a new map.
$ages = maps.delete($ages, "Alan");
io.printf("%v\n", $ages);
