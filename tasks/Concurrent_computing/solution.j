use io;
use math;
use task;
use time;

def tasks as list of task of string;
for (def word in ["Enjoy", "Rosetta", "Code"]) {
    # spawn copies the enclosing scope, so each task has its own $word.
    $tasks[] = spawn {
        time.sleep(time.fromMilliseconds(math.randInt(0, 50)));
        io.printf("%s\n", $word);
        return $word;
    };
}
task.waitAll($tasks);
