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

(* Least Common Multple *)
val test_lcm_1 = lcm (18, 12) = 36
val test_lcm_2 = lcm (18, 13) =  234
val test_lcm_3 = lcm (12, 36) = 36
val test_lcm_4 = lcm (12, 15) = 60
val test_lcm_5 = lcm (5, 3) = 15
val test_lcm_6 = lcm (100, 1) = 100
val test_lcm_7 = lcm (1, 10) = 10

(* Greatedt Common Divisor -- Continued *)
val test_gcd_list_1 = gcd_list ([18, 12, 3]) = 3
val test_gcd_list_2 = gcd_list ([18]) = 18
val test_gcd_list_3 = gcd_list ([18, 12, 13]) = 1
val test_gcd_list_4 = gcd_list ([10, 18, 12]) = 2
val test_gcd_list_5 = gcd_list ([100, 1000, 1]) = 1
val test_gcd_list_6 = gcd_list ([18, 12, 180, 42]) = 6
val test_gcd_list_7 = gcd_list ([18, 12]) = 6

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

(* Lists And Tuples, Oh My! *)
val test_unzip_1 = unzip [(1, 2), (3, 4), (5, 6)] = ([1, 3, 5], [2, 4, 6])
val test_unzip_2 = unzip [] = ([], [])
val test_unzip_3 = unzip [(123, 321), (321, 123)] = ([123, 321], [321, 123])

(* BananaBanana *)
val test_duplicate_1 = duplicate ["a", "bc", "def"] = ["a", "a", "bc", "bc", "def", "def"]
val test_duplicate_2 = duplicate [] = []
val test_duplicate_3 = duplicate (duplicate ["banana"]) = ["banana", "banana", "banana", "banana"]

(* BananaBanana -- Continued *)
val test_repeats_1 = repeats ("banana", 2) = ["banana", "bananabanana"]
val test_repeats_2 = repeats ("banana", 0) = []
val test_repeats_3 = repeats ("banana", 4) = ["banana", "bananabanana", "bananabananabanana", "bananabananabananabanana"]
val test_repeats_4 = repeats ("a", 5) = ["a", "aa", "aaa", "aaaa", "aaaaa"]

