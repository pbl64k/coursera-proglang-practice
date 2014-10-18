# Practice Problems for Section 3

## High-Order Fun

### There Can Be Only One

Write functions `fold_map` and `fold_filter` that have the
same signatures as `List.map` and `List.filter`
correspondingly. Use `List.foldr`. Do not use pattern
matching or any other list functions.

**SIGNATURE:** `val fold_map = fn : ('a -> 'b) -> 'a list -> 'b list`

**EXAMPLE:** `fold_map (fn x => x + 1) [1, 2, 3, 4, 5] = [2, 3, 4, 5, 6]`

**SIGNATURE:** `val fold_filter = fn : ('a -> bool) -> 'a list -> 'a list`

**EXAMPLE:** `fold_filter (fn x => x mod 2 = 0) [1, 2, 3, 4, 5] = [2, 4]`

### The Evil Twin

Write a function `unfold` that takes a state transition
function and an initial state and produces a list. On each
step the current state is feed into a state transition
function, which evaluates either to `NONE`, indicating that
the result should contain no more elements, or `SOME`
$$pair$$, where contains the next state and the next list
element.

**SIGNATURE:** `val unfold = fn : ('a -> ('a * 'b) option) -> 'a -> 'b list`

**EXAMPLE:** `unfold (fn x => if x > 3 then NONE else SOME (x + 1, x)) 0 = [0, 1, 2, 3]`

## Back To The Future! 2

(*) Problems contributed by Charilaos Skiadas.

