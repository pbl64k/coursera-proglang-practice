(* All tests should evaluate to true. *)

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

