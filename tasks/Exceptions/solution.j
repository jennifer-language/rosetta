use io;

# throw takes any value. The convention is the built-in Error struct
# {kind, message, file, line, col}; throw fills in the location.
func checkAge(age as int) {
    if ($age < 0) {
        throw Error{kind: "value", message: "age {$age} is negative"};
    }
    return $age;
}

try {
    checkAge(-3);
} catch (e) {
    io.printf("caught %s at line %d: %s\n", $e.kind, $e.line, $e.message);
}

# Errors the runtime raises are caught the same way.
try {
    def xs as list of int init [1, 2, 3];
    io.printf("%d\n", $xs[5]);
} catch (e) {
    io.printf("caught %s: %s\n", $e.kind, $e.message);
}

# A struct of your own carries data. Match on the kind, never on the message.
def struct HttpError {
    kind as string,
    message as string,
    status as int
};

func fetch(path as string) {
    if ($path != "/") {
        throw HttpError{kind: "http", message: "not found: {$path}", status: 404};
    }
    return "home";
}

try {
    fetch("/missing");
} catch (e) {
    if ($e.kind != "http") {
        throw $e;
    }
    def he as HttpError init $e;
    io.printf("caught %s, status %d\n", $he.kind, $he.status);
}

# defer runs on every way out of a block; errdefer only on an error.
func work() {
    defer io.printf("cleanup\n");
    errdefer io.printf("undo\n");
    throw Error{kind: "work", message: "failed"};
}

try {
    work();
} catch (e) {
    io.printf("caught %s: %s\n", $e.kind, $e.message);
}
