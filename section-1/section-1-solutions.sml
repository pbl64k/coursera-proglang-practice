(* Positive Numbers *)
fun is_positive (x : int) = x > 0

(* Divisibility *)
fun is_divisible_by (a : int, b : int) = a mod b = 0

(* Integer Division *)
fun divide_by (a : int, b : int) =
    if a < b
    then 0
    else 1 + divide_by (a - b, b)

(* Greatest Common Divisor *)
fun gcd (a : int, b : int) =
    if a = b
    then a
    else
        if a < b
        then gcd (a, b - a)
        else gcd (a - b, b)

(* Least Common Multiple *)
fun lcm (a : int, b : int) = (a * b) div gcd (a, b)

(* Greatest Common Divisor -- Continued *)
fun gcd_list (numbers : int list) =
    if null (tl numbers)
    then hd numbers
    else gcd (hd numbers, gcd_list (tl numbers))

(* Element Of A List *)
fun any_divisible_by (numbers : int list, divisor : int) =
   not (null numbers orelse
   not (is_divisible_by (hd numbers, divisor) orelse
   any_divisible_by (tl numbers, divisor)))

(* Integer Division -- Continued *)
fun safe_divide_by (a : int, b : int) =
    if b = 0
    then NONE
    else SOME (a div b)

(* Lists And Tuples, Oh My! *)
fun unzip (pairs : (int * int) list) =
    if null pairs
    then ([], [])
    else
        let
            val tl_answer = unzip (tl pairs)
        in
            (#1 (hd pairs) :: #1 tl_answer, #2 (hd pairs) :: #2 tl_answer)
        end

(* BananaBanana *)
fun duplicate (words : string list) =
    if null words
    then []
    else hd words :: hd words :: duplicate (tl words)

(* BananaBanana -- Continued *)
fun repeats (word : string, number : int) =
    let
        fun helper (current_word : string, iteration : int) =
            if iteration > number
            then []
            else current_word :: helper (current_word ^ word, iteration + 1)
    in
        helper (word, 1)
    end

