use io;
use lists;
use regex;
use strings;

# Exact: the characters (Unicode code points) read the same both ways.
func isPalindrome(s as string) {
    def cs as list of string init strings.chars($s);
    return $cs == lists.reverse($cs);
}

# Inexact: the same, ignoring case and everything but letters and digits.
func isInexactPalindrome(s as string) {
    return isPalindrome(strings.lower(regex.replace('[^\p{L}\p{N}]', $s, "")));
}

for (def s in [
    "racecar",
    "rosetta",
    "été",
    "A man, a plan, a canal: Panama!",
    "ΝΙΨΟΝ ΑΝΟΜΗΜΑΤΑ ΜΗ ΜΟΝΑΝ ΟΨΙΝ"
]) {
    def exact as bool init isPalindrome($s);
    def inexact as bool init isInexactPalindrome($s);
    io.printf("%s: exact %v, inexact %v\n", $s, $exact, $inexact);
}
