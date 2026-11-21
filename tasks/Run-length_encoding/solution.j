use convert;
use io;
use regex;
use strings;

func encode(s as string) {
    def out as string;
    # A run is a character and its repeats: (.)\1* would need a back
    # reference, which RE2 does not have, so the runs are counted by hand.
    def cs as list of string init strings.chars($s);
    def i as int init 0;
    while ($i < len($cs)) {
        def j as int init $i;
        while ($j < len($cs) and $cs[$j] == $cs[$i]) {
            $j = $j + 1;
        }
        $out = $out + convert.toString($j - $i) + $cs[$i];
        $i = $j;
    }
    return $out;
}

func decode(s as string) {
    def out as string;
    for (def m in regex.findAll('([0-9]+)([A-Z])', $s)) {
        $out = $out + strings.replicate($m.groups[1], convert.toInt($m.groups[0]));
    }
    return $out;
}

def text as string init "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWBWWWWWWWWWWWWWW";
def packed as string init encode($text);
io.printf("%s\n", $packed);
io.printf("%t\n", decode($packed) == $text);
