use io;
use lists;
use regex;
use strings;

# Strings index by rune (code point), so this reverses code points.
func reverse(s as string) {
    return strings.join(lists.reverse(strings.chars($s)), "");
}

# Extra credit: keep each combining mark with the base it modifies. A
# cluster is a non-mark followed by marks: \P{M}\p{M}* in RE2's syntax.
func reverseCombining(s as string) {
    def clusters as list of string;
    for (def m in regex.findAll('\P{M}\p{M}*', $s)) {
        $clusters[] = $m.text;
    }
    return strings.join(lists.reverse($clusters), "");
}

io.printf("%s\n", reverse("asdf"));
io.printf("%s\n", reverse("as\u20DDdf\u0305"));
io.printf("%s\n", reverseCombining("as\u20DDdf\u0305"));
