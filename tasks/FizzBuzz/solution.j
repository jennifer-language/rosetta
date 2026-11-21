use io;

for (def i in 1..101) {
    if ($i % 15 == 0) {
        io.printf("FizzBuzz\n");
    } elseif ($i % 3 == 0) {
        io.printf("Fizz\n");
    } elseif ($i % 5 == 0) {
        io.printf("Buzz\n");
    } else {
        io.printf("%d\n", $i);
    }
}
