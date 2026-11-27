use convert;
use decimal;
use io;

# Big integers are scale-0 decimals. 4^(3^2) = 262144 fits in int.
def exp as int init 1;
for (def i in 0..9) {
    $exp = $exp * 4;
}
def s as string init convert.toString(decimal.pow(5, $exp));
io.printf("%s...%s, %d digits\n", $s[0..20], $s[len($s) - 20..], len($s));
