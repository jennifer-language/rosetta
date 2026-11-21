# Pending

Solutions that cannot be posted yet: the task asks for something Jennifer
does not have. `tools/check.sh` does not run them. Each moves to `tasks/`
once the blocker lands.

| Task | Blocked by |
|---|---|
| Arbitrary-precision integers (included) | `decimal` refuses results over 100,000 digits; 5^4^3^2 has 183,231 |
| Function composition | `compose` must return a function: needs closures (DRAFT#28). The solution here returns a pair and applies it |

Not attempted, for the same reason (closures, DRAFT#28): Closures/Value
capture, Accumulator factory, Currying, Partial function application,
Y combinator.
