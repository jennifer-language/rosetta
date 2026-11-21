use io;

import "http.j";

def resp as http.Response init http.get("http://example.com/", {});
io.printf("%s", $resp.body);
