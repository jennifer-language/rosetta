use io;
use lists;

def struct Pair {
    name as string,
    value as string
};

func nameOf(p as Pair) {
    return $p.name;
}

def pairs as list of Pair init [
    Pair{name: "Joe", value: "5531"},
    Pair{name: "Adam", value: "2341"},
    Pair{name: "Bernie", value: "122"},
    Pair{name: "Walter", value: "1234"},
    Pair{name: "David", value: "19"}
];

for (def p in lists.sortBy($pairs, nameOf)) {
    io.printf("%s %s\n", $p.name, $p.value);
}
