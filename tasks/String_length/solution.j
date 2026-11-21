use convert;
use io;
use regex;

# len counts characters (code points) of a string and bytes of bytes.
func show(s as string) {
    def b as bytes init convert.bytesFromString("utf-8", $s);
    # Graphemes, approximately: a character with the combining marks after it.
    def g as int init len(regex.findAll('\P{M}\p{M}*', $s));
    io.printf("%s: %d characters, %d UTF-8 bytes, %d graphemes\n", $s, len($s), len($b), $g);
}

show("møøse");
show("\U0001D518\U0001D52B\U0001D526\U0001D520\U0001D52C\U0001D521\U0001D522");
show("J̲o̲s̲é̲");
