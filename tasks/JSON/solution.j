use io;
use json;

def text as string init '{"name": "Rosetta Code", "tasks": 1363, "tags": ["wiki", "code"],
    "open": true}';

# Decode into an opaque json.Value, read by JSON Pointer.
def doc as json.Value init json.decode($text);
io.printf("%s\n", json.asString($doc, "/name"));
io.printf("%d\n", json.asInt($doc, "/tasks"));
io.printf("%s\n", json.asString($doc, "/tags/1"));
io.printf("%t\n", json.asBool($doc, "/open"));

# Encode: a struct becomes an object, its fields in declaration order.
def struct Language {
    name as string,
    appeared as int,
    sigils as list of string,
    typed as bool
};

def lang as Language init Language{name: "Jennifer", appeared: 2026, sigils: ["$"], typed: true};
io.printf("%s\n", json.encode($lang));
io.printf("%s\n", json.encodePretty($lang));

# Malformed input is an error, not a guess.
try {
    json.decode('{"a": 1, "a": 2}');
} catch (e) {
    io.printf("%s: %s\n", $e.kind, $e.message);
}
