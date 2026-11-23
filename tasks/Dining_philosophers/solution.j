use channel;
use io;
use math;
use task;
use time;

def const MEALS as int init 3;

# Five forks, each a channel holding one token: recv picks the fork up (and
# waits while a neighbour holds it), send puts it back.
#
# Deadlock is prevented by ordering the forks: every philosopher picks up the
# lower-numbered of his two forks first. Aristotle to Marx take their left
# fork first, Russell (between forks 4 and 0) his right one, so the five can
# never each hold one fork and wait for the next: some philosopher can
# always get both.
def forks as list of channel of bool;
for (def i in 0..5) {
    def fork as channel of bool init channel.make(1);
    channel.send($fork, true);
    $forks[] = $fork;
}

func pause() {
    time.sleep(time.fromMilliseconds(math.randInt(1, 20)));
}

def names as list of string init ["Aristotle", "Kant", "Spinoza", "Marx", "Russell"];
def diners as list of task of int;
for (def i in 0..5) {
    $diners[] = spawn {
        def name as string init $names[$i];
        def first as int init math.min($i, ($i + 1) % 5);
        def second as int init math.max($i, ($i + 1) % 5);
        for (def meal in 1..MEALS + 1) {
            pause();
            channel.recv($forks[$first]);
            channel.recv($forks[$second]);
            io.printf("%s eats with forks %d and %d (meal %d)\n", $name, $first, $second, $meal);
            pause();
            channel.send($forks[$second], true);
            channel.send($forks[$first], true);
            io.printf("%s puts the forks down and thinks\n", $name);
        }
        return $i;
    };
}
task.waitAll($diners);
io.printf("all five ate %d times\n", MEALS);
