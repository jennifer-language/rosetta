use io;
use math;

# Jennifer has function values but no closures yet, so compose cannot return
# a new function. It returns the pair instead, and apply runs it. Library
# functions are not values either: math.sin is wrapped in a function.
def struct Composed {
    f as func,
    g as func
};

func compose(f as func, g as func) {
    return Composed{f: $f, g: $g};
}

func apply(c as Composed, x as float) {
    return $c.f($c.g($x));
}

func sin(x as float) {
    return math.sin($x);
}

func asin(x as float) {
    return math.asin($x);
}

def sinAsin as Composed init compose(sin, asin);
io.printf("%v\n", apply($sinAsin, 0.5));
