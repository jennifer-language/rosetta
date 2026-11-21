use io;
use lists;

# A range counts up only; count down with a C-style loop ...
for (def i as int init 10; $i >= 0; $i = $i - 1) {
    io.printf("%d ", $i);
}
io.printf("\n");

# ... or a list with a negative step.
for (def i in lists.range(10, -1, -1)) {
    io.printf("%d ", $i);
}
io.printf("\n");
