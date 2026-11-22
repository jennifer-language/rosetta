use convert;
use io;
use strings;

# Letters A to Z and a to z move `key` places on, wrapping round; everything
# else is left as it is. The key is 1 to 25, and decoding is encoding with
# 26 - key.
func encode(text as string, key as int) {
    if ($key < 1 or $key > 25) {
        throw Error{kind: "value", message: "the key is 1 to 25, got {$key}"};
    }
    def out as list of string;
    for (def c in strings.chars($text)) {
        def code as int init convert.toCodepoint($c);
        def base as int init -1;
        if ($code >= 65 and $code <= 90) {
            $base = 65;
        } elseif ($code >= 97 and $code <= 122) {
            $base = 97;
        }
        if ($base < 0) {
            $out[] = $c;
        } else {
            $out[] = convert.fromCodepoint($base + ($code - $base + $key) % 26);
        }
    }
    return strings.join($out);
}

func decode(text as string, key as int) {
    return encode($text, 26 - $key);
}

io.printf("%s %s\n", encode("HI", 2), encode("HI", 20));
def plain as string init "The quick brown fox jumps over the lazy dog.";
def secret as string init encode($plain, 11);
io.printf("%s\n%s\n%s\n", $plain, $secret, decode($secret, 11));
try {
    encode($plain, 26);
} catch (e) {
    io.printf("%s: %s\n", $e.kind, $e.message);
}
