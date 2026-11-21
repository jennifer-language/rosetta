use io;
use os;

# os.run takes the argument list (no shell) and returns the exit code and
# the captured output.
def r as os.Result init os.run(["ls"]);
io.printf("%s", $r.stdout);
io.printf("exit code %d\n", $r.exitCode);
