use io;

# Lists hold one element type, so an arbitrarily nested list is a
# recursive enum: an item is a number or a list of items.
def enum Item {
    Num{v as int},
    Nest{items as list of Item}
};

# The recursive calls thread the list through as $out = flatten(..., $out),
# which updates it in place inside a function.
func flatten(item as Item, out as list of int) { # lint-disable: L205
    match ($item) {
        when Num(num) { $out[] = $num.v; }
        when Nest(nest) {
            for (def i in $nest.items) {
                $out = flatten($i, $out);
            }
        }
    }
    return $out;
}

func n(v as int) {
    return Item.Num{v: $v};
}

func l(items as list of Item) {
    return Item.Nest{items: $items};
}

# [[1], 2, [[3, 4], 5], [[[]]], [[[6]]], 7, 8, []]
def input as Item init l([
    l([n(1)]),
    n(2),
    l([l([n(3), n(4)]), n(5)]),
    l([l([l([])])]),
    l([l([l([n(6)])])]),
    n(7),
    n(8),
    l([])
]);
io.printf("%a\n", flatten($input, []));
