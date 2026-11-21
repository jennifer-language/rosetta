use io;

func permutations(xs as list of int) {
    def out as list of list of int;
    if (len($xs) <= 1) {
        $out[] = $xs;
        return $out;
    }
    for (def i in 0..len($xs)) {
        def rest as list of int init $xs[..$i];
        for (def x in $xs[$i + 1..]) {
            $rest[] = $x;
        }
        for (def p in permutations($rest)) {
            def perm as list of int init [$xs[$i]];
            for (def x in $p) {
                $perm[] = $x;
            }
            $out[] = $perm;
        }
    }
    return $out;
}

for (def p in permutations([1, 2, 3])) {
    io.printf("%a\n", $p);
}
