(* Back To The Future! *)

(* GCD -- Redux *)

(* provided helper function *)
fun gcd (a : int, b : int) =
    if a = b
    then a
    else
        if a < b
        then gcd (a, b - a)
        else gcd (a - b, b)

fun gcd_list numbers =
    case numbers of
        x :: [] => x
      | x :: numbers' => gcd (x, gcd_list numbers')
      (* not required, just to prevent SML/NJ from warning us about *)
      (* non-exhaustive patterns *)
      | _ => raise Empty

(* Element Of A List -- Redux *)

(* provided helper function *)
fun is_divisible_by (a : int, b : int) = a mod b = 0

fun any_divisible_by (numbers, divisor) =
    case numbers of
        [] => false
      | x :: numbers' => is_divisible_by (x, divisor) orelse
            any_divisible_by (numbers', divisor)

(* Quirky Addition -- Redux *)
fun add_opt param =
    case param of
        (SOME a, SOME b) => SOME (a + b)
      | _ => NONE

(* Quirky Addition -- Continued -- Redux *)
fun add_all_opt some_numbers =
    let
        fun helper param =
            case param of
                (acc, []) => acc
              | (SOME acc, SOME x :: some_numbers') => helper (SOME (acc + x), some_numbers')
              | (acc, NONE :: some_numbers') => helper (acc, some_numbers')
              | (_, acc :: some_numbers') => helper (acc, some_numbers')
    in
        helper (NONE, some_numbers)
    end

(* Flip Flop -- Redux *)
fun alternate numbers =
    let
        fun helper (factor, numbers) =
            case numbers of
                [] => 0
              | x :: numbers => factor * x + helper (~1 * factor, numbers)
    in
        helper (1, numbers)
    end

(* Minimum/Maximum -- Redux *)
fun min_max numbers =
    let
        fun helper (min, max, numbers) =
            case numbers of
                [] => (min, max)
              | x :: numbers => helper (
                    if x < min then x else min,
                    if x > max then x else max,
                    numbers)
    in
        case numbers of
            x :: numbers => helper (x, x, numbers)
          (* Could've simply used a pattern match in let binding -- *)
          (* we know the list is not going to be empty *)
          | [] => raise Empty
    end

(* Lists And Tuples, Oh My! -- Redux *)
fun unzip pairs =
    case pairs of
        [] => ([], [])
      | (left, right) :: rest =>
            let
                val (tail_left, tail_right) = unzip rest
            in
                (left :: tail_left, right :: tail_right)
            end

(* BBCA -- Redux *)
exception ListLengthMismatch

fun repeats_list param =
    case param of
        ([], []) => []
      | (_ :: elems, 0 :: reps) => repeats_list (elems, reps)
      | (x :: elems, n :: reps) => x :: repeats_list (x :: elems, n - 1 :: reps)
      (* Again, this is optional *)
      | _ => raise ListLengthMismatch

