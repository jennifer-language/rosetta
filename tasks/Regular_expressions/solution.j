use io;
use regex;

# RE2 syntax; raw '...' strings need no escaped backslashes.
def s as string init "I am a string";

if (regex.matches('string$', $s)) {
    io.printf("ends with 'string'\n");
}
if (not regex.matches('^You', $s)) {
    io.printf("does not start with 'You'\n");
}

io.printf("%s\n", regex.replace(' a ', $s, " another "));
io.printf("%s\n", regex.replace('(\w+) (\w+)', "hello world", '$2 $1'));

def m as regex.Match init regex.find('(\d+)-(\d+)', "pages 12-34");
io.printf("%s: from %s to %s\n", $m.text, $m.groups[0], $m.groups[1]);
