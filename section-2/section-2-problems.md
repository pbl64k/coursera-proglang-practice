# Practice Problems for Section 2

## 38 Cons Cells (*)

## Forest For The Trees

## Back To The Future!

A few of the practice problems from Section 1 can be rewritten
more elegantly using the material from Section 2. All problem
statements, **SIGNATURES** and **EXAMPLES** remain the same, if
there are any additional considerations, these will be
mentioned below. Only some of the potentially eligible problems
are included -- naturally, you're welcome to rewrite the rest
on your own, using similar approaches.

### GCD -- Redux

Write a function `gcd_list` following the specification from
Section 1's **Greated Common Divisor -- Continued** problem.
Use pattern matching instead of list functions. Use the
following implementation of `gcd` as a helper function:

    fun gcd (a : int, b : int) =
        if a = b
        then a
        else
            if a < b
            then gcd (a, b - a)
            else gcd (a - b, b)

### Element Of A List -- Redux

Write a function `any_divisible_by` following the
specification from Section 1's **Element Of A List** problem.
Use pattern matching instead of list functions. Use the
following implementation of `is_divisible_by` as a helper
function:

    fun is_divisible_by (a : int, b : int) = a mod b = 0

### Quirky Addition -- Redux

Write a function `add_opt` following the specification from
Section 1's **Quirky Addition** problem. Use pattern matching
instead of option functions. You may and should use option
constructors.

### Quirky Addition -- Continued -- Redux

Write a function `add_all_opt` following the specification
from Section 1's **Quirky Addition -- Continued** problem. Use
pattern matching instead of list and option functions.

### Flip Flop -- Redux

Write a function `alternate` following the specification from
Section 1's **Flip Flop** problem. Use pattern matching
instead of list functions.

### Minimum/Maximum -- Redux

Write a function `min_max` following the specification from
Section 1's **Minimum/Maximum** problem. Use pattern matching
instead of list functions.

### Lists And Tuples, Oh My! - Redux

Write a function `unzip` following the specification from
Section 1's **Lists And Tuples, Oh My!** problem. Use pattern
matching instead of list functions.

**NOTE:** The type of your function is probably going to be
more general that the one specified in the original problem.
That's totally fine -- awesome, actually!

### BBCA -- Redux

Write a function `repeats_list` following the specification
from Section 1's **BananaBanana -- Continued (Again)**
problem. Use pattern matching instead of list functions.

**NOTE:** The type of your function is probably going to be
more general that the one specified in the original problem.
That's totally fine -- awesome, actually!

(*) The author of this problem apologizes for using an obscure
cultural reference that is unlikely to be understood by anyone
who does not speak his native language as a title for this
problem. Couldn't resist the temptation.

