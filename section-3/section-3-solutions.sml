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
val factorial = (List.foldl (op * ) 1) o (unfold (fn x => if x = 0 then NONE else SOME (x - 1, x)))

(* Answer to bonus question: No. Simple tail-recursive
   factorial works in constant space, while unfold here
   constructs a list of size n. In later sessions we
   will study a data structure that would make
   virtually the same implementation efficient. *)

(* Unforeseen Developments *)
fun unfold_map f =
    let
        fun helper param =
            case param of
                [] => NONE
              | x :: xs => SOME (xs, f x)
    in
        unfold helper
    end

(* So Imperative *)
fun do_until f p x =
    if p x
    then x
    else do_until f p (f x)

(* Yet Another Factorial *)
fun imp_factorial n = #1 (do_until (fn (acc, x) => (acc * x, x - 1)) (fn (_, x) => x = 0) (1, n))

(* Fixed Point *)
fun fixed_point f = do_until f (fn x => f x = x)

(* Newton's Method *)
fun my_sqrt n =
    let
        fun fixed_point f = do_until f (fn x => abs (f x - x) < 0.0001)
    in
        fixed_point (fn x => 0.5 * (x + n / x)) n
    end

(* Deeper into the woods *)

(* provided definition *)
datatype 'a tree = leaf | node of { value : 'a, left : 'a tree, right : 'a tree }

fun tree_fold f base t =
    case t of
        leaf => base
      | node { value = value, left = left, right = right } => f (tree_fold f base left, value, tree_fold f base right)

fun tree_unfold f state =
    case f state of
        NONE => leaf
      | SOME (lstate, value, rstate) => node { value = value, left = tree_unfold f lstate, right = tree_unfold f rstate }

(** A Grand Challenge **)

(* provided definitions *)
datatype expr = literal_bool | literal_int | binary_bool_op of expr * expr | binary_int_op of expr * expr | comparison of expr * expr | conditional of expr * expr * expr
datatype expr_type = type_bool | type_int

exception TypeError

fun infer_type expr =
    case expr of
        literal_bool => type_bool
      | literal_int => type_int
      | binary_bool_op (x1, x2) =>
            if infer_type x1 = type_bool andalso infer_type x2 = type_bool
            then type_bool
            else raise TypeError
      | binary_int_op (x1, x2) =>
            if infer_type x1 = type_int andalso infer_type x2 = type_int
            then type_int
            else raise TypeError
      | comparison (x1, x2) =>
            if infer_type x1 = type_int andalso infer_type x2 = type_int
            then type_bool
            else raise TypeError
      | conditional (x1, x2, x3) =>
            let
                val t2 = infer_type x2
                val t3 = infer_type x3
            in
                if infer_type x1 = type_bool andalso t2 = t3
                then t2
                else raise TypeError
            end

(** Back To The Future! 2 **)

(* GCD -- Final Redux *)

(* provided helper function *)
fun gcd (a : int, b : int) =
    if a = b
    then a
    else
        if a < b
        then gcd (a, b - a)
        else gcd (a - b, b)

fun gcd_list xs = List.foldl gcd (hd xs) (tl xs)

(* Element Of A List -- Final Redux *)

(* provided helper function *)
fun is_divisible_by (a : int, b : int) = a mod b = 0

fun any_divisible_by (xs, divisor) = List.exists (fn x => is_divisible_by (x, divisor)) xs

(* Quirky Addition -- Continued -- Final Redux *)
val add_all_opt =
    let
        fun helper param =
            case param of
                (SOME x, SOME acc) => SOME (acc + x)
              | (NONE, acc) => acc
              | (x, _) => x
    in
        List.foldl helper NONE
    end

(* Flip Flop -- Final Redux *)
val alternate = #2 o (List.foldl (fn (x, (factor, acc)) => (~factor, factor * x + acc)) (1, 0))

(* Minimum/Maximum -- Final Redux *)
fun min_max (x :: xs) = List.foldl (fn (x, (min, max)) => (if x < min then x else min, if x > max then x else max)) (x, x) xs

(* Lists And Tuples, Oh My! -- Final Redux *)
fun unzip xs = List.foldr (fn ((x, y), (xs, ys)) => (x :: xs, y :: ys)) ([], []) xs

(* Lists And Tuples, Oh My! -- Continued (1) -- Final Redux *)
fun zip xs =
    let
        fun helper param =
            case param of
                (x :: xs, y :: ys) => SOME ((xs, ys), (x, y))
              | _ => NONE
    in
        unfold helper xs
    end

(* BBCA -- Final Redux *)
fun repeats_list xs =
    let
        fun helper param =
            case param of
                (_ :: xs, 0 :: reps) => helper (xs, reps)
              | (x :: xs, n :: reps) => SOME ((x :: xs, n - 1 :: reps), x)
              | _ => NONE
    in
        unfold helper xs
    end
    
(* 38 Cons Cells -- Final Redux *)
fun length_of_a_list xs = List.foldl (fn (_, x) => x + 1) 0 xs

(* Forest For The Trees -- Final Redux *)

fun tree_height t = tree_fold (fn (l, _, r) => 1 + Int.max (l, r)) 0 t

fun sum_tree t = tree_fold (fn (l, v, r) => l + v + r) 0 t

(* provided definition *)
datatype flag = leave_me_alone | prune_me

fun gardener t =
    let
        fun helper state =
            case state of
                node { value = prune_me, left = _, right = _ } => NONE
              | node { value = value, left = left, right = right } => SOME (left, value, right)
              | _ => NONE
    in
        tree_unfold helper t
    end

