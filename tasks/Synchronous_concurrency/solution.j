use channel;
use fs;
use io;
use task;

# The reader is the main program, the printer a task: both run in this one
# interpreter process (`spawn` here starts a task, not a process). They share
# nothing but two unbuffered channels: the lines go one way, the count comes
# back the other.
def lines as channel of string init channel.make(0);
def counts as channel of int init channel.make(0);

def printer as task of int init spawn {
    def n as int init 0;
    def done as bool init false;
    while (not $done) {
        try {
            def line as string init channel.recv($lines);
            io.printf("%s\n", $line);
            $n = $n + 1;
        } catch (e) {
            # The reader closes the channel after the last line: that is its
            # request for the count.
            if ($e.kind != "closed") {
                throw $e;
            }
            $done = true;
        }
    }
    channel.send($counts, $n);
    return $n;
};

def f as fs.File init fs.open("input.txt", "read");
while (not fs.eof($f)) {
    channel.send($lines, fs.readLine($f));
}
fs.close($f);
channel.close($lines);
io.printf("the printer printed %d lines\n", channel.recv($counts));
task.wait($printer);
