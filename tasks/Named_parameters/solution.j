use io;

# Arguments are positional. A struct literal names its fields, in any
# order, so a struct parameter gives named arguments; every field must be
# given (no defaults; see Optional parameters for those).
def struct Rect {
    width as int,
    height as int,
    label as string
};

func describe(r as Rect) {
    io.printf("%s: %d x %d\n", $r.label, $r.width, $r.height);
}

describe(Rect{width: 3, height: 4, label: "A"});
describe(Rect{label: "B", height: 2, width: 5});
