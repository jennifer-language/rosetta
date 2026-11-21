use io;

# No classes or methods: data is a struct or an enum, behaviour a function.
# The polymorphic print dispatches with match over an enum of shapes.
# Copying is assignment (value semantics); there are no destructors.
def struct Point {
    x as float,
    y as float
};

def enum Shape {
    Dot{at as Point},
    Circle{at as Point, r as float}
};

func show(s as Shape) {
    match ($s) {
        when Dot(d) { io.printf("Point(%v, %v)\n", $d.at.x, $d.at.y); }
        when Circle(c) { io.printf("Circle(%v, %v, %v)\n", $c.at.x, $c.at.y, $c.r); }
    }
}

def origin as Point;
def shapes as list of Shape init [
    Shape.Dot{at: $origin},
    Shape.Dot{at: Point{x: 1.5, y: 2.0}},
    Shape.Circle{at: Point{x: 3.0, y: 4.0}, r: 5.0}
];
for (def s in $shapes) {
    show($s);
}

def copy as Shape init $shapes[2];
show($copy);
