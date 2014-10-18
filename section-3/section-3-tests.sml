(* All tests should evaluate to true. *)

(** High-Order Fun **)

(* There Can Be Only One *)

val test_fold_map_1 = fold_map (fn x => x + 1) [1, 2, 3, 4, 5] = [2, 3, 4, 5, 6]
val test_fold_map_2 = fold_map (fn x => x) [] = []
val test_fold_map_3 = fold_map not [true, false, true, false] = [false, true, false, true]
val test_fold_map_4 = fold_map (fn x => "fnord " ^ x) ["a", "quick", "brown", "fox"] = ["fnord a", "fnord quick", "fnord brown", "fnord fox"]

val test_fold_filter_1 = fold_filter (fn x => x mod 2 = 0) [1, 2, 3, 4, 5] = [2, 4]
val test_fold_filter_2 = fold_filter (fn x => x) [] = []
val test_fold_filter_3 = fold_filter not [true, false, true, false] = [false, false]
val test_fold_filter_4 = fold_filter (fn x => String.size x < 4) ["a", "quick", "brown", "fox"] = ["a", "fox"]

(* The Evil Twin *)

val test_unfold_1 = unfold (fn x => if x > 3 then NONE else SOME (x + 1, x)) 0 = [0, 1, 2, 3]
val test_unfold_2 = unfold (fn _ => NONE) false = []
val test_unfold_3 = unfold (fn str => if String.size str > 12 then NONE else SOME ("Banana" ^ str, str)) "" = ["", "Banana", "BananaBanana"]

(* A Novel Approach *)

val test_factorial_1 = factorial 4 = 24
val test_factorial_2 = factorial 0 = 1
val test_factorial_3 = factorial 5 = 120
val test_factorial_4 = factorial 7 = 5040

(* Deeper Into The Woods *)

val test_tree_fold_1 = tree_fold (fn (l, v, r) => l ^ v ^ r) "!" (node { value = "foo", left = node { value = "bar", left = leaf, right = leaf }, right = node { value = "baz", left = leaf, right = leaf }}) = "!bar!foo!baz!"
val test_tree_fold_2 = tree_fold (fn (l, v, r) => l * r * v) 1 leaf = 1
val test_tree_fold_3 = tree_fold (fn (l, v, r) => v - l - r) 1 (node { value = 10, left = node { value = 5, left = leaf, right = leaf }, right = node { value = 3, left = leaf, right = leaf }}) = 6

val test_tree_unfold_1 = tree_unfold (fn x => if x = 0 then NONE else SOME (x - 1, x, x - 1)) 2 = node { value = 2, left = node { value = 1, left = leaf, right = leaf }, right = node { value = 1, left = leaf, right = leaf }}
val test_tree_unfold_2 = tree_unfold (fn x => NONE) NONE = leaf
val test_tree_unfold_3 = tree_unfold (fn x => if x = 0 then NONE else SOME (x div 2, x, x div 3)) 6 = node { value = 6, left = node { value = 3, left = node { value = 1, left = leaf, right = leaf }, right = node { value = 1, left = leaf, right = leaf } }, right = node { value = 2, left = node { value = 1, left = leaf, right = leaf }, right = leaf }}

