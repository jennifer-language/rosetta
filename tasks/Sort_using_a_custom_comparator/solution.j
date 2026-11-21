use io;
use lists;
use strings;

# lists.sortBy takes a key function, not a comparator, and a key is one
# string or number. Descending length, then case-insensitive ascending, as
# one string key: the length, complemented and zero-padded, then the folded
# word.
func key(s as string) {
    def n as string init io.sprintf("%d|pad=6|fill=0", 999999 - len($s));
    return $n + strings.lower($s);
}

def words as list of string init strings.split("here are Some sample strings to be sorted", " ");
io.printf("%a\n", lists.sortBy($words, key));
