(* 38 Cons Cells *)

fun length_of_a_list elems =
    let
        fun helper (counted, elems) =
            case elems of
                [] => counted
              | x :: elems' => helper (counted + 1, elems')
    in
        helper (0, elems)
    end

(** Pass/Fail **)

(* provided definitions *)
type student_id = int
type grade = int (* must be in 0 to 100 range *)
type final_grade = { id : student_id, grade : grade option }
datatype pass_fail = pass | fail

(* Pass/Fail -- 1 *)
fun pass_or_fail param =
    case param of
        { id = _, grade = SOME grade } => if grade >= 75 then pass else fail
      | _ => fail

(* Pass/Fail -- 2 *)
fun has_passed param =
    case pass_or_fail param of
        pass => true
      | _ => false

(* Pass/Fail -- 3 *)
fun number_passed grades =
    case grades of
        [] => 0
      | grade :: grades' => (if has_passed grade then 1 else 0) + number_passed grades'

(* Pass/Fail -- 4 *)
fun group_by_outcome grades =
    let
        fun insert_id outcome id result =
            case result of
                [] => [(outcome, [id])]
              | (outcome', ids) :: rest =>
                    if outcome = outcome'
                        then (outcome, id :: ids) :: rest
                        else (outcome', ids) :: insert_id outcome id rest
        fun helper grades =
            case grades of
                [] => []
              | { id = id, grade = grade } :: grades => insert_id (pass_or_fail { id = id, grade = grade }) id (helper grades)
        val result = helper grades
    in
        case result of
            (fail, failing) :: (pass, passing) :: [] => [(pass, passing), (fail, failing)]
          | _ => result
    end

(** Forest For The Trees **)

(* provided definition *)
datatype 'a tree = leaf | node of { value : 'a, left : 'a tree, right : 'a tree }

(* Forest For The Trees -- 1 *)
fun tree_height tree =
    case tree of
        leaf => 0
      | node { value = _, left = ltree, right = rtree } =>
            let
                val lheight = tree_height ltree
                val rheight = tree_height rtree
            in
                1 + (if lheight > rheight then lheight else rheight)
            end

(* Forest For The Trees -- 2 *)
fun sum_tree tree =
    case tree of
        leaf => 0
      | node { value = x, left = ltree, right = rtree } =>
            x + sum_tree ltree + sum_tree rtree

(* Forest For The Trees -- 3 *)

(* provided definition *)
datatype flag = leave_me_alone | prune_me

fun gardener tree =
    case tree of
        node { value = leave_me_alone, right = rtree, left = ltree } =>
            node { value = leave_me_alone, right = gardener rtree, left = gardener ltree }
      | _ => leaf

(** Back To The Future! **)

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

