use encoding;
use io;

import "http.j";

def resp as http.BytesResponse init http.getBytes("https://rosettacode.org/favicon.ico", {});
if ($resp.status != 200) {
    throw Error{kind: "http", message: "favicon: HTTP {$resp.status}"};
}
io.printf("%s\n", encoding.toText("base64", $resp.body));
