use convert;
use io;

def const SHADES as string init " .:-=+*#%@";

for (def row in 0..24) {
    def line as string;
    def y as float init 1.2 - convert.toFloat($row) * 0.1;
    for (def col in 0..78) {
        def x as float init -2.1 + convert.toFloat($col) * 0.04;
        def zr as float init 0.0;
        def zi as float init 0.0;
        def n as int init 0;
        while ($n < 50 and $zr * $zr + $zi * $zi <= 4.0) {
            def t as float init $zr * $zr - $zi * $zi + $x;
            $zi = 2.0 * $zr * $zi + $y;
            $zr = $t;
            $n = $n + 1;
        }
        def shade as int init $n * (len(SHADES) - 1) // 50;
        $line = $line + SHADES[$shade..$shade + 1];
    }
    io.printf("%s\n", $line);
}
