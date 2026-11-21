use io;
use strings;

def enum Tree {
    Leaf,
    Node{v as int, left as Tree, right as Tree}
};

func node(v as int, left as Tree, right as Tree) {
    return Tree.Node{v: $v, left: $left, right: $right};
}

func leaf(v as int) {
    return node($v, Tree.Leaf, Tree.Leaf);
}

# $out = walk(..., $out) inside a function updates the list in place.
func walk(t as Tree, order as string, out as list of string) { # lint-disable: L205
    match ($t) {
        when Leaf {
        }
        when Node(nd) {
            if ($order == "pre") {
                $out[] = "{$nd.v}";
            }
            $out = walk($nd.left, $order, $out);
            if ($order == "in") {
                $out[] = "{$nd.v}";
            }
            $out = walk($nd.right, $order, $out);
            if ($order == "post") {
                $out[] = "{$nd.v}";
            }
        }
    }
    return $out;
}

func levelOrder(t as Tree) {
    def out as list of string;
    def queue as list of Tree init [$t];
    def head as int init 0;
    while ($head < len($queue)) {
        # match destructures a variable whose type is known, not an index.
        def t2 as Tree init $queue[$head];
        match ($t2) {
            when Leaf {
            }
            when Node(nd) {
                $out[] = "{$nd.v}";
                $queue[] = $nd.left;
                $queue[] = $nd.right;
            }
        }
        $head = $head + 1;
    }
    return $out;
}

def tree as Tree init node(
    1,
    node(2, node(4, leaf(7), Tree.Leaf), leaf(5)),
    node(3, node(6, leaf(8), leaf(9)), Tree.Leaf));

io.printf("preorder:    %s\n", strings.join(walk($tree, "pre", []), " "));
io.printf("inorder:     %s\n", strings.join(walk($tree, "in", []), " "));
io.printf("postorder:   %s\n", strings.join(walk($tree, "post", []), " "));
io.printf("level-order: %s\n", strings.join(levelOrder($tree), " "));
