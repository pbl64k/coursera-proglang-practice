(** High-Order Fun **)

(* There Can Be Only One *)

fun fold_map f = List.foldr (fn (x, acc) => f x :: acc) []

fun fold_filter p = List.foldr (fn (x, acc) => if p x then x :: acc else acc) []

(* The Evil Twin *)

fun unfold f state =
    case f state of
        NONE => []
      | SOME (state', x) => x :: unfold f state'

(* A Novel Approach *)

fun factorial n = List.foldl (op * ) 1 (unfold (fn x => if x > n then NONE else SOME (x + 1, x)) 1)

(* Answer to bonus question: No. Simple tail-recursive
   factorial works in constant space, while unfold here
   constructs a list of size n. In later sessions we
   will study a data structure that would make
   virtually the same implementation efficient. *)

