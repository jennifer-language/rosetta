use io;
use strings;

def s as string init "alphaBETA";
io.printf("%s\n", strings.upper($s));
io.printf("%s\n", strings.lower($s));

# Not in the core on purpose: the @mplx/texttransform deck has case=title and case=swap.
func capitalize(s as string) {
    if ($s == "") {
        return $s;
    }
    return strings.upper($s[0..1]) + strings.lower($s[1..]);
}

func swapCase(s as string) {
    def out as string;
    for (def c in strings.chars($s)) {
        if (strings.upper($c) == $c) {
            $out = $out + strings.lower($c);
        } else {
            $out = $out + strings.upper($c);
        }
    }
    return $out;
}

io.printf("%s\n", capitalize($s));
io.printf("%s\n", swapCase($s));

# upper and lower are Unicode-aware; fold drops Latin diacritics, keeping case.
io.printf("%s %s\n", strings.upper("straße"), strings.fold("Größe"));
