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

(** Back To The Future! 2 **)

(* GCD -- Final Redux *)
val test_gcd_list_1 = gcd_list [18, 12, 3] = 3
val test_gcd_list_2 = gcd_list [18] = 18
val test_gcd_list_3 = gcd_list [18, 12, 13] = 1
val test_gcd_list_4 = gcd_list [10, 18, 12] = 2
val test_gcd_list_5 = gcd_list [100, 1000, 1] = 1
val test_gcd_list_6 = gcd_list [18, 12, 180, 42] = 6
val test_gcd_list_7 = gcd_list [18, 12] = 6

(* Element Of A List -- Final Redux *)
val test_any_divisible_by_1 = any_divisible_by ([13, 1, 20], 5) = true
val test_any_divisible_by_2 = any_divisible_by ([13, 1, 20], 3) = false
val test_any_divisible_by_3 = any_divisible_by ([], 5) = false
val test_any_divisible_by_4 = any_divisible_by ([13, 1, 20], 13) = true
val test_any_divisible_by_5 = any_divisible_by ([13, 1, 20], 12) = false
val test_any_divisible_by_6 = any_divisible_by ([13, 1, 20], 1) = true

(* Quirky Addition -- Continued -- Final Redux *)
val test_add_all_opt_1 = add_all_opt [SOME 1, NONE, SOME 3] = SOME 4
val test_add_all_opt_2 = add_all_opt [] = NONE
val test_add_all_opt_3 = add_all_opt [NONE, NONE, NONE] = NONE
val test_add_all_opt_4 = add_all_opt [SOME 123] = SOME 123
val test_add_all_opt_5 = add_all_opt [NONE, SOME ~1, NONE, NONE] = SOME ~1

(* Flip Flop -- Final Redux *)
val test_alternate_1 = alternate [1, 2, 3, 4] = ~2
val test_alternate_2 = alternate [] = 0
val test_alternate_3 = alternate [~100] = ~100
val test_alternate_4 = alternate [1, ~2, 3, ~4] = 10
val test_alternate_5 = alternate [~1, 2, ~3, 4] = ~10

(* Minimum/Maximum -- Final Redux *)
val test_min_max_1 = min_max [3, 1, 2, 5, 4] = (1, 5)
val test_min_max_2 = min_max [1] = (1, 1)
val test_min_max_3 = min_max [~1000000, 1, 1, 1, 1000000] = (~1000000, 1000000)

(* Lists And Tuples, Oh My! -- Final Redux *)
val test_unzip_1 = unzip [(1, 2), (3, 4), (5, 6)] = ([1, 3, 5], [2, 4, 6])
(* causes polyEqual warning if unzip has a polymorphic type -- that's ok *)
val test_unzip_2 = unzip [] = ([], [])
val test_unzip_3 = unzip [(123, 321), (321, 123)] = ([123, 321], [321, 123])

(* Lists And Tuples, Oh My! -- Continued (1) -- Final Redux *)
val test_zip_1 = zip ([1, 2, 3], [4, 6]) = [(1, 4), (2, 6)]
val test_zip_2 = zip ([], [4, 6]) = []
val test_zip_3 = zip ([1, 2, 3], []) = []
val test_zip_4 = zip ([], []) = []
val test_zip_5 = zip ([1, 2], [4, 6, 8]) = [(1, 4), (2, 6)]
val test_zip_6 = zip ([1, 2, 3], [4, 6, 8]) = [(1, 4), (2, 6), (3, 8)]

(* BBCA -- Final Redux *)
val test_repeats_list_1 = repeats_list (["abc", "def", "ghi"], [4, 0, 3]) = ["abc", "abc", "abc", "abc", "ghi", "ghi", "ghi"]
(* causes polyEqual warning if repeats_list has a polymorphic type -- that's ok *)
val test_repeats_list_2 = repeats_list ([], []) = []
val test_repeats_list_3 = repeats_list (["a"], [10]) = ["a", "a", "a", "a", "a", "a", "a", "a", "a", "a"]

