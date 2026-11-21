use io;
use lists;

for (def i in lists.range(1, 10, 2)) {
    io.printf("%d ", $i);
}
io.printf("\n");

for (def i as int init 2; $i <= 8; $i = $i + 2) {
    io.printf("%d ", $i);
}
io.printf("who do we appreciate?\n");
