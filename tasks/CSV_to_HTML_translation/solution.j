use io;
use strings;

import "csv.j";
import "html.j";

def data as string init strings.join(
    [
        "Character,Speech",
        "The multitude,The messiah! Show us the messiah!",
        "Brians mother,<angry>Now you listen here! He's not the messiah; " +
            "he's a very naughty boy! Now go away!</angry>",
        "The multitude,Who are you?",
        "Brians mother,I'm his mother; that's who!",
        "The multitude,Behold his mother! Behold his mother!"
    ],
    "\n");

func row(cells as list of string, tag as string) {
    def out as string init "    <tr>";
    for (def c in $cells) {
        def text as string init html.escape($c);
        $out = $out + "<{$tag}>{$text}</{$tag}>";
    }
    return $out + "</tr>\n";
}

# Extra credit: the first row is the header.
func csvToHtml(text as string) {
    def rows as list of list of string init csv.parse($text);
    def out as string init "<table>\n  <thead>\n";
    $out = $out + row($rows[0], "th");
    $out = $out + "  </thead>\n  <tbody>\n";
    for (def r in $rows[1..]) {
        $out = $out + row($r, "td");
    }
    return $out + "  </tbody>\n</table>\n";
}

io.printf("%s", csvToHtml($data));
