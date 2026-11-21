use fs;
use io;

def f as fs.File init fs.open("input.txt", "read");
defer fs.close($f);
def n as int init 0;
while (not fs.eof($f)) {
    def line as string init fs.readLine($f);
    $n = $n + 1;
    io.printf("%d: %s\n", $n, $line);
}
