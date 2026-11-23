use io;

for (def i in 1..6) {
    for (def j in 0..$i) {
        io.printf("*");
    }
    io.printf("\n");
}
