(* All tests should evaluate to true. *)

(* Positive Numbers *)
val test_is_positive_1 = is_positive 1 = true
val test_is_positive_2 = is_positive 0 = false
val test_is_positive_3 = is_positive ~1 = false
val test_is_positive_4 = is_positive ~2 = false
val test_is_positive_5 = is_positive 2 = true
val test_is_positive_6 = is_positive 100 = true

(* Divisibility *)
val test_is_divisible_by_1 = is_divisible_by (6, 3) = true
val test_is_divisible_by_2 = is_divisible_by (5, 3) = false
val test_is_divisible_by_3 = is_divisible_by (6, 4) = false
val test_is_divisible_by_4 = is_divisible_by (6, 2) = true
val test_is_divisible_by_5 = is_divisible_by (87, 29) = true
val test_is_divisible_by_6 = is_divisible_by (6, 1) = true

(* Integer Division *)

(* NOTE: These tests do not verify that you're not using the div operator. *)
(* You should check that yourself! *)

val test_divide_by_1 = divide_by (6, 3) = 2
val test_divide_by_2 = divide_by (5, 3) = 1
val test_divide_by_3 = divide_by (6, 4) = 1
val test_divide_by_4 = divide_by (6, 2) = 3
val test_divide_by_5 = divide_by (87, 29) = 3
val test_divide_by_6 = divide_by (6, 1) = 6
val test_divide_by_7 = divide_by (8, 9) = 0
val test_divide_by_8 = divide_by (8, 8) = 1

(* Greatest Common Divisor *)
val test_gcd_1 = gcd (18, 12) = 6
val test_gcd_2 = gcd (18, 13) = 1
val test_gcd_3 = gcd (12, 36) = 12
val test_gcd_4 = gcd (12, 15) = 3
val test_gcd_5 = gcd (5, 3) = 1
val test_gcd_6 = gcd (100, 1) = 1
val test_gcd_7 = gcd (1, 10) = 1

(* Least Common Multiple *)
val test_lcm_1 = lcm (18, 12) = 36
val test_lcm_2 = lcm (18, 13) =  234
val test_lcm_3 = lcm (12, 36) = 36
val test_lcm_4 = lcm (12, 15) = 60
val test_lcm_5 = lcm (5, 3) = 15
val test_lcm_6 = lcm (100, 1) = 100
val test_lcm_7 = lcm (1, 10) = 10

(* Greatest Common Divisor -- Continued *)
val test_gcd_list_1 = gcd_list [18, 12, 3] = 3
val test_gcd_list_2 = gcd_list [18] = 18
val test_gcd_list_3 = gcd_list [18, 12, 13] = 1
val test_gcd_list_4 = gcd_list [10, 18, 12] = 2
val test_gcd_list_5 = gcd_list [100, 1000, 1] = 1
val test_gcd_list_6 = gcd_list [18, 12, 180, 42] = 6
val test_gcd_list_7 = gcd_list [18, 12] = 6

(* Element Of A List *)
val test_any_divisible_by_1 = any_divisible_by ([13, 1, 20], 5) = true
val test_any_divisible_by_2 = any_divisible_by ([13, 1, 20], 3) = false
val test_any_divisible_by_3 = any_divisible_by ([], 5) = false
val test_any_divisible_by_4 = any_divisible_by ([13, 1, 20], 13) = true
val test_any_divisible_by_5 = any_divisible_by ([13, 1, 20], 12) = false
val test_any_divisible_by_6 = any_divisible_by ([13, 1, 20], 1) = true

(* Integer Division -- Continued *)
val test_safe_divide_by_1 = safe_divide_by (6, 3) = SOME 2
val test_safe_divide_by_2 = safe_divide_by (5, 3) = SOME 1
val test_safe_divide_by_3 = safe_divide_by (6, 4) = SOME 1
val test_safe_divide_by_4 = safe_divide_by (6, 2) = SOME 3
val test_safe_divide_by_5 = safe_divide_by (87, 29) = SOME 3
val test_safe_divide_by_6 = safe_divide_by (6, 1) = SOME 6
val test_safe_divide_by_7 = safe_divide_by (8, 9) = SOME 0
val test_safe_divide_by_8 = safe_divide_by (8, 8) = SOME 1
val test_safe_divide_by_9 = safe_divide_by (6, 0) = NONE
val test_safe_divide_by_10 = safe_divide_by (5, 0) = NONE
val test_safe_divide_by_11 = safe_divide_by (87, 0) = NONE

(* Quirky Addition *)
val test_add_opt_1 = add_opt (SOME 1, SOME 2) = SOME 3
val test_add_opt_2 = add_opt (SOME 1, NONE) = NONE
val test_add_opt_3 = add_opt (NONE, SOME 2) = NONE
val test_add_opt_4 = add_opt (NONE, NONE) = NONE
val test_add_opt_5 = add_opt (SOME ~123, SOME 15) = SOME ~108

(* Quirky Addition -- Continued *)
val test_add_all_opt_1 = add_all_opt [SOME 1, NONE, SOME 3] = SOME 4
val test_add_all_opt_2 = add_all_opt [] = NONE
val test_add_all_opt_3 = add_all_opt [NONE, NONE, NONE] = NONE
val test_add_all_opt_4 = add_all_opt [SOME 123] = SOME 123
val test_add_all_opt_5 = add_all_opt [NONE, SOME ~1, NONE, NONE] = SOME ~1

(* Flip Flop *)
val test_alternate_1 = alternate [1, 2, 3, 4] = ~2
val test_alternate_2 = alternate [] = 0
val test_alternate_3 = alternate [~100] = ~100
val test_alternate_4 = alternate [1, ~2, 3, ~4] = 10
val test_alternate_5 = alternate [~1, 2, ~3, 4] = ~10

(* Minimum/Maximum *)
val test_min_max_1 = min_max [3, 1, 2, 5, 4] = (1, 5)
val test_min_max_2 = min_max [1] = (1, 1)
val test_min_max_3 = min_max [~1000000, 1, 1, 1, 1000000] = (~1000000, 1000000)

(* Lists And Tuples, Oh My! *)
val test_unzip_1 = unzip [(1, 2), (3, 4), (5, 6)] = ([1, 3, 5], [2, 4, 6])
val test_unzip_2 = unzip [] = ([], [])
val test_unzip_3 = unzip [(123, 321), (321, 123)] = ([123, 321], [321, 123])

(* Lists And Tuples, Oh My! -- Continued (1) *)
val test_zip_1 = zip ([1, 2, 3], [4, 6]) = [(1, 4), (2, 6)]
val test_zip_2 = zip ([], [4, 6]) = []
val test_zip_3 = zip ([1, 2, 3], []) = []
val test_zip_4 = zip ([], []) = []
val test_zip_5 = zip ([1, 2], [4, 6, 8]) = [(1, 4), (2, 6)]
val test_zip_6 = zip ([1, 2, 3], [4, 6, 8]) = [(1, 4), (2, 6), (3, 8)]

(* Lists And Tuples, Oh My! -- Continued (2) *)
val test_zip_recycle_1 = zip_recycle ([1, 2, 3], [4, 6]) = [(1, 4), (2, 6), (3, 4)]
val test_zip_recycle_2 = zip_recycle ([], [4, 6]) = []
val test_zip_recycle_3 = zip_recycle ([1, 2, 3], []) = []
val test_zip_recycle_4 = zip_recycle ([], []) = []
val test_zip_recycle_5 = zip_recycle ([1, 2], [4, 6, 8]) = [(1, 4), (2, 6), (1, 8)]
val test_zip_recycle_6 = zip_recycle ([1, 2, 3], [4, 6, 8]) = [(1, 4), (2, 6), (3, 8)]

(* Lists And Tuples, Oh My! -- Continued (3) *)
val test_zip_opt_1 = zip_opt ([1, 2, 3], [4, 6]) = NONE
val test_zip_opt_2 = zip_opt ([], [4, 6]) = NONE
val test_zip_opt_3 = zip_opt ([1, 2, 3], []) = NONE
val test_zip_opt_4 = zip_opt ([], []) = SOME []
val test_zip_opt_5 = zip_opt ([1, 2], [4, 6, 8]) = NONE
val test_zip_opt_6 = zip_opt ([1, 2, 3], [4, 6, 8]) = SOME [(1, 4), (2, 6), (3, 8)]

(* BananaBanana *)
val test_duplicate_1 = duplicate ["a", "bc", "def"] = ["a", "a", "bc", "bc", "def", "def"]
val test_duplicate_2 = duplicate [] = []
val test_duplicate_3 = duplicate (duplicate ["banana"]) = ["banana", "banana", "banana", "banana"]

(* Greetings, Earthlings! *)
val test_greeting_1 = greeting (SOME "Charilaos") = "Hello there, Charilaos!"
val test_greeting_2 = greeting (SOME "student") = "Hello there, student!"
val test_greeting_3 = greeting NONE = "Hello there, you!"

(* BananaBanana -- Continued *)
val test_repeats_1 = repeats ("banana", 2) = ["banana", "bananabanana"]
val test_repeats_2 = repeats ("banana", 0) = []
val test_repeats_3 = repeats ("banana", 4) =
    ["banana", "bananabanana", "bananabananabanana", "bananabananabananabanana"]
val test_repeats_4 = repeats ("a", 5) = ["a", "aa", "aaa", "aaaa", "aaaaa"]

(* BananaBanana -- Continued (Again) *)
val test_repeats_list_1 = repeats_list (["abc", "def", "ghi"], [4, 0, 3]) =
    ["abc", "abc", "abc", "abc", "ghi", "ghi", "ghi"]
val test_repeats_list_2 = repeats_list ([], []) = []
val test_repeats_list_3 = repeats_list (["a"], [10]) = ["a", "a", "a", "a", "a", "a", "a", "a", "a", "a"]

