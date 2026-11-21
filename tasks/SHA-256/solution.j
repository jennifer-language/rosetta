use encoding;
use hash;
use io;

def data as bytes init encoding.encode("utf-8", "Rosetta code");
io.printf("%s\n", encoding.toText("hex", hash.compute("sha256", $data)));
