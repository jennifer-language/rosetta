use io;

def open as list of bool;
for (def i in 0..101) {
    $open[] = false;
}
for (def pass in 1..101) {
    for (def door as int init $pass; $door <= 100; $door = $door + $pass) {
        $open[$door] = not $open[$door];
    }
}
def result as list of int;
for (def door in 1..101) {
    if ($open[$door]) {
        $result[] = $door;
    }
}
io.printf("open: %a\n", $result);
