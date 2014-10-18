# Practice Problems for Section 3

## High-Order Fun

### There Can Be Only One

Write functions `fold_map` and `fold_filter` that have the
same signatures and behavior as `List.map` and `List.filter`
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

### A Novel Approach

Write a function `factorial` that takes an integer number
$$n$$ and evaluates to $$n!$$. You function should be
a composition of `unfold` and `List.foldl`. You should not
use any other list functions, recursion or pattern matching.

**BONUS QUESTION:** Is this function as good as a simple
tail-recursive factorial implementation?

**SIGNATURE:** `val factorial = fn : int -> int`

**EXAMPLE:** `factorial 4 = 24`

### Deeper Into The Woods

Let's reuse the binary tree data structure from practice
problems for section 2:

    datatype 'a tree = leaf | node of { value : 'a, left : 'a tree, right : 'a tree }

Write functions `tree_fold` and `tree_unfold` that would
serve as equivalents of `fold` and `unfold` on lists for this
data structure.

**HINT:** This is a hard problem, but consider this: the
initial value for `fold` corresponds to the base case of
recursion on lists (i.e., matching `[]`), while the function
passed to the `fold` corresponds to the case when we match
on `::`. `[]` and `::` correspond to `leaf` and `node` data
constructors. Similar reasoning applies to `unfold`. You might
also want to meditate over the signatures below if this does
not provide sufficient insight.

**SIGNATURE:** `val tree_fold = fn : ('a * 'b * 'a -> 'a) -> 'a -> 'b tree -> 'a`

**EXAMPLE:** `tree_fold (fn (l, v, r) => l ^ v ^ r) "!" (node { value = "foo", left = node { value = "bar", left = leaf, right = leaf }, right = node { value = "baz", left = leaf, right = leaf }}) = "!bar!foo!baz!"`

**SIGNATURE:** `val tree_unfold = fn : ('a -> ('a * 'b * 'a) option) -> 'a -> 'b tree`

**EXAMPLE:** `tree_unfold (fn x => if x = 0 then NONE else SOME (x - 1, x, x - 1)) 2 = node { value = 2, left = node { value = 1, left = leaf, right = leaf }, right = node { value = 1, left = leaf, right = leaf }}`

## Back To The Future! 2

(*) Problems contributed by Charilaos Skiadas.

