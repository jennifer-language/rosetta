use io;
use lists;

# A stack of ints over a list. Without generic types it is written for one
# element type. pop returns the element and the shorter stack, since an
# argument is a copy: the caller assigns the stack back.
def struct Stack {
    items as list of int
};

def struct Popped {
    value as int,
    rest as Stack
};

func push(s as Stack, v as int) { # lint-disable: L205
    $s.items[] = $v;
    return $s;
}

func pop(s as Stack) {
    if (empty($s)) {
        throw Error{kind: "value", message: "pop from an empty stack"};
    }
    return Popped{value: lists.last($s.items), rest: Stack{items: lists.pop($s.items)}};
}

func empty(s as Stack) {
    return len($s.items) == 0;
}

def s as Stack;
$s = push($s, 1);
$s = push($s, 2);
$s = push($s, 3);
while (not empty($s)) {
    def p as Popped init pop($s);
    io.printf("%d\n", $p.value);
    $s = $p.rest;
}
io.printf("empty: %t\n", empty($s));
