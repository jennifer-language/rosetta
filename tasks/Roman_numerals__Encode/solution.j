use io;

def const VALUES as list of int init [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
def const SYMBOLS as list of string init [
    "M",
    "CM",
    "D",
    "CD",
    "C",
    "XC",
    "L",
    "XL",
    "X",
    "IX",
    "V",
    "IV",
    "I"
];

func roman(n as int) {
    if ($n < 1) {
        throw Error{kind: "value", message: "not a positive integer: {$n}"};
    }
    def out as string;
    for (def i in 0..len(VALUES)) {
        while ($n >= VALUES[$i]) {
            $out = $out + SYMBOLS[$i];
            $n = $n - VALUES[$i];
        }
    }
    return $out;
}

for (def n in [1990, 2008, 1666, 4, 3999]) {
    io.printf("%d %s\n", $n, roman($n));
}
