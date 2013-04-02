open OUnit
open Batteries

let assert_equal_things t1 t2 =
  assert_equal ~printer:(fun t -> (dump t)) t1 t2

let test_function1 title f specs =
  title>:::
    (List.map
       (fun (label, arg, res) ->
         label>::
           (fun () ->
             assert_equal_things res (f arg)))
       specs)

let test_p01 =
  (test_function1 "p01" P01.last
     ["last is last", [`a ; `b ; `c ; `d], (Some `d) ;
      "last of empty list", [], None])

let test_p02 =
  (test_function1 "p02" P02.last_two
     ["last two are last two", [`a ; `b ; `c ; `d], (Some (`c, `d)) ;
      "last two of one-element list", [`a], None])

let test_p03 =
  "p03">:::
    [
      "3rd is 3rd">::
        (fun () ->
          (assert_equal_things
             (Some `c) (P03.at 3 [`a ; `b ; `c ; `d ; `e]))) ;

      "Out of range">::
        (fun () ->
          (assert_equal_things
             None (P03.at 3 [`a])))
    ]

let test_p04 =
  (test_function1 "p04" P04.length
     ["three elements", [`a ; `b ; `c], 3 ;
      "empty list", [], 0])

let test_p05 =
  (test_function1 "p05" P05.rev
     ["reverse", [`a ; `b ; `c], [`c ; `b ; `a]])

let test_p06 =
  (test_function1 "p06" P06.is_palindrome
     ["palindrome", [`x ; `a ; `m ; `a ; `x], true ;
      "not palindrome", [`a ; `b], false])

open P07
let test_p07 =
  (test_function1 "p07" P07.flatten
     ["flatten", [One `a ; Many [One `b ; Many [One `c ; One `d] ; One `e]],
      [`a ; `b ; `c ; `d ; `e]])

let test_p08 =
  (test_function1 "p08" P08.compress
     ["compress", [`a;`a;`a;`a;`b;`c;`c;`a;`a;`d;`e;`e;`e;`e],
      [`a;`b;`c;`a;`d;`e]])

let test_p09 =
  (test_function1 "p09" P09.pack
     ["pack", [`a;`a;`a;`a;`b;`c;`c;`a;`a;`d;`d;`e;`e;`e;`e],
      [[`a;`a;`a;`a]; [`b]; [`c;`c]; [`a;`a]; [`d;`d]; [`e;`e;`e;`e]]])

let test_p10 =
  (test_function1 "p10" P10.encode
     ["run-length", [`a;`a;`a;`a;`b;`c;`c;`a;`a;`d;`e;`e;`e;`e],
      [4,`a ; 1,`b ; 2,`c ; 2,`a ; 1,`d ; 4,`e]])

open P11
let test_p11 =
  (test_function1 "p11" P11.encode
     ["modified run-length", [`a;`a;`a;`a;`b;`c;`c;`a;`a;`d;`e;`e;`e;`e],
      [Many (4,`a) ; One `b ; Many (2,`c) ; Many (2,`a) ; One `d ; Many (4,`e)]])

let test_p12 =
  (test_function1 "p12" P12.decode
     ["decode run-length", [Many (4,`a); One `b; Many (2,`c); Many (2,`a);
                            One `d; Many (4,`e)],
      [`a;`a;`a;`a;`b;`c;`c;`a;`a;`d;`e;`e;`e;`e]])

let test_p13 =
  (test_function1 "p13" P13.encode
     ["modified run-length", [`a;`a;`a;`a;`b;`c;`c;`a;`a;`d;`e;`e;`e;`e],
      [Many (4,`a) ; One `b ; Many (2,`c) ; Many (2,`a) ; One `d ; Many (4,`e)]])

let test_p14 =
  (test_function1 "p14" P14.duplicate
     ["duplicate", [`a;`b;`c;`c;`d], [`a;`a;`b;`b;`c;`c;`c;`c;`d;`d]])

let test_suite =
  "Working with lists">:::
    [
      test_p01;
      test_p02;
      test_p03;
      test_p04;
      test_p05;
      test_p06;
      test_p07;
      test_p08;
      test_p09;
      test_p10;
      test_p11;
      test_p12;
      test_p13;
      test_p14;
    ]

let _ =
  run_test_tt_main test_suite
