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

