use io;
use time;

def now as time.Time init time.now();
io.printf("%s\n", time.format($now, "%Y-%m-%d"));

# %d pads the day to two digits; the long form wants it bare.
def weekday as string init time.format($now, "%A");
def month as string init time.format($now, "%B");
io.printf("%s, %s %d, %d\n", $weekday, $month, time.day($now), time.year($now));
