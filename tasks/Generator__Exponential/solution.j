use channel;
use io;
use task;

# A generator is a task that sends into a channel; the reader pulls values
# with channel.recv. The tasks run forever, so they are discarded: the
# program does not wait for them at its end.
func powers(m as int) {
    def ch as channel of int init channel.make(0);
    def t as task of int init spawn {
        def i as int init 0;
        while (true) { # lint-disable: L105
            def p as int init 1;
            for (def k in 0..$m) {
                $p = $p * $i;
            }
            channel.send($ch, $p);
            $i = $i + 1;
        }
        return 0;
    };
    task.discard($t);
    return $ch;
}

# Values of a that are not in b; both ascending.
func without(a as channel of int, b as channel of int) {
    def ch as channel of int init channel.make(0);
    def t as task of int init spawn {
        def y as int init channel.recv($b);
        while (true) { # lint-disable: L105
            def x as int init channel.recv($a);
            while ($y < $x) {
                $y = channel.recv($b);
            }
            if ($x != $y) {
                channel.send($ch, $x);
            }
        }
        return 0;
    };
    task.discard($t);
    return $ch;
}

def squares as channel of int init without(powers(2), powers(3));
for (def i in 0..20) {
    channel.recv($squares);
}
for (def i in 0..10) {
    io.printf("%d ", channel.recv($squares));
}
io.printf("\n");
