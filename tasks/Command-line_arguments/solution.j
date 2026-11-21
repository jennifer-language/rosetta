use io;
use os;

# os.ARGS holds the program path, then the arguments as given.
# jennifer run solution.j -c "alpha beta" -h "gamma"
for (def i in 0..len(os.ARGS)) {
    io.printf("%d: %s\n", $i, os.ARGS[$i]);
}
