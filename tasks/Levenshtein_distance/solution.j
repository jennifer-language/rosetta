use io;
use math;
use strings;

func levenshtein(a as string, b as string) {
    def s as list of string init strings.chars($a);
    def t as list of string init strings.chars($b);
    def prev as list of int;
    for (def j in 0..len($t) + 1) {
        $prev[] = $j;
    }
    for (def i in 1..len($s) + 1) {
        def cur as list of int init [$i];
        for (def j in 1..len($t) + 1) {
            def cost as int init 1;
            if ($s[$i - 1] == $t[$j - 1]) {
                $cost = 0;
            }
            $cur[] = math.min(math.min($prev[$j] + 1, $cur[$j - 1] + 1), $prev[$j - 1] + $cost);
        }
        $prev = $cur;
    }
    return $prev[len($t)];
}

io.printf("%d\n", levenshtein("kitten", "sitting"));
io.printf("%d\n", levenshtein("rosettacode", "raisethysword"));
io.printf("%d\n", levenshtein("sitting", "kitten"));
