# Practice Problems for Section 1

## Positive Numbers

Write a function `is_positive` that takes an integer number and
evaluates to `true` or `false`. The function should evaluate to
`true` if its argument is a positive number, and to `false`
otherwise.

**SIGNATURE:** `val is_positive = fn : int -> bool`

**EXAMPLE:** `is_positive 1 = true`

## Divisibility

Write a function `is_divisible_by` that takes two integer
numbers and evaluates to `true` or `false`. It should evaluate
to `true` if its first argument is divisible by its second
argument, and to `false` otherwise. You may assume that the
second argument will be non-zero.

**SIGNATURE:** `val is_divisible_by = fn : int * int -> bool`

**EXAMPLE:** `is_divisible_by (6, 3) = true`

## Integer Division

Write a function `divide_by` that takes two integer numbers and
evaluates to the result of the integer division of the first
one by the second one. You may assume that the first argument
is non-negative and the second one is strictly positive. You
should not use the `div` operator.

**HINT:** Recall the `pow` function in the lectures.

**SIGNATURE:** `val divide_by = fn : int * int -> int`

**EXAMPLE:** `divide_by (7, 3) = 2`

## Greatest Common Divisor

Write a function `gcd` that takes two integer numbers and
evaluates to their greatest common divisor. Use the Euclidean
algorithm:

http://en.wikipedia.org/wiki/Greatest_common_divisor

You may assume that both numbers are positive.

**SIGNATURE:** `val gcd = fn : int * int -> int`

**EXAMPLE:** `gcd (18, 12) = 6`

## Least Common Multiple

Write a function `lcm` that takes two integer numbers and
evaluates to their least common multiple. LCM can be defined
in terms of GCD:

http://en.wikipedia.org/wiki/Least_common_multiple

You may assume that both numbers are positive.

**SIGNATURE:** `val lcm = fn : int * int -> int`

**EXAMPLE:** `lcm (18, 12) = 36`

## Greatest Common Divisor -- Continued

Write a function `gcd_list` that takes a list of integers and
evaluates to their GCD. GCD of a set of numbers can be defined
in terms of binary GCD:
$$\gcd(a_1, \dots, a_n) = \gcd(a_1, \gcd(a_2, \gcd(a_3, \dots)))$$
You may assume that the list is non-empty and all the numbers
on the list are positive.

**SIGNATURE:** `val gcd_list = fn : int list -> int`

**EXAMPLE:** `gcd [18, 12, 3] = 3`

## Element Of A List

Write a function `any_divisible_by` that takes a list of
integers and a divisor (an integer number) and evaluates to
either `true` or `false`. The function should evaluate to
`true` if any of the numbers on the list are divisible by the
function's second argument.

**SIGNATURE:** `val any_divisible_by = fn : int list * int -> bool`

**EXAMPLE:** `any_divisible_by ([13, 1, 20], 5) = true`

## Integer Division -- Continued

Write a function `safe_divide_by` that takes two integer
numbers and evaluates to an `int option`. If the second
argument is non-zero, the function should evaluate to `SOME`
$$x$$ where $$x$$ is the result of the integer division of the
first argument by the second one, otherwise it should evaluate
to `NONE`. You may and should use the `div` operator for this
problem.

**SIGNATURE:** `val safe_divide_by = fn : int * int -> int option`

**EXAMPLE:** `safe_divide_by (7, 3) = SOME 2`

## Lists And Tuples, Oh My!

Write a function `unzip` that takes an `(int * int) list` and
evaluates to `int list * int list` such that the first element
of the resulting tuple is a list consisting of all first
elements of the argument (in order), and the second element of
the result consists of all second elements of the tuples in
the original list.

**HINT:** There are several approaches to this, some of which could
be directly based on the code in the lectures.

**SIGNATURE:** `val unzip = fn : (int * int) list -> int list * int list`

**EXAMPLE:** `unzip [(1, 2), (3, 4), (5, 6)] = ([1, 3, 5], [2, 4, 6])`

## BananaBanana

Write a function `duplicate` that takes a `string list` and
evaluates to another `string list`, consisting of the elements
of the original list, in the same order, but with each one
repeated twice.

**SIGNATURE:** `val duplicate = fn : string list -> string list`

**EXAMPLE:** `duplicate ["a", "bc", "def"] = ["a", "a", "bc", "bc", "def", "def"]`

## BananaBanana -- Continued

Write a function `repeats` that takes a string and an integer
number $$n$$ and evaluates to a `string list` consisting of
$$n$$ elements. The first element must be equal to the first
argument of the function, the second one must be equal to the
first argument repeated twice, the third one will be the
argument repeated three times etc. You will need to use the
string concatenation operator `^`. You may assume that the
second argument is non-negative.

**SIGNATURE:** `val repeats = fn : string * int -> string list`

**EXAMPLE:** `repeats ("banana", 2) = ["banana", "bananabanana"]`

