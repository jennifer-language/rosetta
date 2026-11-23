use convert;
use io;
use regex;
use strings;

# Two integers from standard input, separated by whitespace (spaces or line
# breaks). Anything else is an error, as is a number outside -1000 to 1000.
def text as string init strings.trim(strings.join(io.readLines(), " "));
def parts as list of string init regex.split('\s+', $text);
if (len($parts) != 2) {
    throw Error{kind: "value", message: "expected two integers, got {len($parts)} items"};
}
def sum as int init 0;
for (def part in $parts) {
    def n as int init convert.toInt($part);
    if ($n < -1000 or $n > 1000) {
        throw Error{kind: "value", message: "{$n} is outside -1000 to 1000"};
    }
    $sum = $sum + $n;
}
io.printf("%d\n", $sum);
