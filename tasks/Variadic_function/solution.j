use io;
use strings;

# User functions take a fixed number of arguments (built-ins like io.printf
# are variadic). The way to pass "any number" is a list.
func printAll(args as list of string) {
    for (def a in $args) {
        io.printf("%s\n", $a);
    }
}

printAll(["Mary", "had", "a", "little", "lamb"]);

# A list built at run time is passed the same way.
printAll(strings.split("built at run time", " "));
