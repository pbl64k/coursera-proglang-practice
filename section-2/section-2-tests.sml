(* All tests should evaluate to true. *)

(* Back To The Future! *)

(* GCD -- Redux *)
val test_gcd_list_1 = gcd_list ([18, 12, 3]) = 3
val test_gcd_list_2 = gcd_list ([18]) = 18
val test_gcd_list_3 = gcd_list ([18, 12, 13]) = 1
val test_gcd_list_4 = gcd_list ([10, 18, 12]) = 2
val test_gcd_list_5 = gcd_list ([100, 1000, 1]) = 1
val test_gcd_list_6 = gcd_list ([18, 12, 180, 42]) = 6
val test_gcd_list_7 = gcd_list ([18, 12]) = 6

(* Element Of A List -- Redux *)
val test_any_divisible_by_1 = any_divisible_by ([13, 1, 20], 5) = true
val test_any_divisible_by_2 = any_divisible_by ([13, 1, 20], 3) = false
val test_any_divisible_by_3 = any_divisible_by ([], 5) = false
val test_any_divisible_by_4 = any_divisible_by ([13, 1, 20], 13) = true
val test_any_divisible_by_5 = any_divisible_by ([13, 1, 20], 12) = false
val test_any_divisible_by_6 = any_divisible_by ([13, 1, 20], 1) = true

(* Quirky Addition -- Redux *)
val test_add_opt_1 = add_opt (SOME 1, SOME 2) = SOME 3
val test_add_opt_2 = add_opt (SOME 1, NONE) = NONE
val test_add_opt_3 = add_opt (NONE, SOME 2) = NONE
val test_add_opt_4 = add_opt (NONE, NONE) = NONE
val test_add_opt_5 = add_opt (SOME ~123, SOME 15) = SOME ~108

(* Quirky Addition -- Continued -- Redux *)
val test_add_all_opt_1 = add_all_opt [SOME 1, NONE, SOME 3] = SOME 4
val test_add_all_opt_2 = add_all_opt [] = NONE
val test_add_all_opt_3 = add_all_opt [NONE, NONE, NONE] = NONE
val test_add_all_opt_4 = add_all_opt [SOME 123] = SOME 123
val test_add_all_opt_5 = add_all_opt [NONE, SOME ~1, NONE, NONE] = SOME ~1

(* Flip Flop -- Redux *)
val test_alternate_1 = alternate [1, 2, 3, 4] = ~2
val test_alternate_2 = alternate [] = 0
val test_alternate_3 = alternate [~100] = ~100
val test_alternate_4 = alternate [1, ~2, 3, ~4] = 10
val test_alternate_5 = alternate [~1, 2, ~3, 4] = ~10

(* Minimum/Maximum -- Redux *)
val test_min_max_1 = min_max [3, 1, 2, 5, 4] = (1, 5)
val test_min_max_2 = min_max [1] = (1, 1)
val test_min_max_3 = min_max [~1000000, 1, 1, 1, 1000000] = (~1000000, 1000000)

(* Lists And Tuples, Oh My! -- Redux *)
val test_unzip_1 = unzip [(1, 2), (3, 4), (5, 6)] = ([1, 3, 5], [2, 4, 6])
(* causes polyEqual warning if unzip has a polymorphic type -- that's ok *)
val test_unzip_2 = unzip [] = ([], [])
val test_unzip_3 = unzip [(123, 321), (321, 123)] = ([123, 321], [321, 123])

(* BBCA -- Redux *)
val test_repeats_list_1 = repeats_list (["abc", "def", "ghi"], [4, 0, 3]) = ["abc", "abc", "abc", "abc", "ghi", "ghi", "ghi"]
val test_repeats_list_2 = repeats_list ([], []) = []
val test_repeats_list_3 = repeats_list (["a"], [10]) = ["a", "a", "a", "a", "a", "a", "a", "a", "a", "a"]

