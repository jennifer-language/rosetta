use convert;
use io;
use strings;

# next says a term aloud: each run of one digit becomes its length, then
# the digit (1211 is "one 1, one 2, two 1s": 111221).
func next(term as string) {
    def parts as list of string;
    def ds as list of string init strings.chars($term);
    def i as int init 0;
    while ($i < len($ds)) {
        def j as int init $i;
        while ($j < len($ds) and $ds[$j] == $ds[$i]) {
            $j = $j + 1;
        }
        $parts[] = convert.toString($j - $i) + $ds[$i];
        $i = $j;
    }
    return strings.join($parts, "");
}

def term as string init "1";
for (def n in 0..10) {
    io.printf("%s\n", $term);
    $term = next($term);
}
