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

(* Quirky Addition *)
fun add_opt (a : int option, b : int option) =
    if isSome a andalso isSome b
    then SOME (valOf a + valOf b)
    else NONE

(* Quirky Addition -- Continued *)
fun add_all_opt (some_numbers : int option list) =
    let
        fun helper (acc : int option, some_numbers : int option list) =
            if null some_numbers
            then acc
            else
                if isSome acc
                then
                    if isSome (hd some_numbers)
                    then helper (SOME (valOf acc + valOf (hd some_numbers)), tl some_numbers)
                    else helper (acc, tl some_numbers)
                else helper (hd some_numbers, tl some_numbers)
    in
        helper (NONE, some_numbers)
    end

(* Flip Flop *)
fun alternate (numbers : int list) =
    let
        fun helper (factor : int, numbers : int list) =
            if null numbers
            then 0
            else (factor * hd numbers) + helper (~1 * factor, tl numbers)
    in
        helper (1, numbers)
    end

(* Minimum/Maximum *)
fun min_max (numbers : int list) =
    let
        fun helper (min : int, max : int, numbers : int list) =
            if null numbers
            then (min, max)
            else
                helper (
                    if hd numbers < min then hd numbers else min,
                    if hd numbers > max then hd numbers else max,
                    tl numbers)
    in
        helper (hd numbers, hd numbers, tl numbers)
    end

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

(* Lists And Tuples, Oh My! -- Continued (1) *)
fun zip (xs : int list, ys : int list) =
    if null xs orelse null ys
    then []
    else (hd xs, hd ys) :: zip (tl xs, tl ys)

(* Helper function for the following two problems *)
fun list_length (numbers : int list) =
    if null numbers
    then 0
    else 1 + list_length (tl numbers)

(* Lists And Tuples, Oh My! -- Continued (2) *)
fun zip_recycle (xs : int list, ys : int list) =
    let
        val xs_len = list_length xs
        val ys_len = list_length ys
        fun list_cycle (n : int, numbers : int list) =
            let
                fun helper (n : int, xs : int list) =
                    if n = 0
                    then []
                    else hd xs :: helper (n - 1, if null (tl xs) then numbers else tl xs)
            in
                helper (n, numbers)
            end
    in
        if xs_len > 0 andalso ys_len > 0
        then
            if xs_len = ys_len
            then zip (xs, ys)
            else
                if xs_len < ys_len
                then zip (list_cycle (ys_len, xs), ys)
                else zip (xs, list_cycle (xs_len, ys))
        else []
    end

(* Lists And Tuples, Oh My! -- Continued (3) *)
fun zip_opt (xs : int list, ys : int list) =
    if list_length xs = list_length ys
    then SOME (zip (xs, ys))
    else NONE

(* BananaBanana *)
fun duplicate (words : string list) =
    if null words
    then []
    else hd words :: hd words :: duplicate (tl words)

(* Greetings, Earthlings! *)
fun greeting (some_name : string option) =
    "Hello there, " ^
    (if isSome some_name
    then valOf some_name
    else "you")
    ^ "!"

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

(* BananaBanana -- Continued (Again) *)
fun repeats_list (strings : string list, reps : int list) =
    if null strings
    then []
    else
        if hd reps <> 0
        then hd strings :: repeats_list (strings, (hd reps - 1) :: tl reps)
        else repeats_list (tl strings, tl reps)

