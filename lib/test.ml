open Base

(* Test cases for yī *)
(* "One of something" *)
let%test "yī + Falling => yí + Falling" =
  String.equal (Sandhi.sandhify "yī gè") "yí gè"

(* "One day" *)
let%test "yī + Flat => yì + Flat" =
  String.equal (Sandhi.sandhify "yī tiān") "yì tiān"

(* "One year" *)
let%test "yī + Rising => yì + Rising" =
  String.equal (Sandhi.sandhify "yī nián") "yì nián"

(* "Together" *)
let%test "yī + FallingRising => yì + FallingRising" =
  String.equal (Sandhi.sandhify "yī qǐ") "yì qǐ"

(* Test case for bú *)
(* "Incorrect" *)
let%test "bù + Falling => bú + Falling" =
  String.equal (Sandhi.sandhify "bù duì") "bú duì"

(* Test cases for RisingFalling + other stuff *)
(* "Hello" -- probably the most common application of tone sandhi of this! *)
let%test "Double FallingRising => Rising + FallingRising" =
  String.equal (Sandhi.sandhify "nǐ hǎo") "ní hǎo"

(* "999" -- a popular Chinese cough medicine *)
let%test "Triple FallingRising => Rising + Rising + FallingRising" =
  String.equal (Sandhi.sandhify "jiǔ jiǔ jiǔ") "jiú jiú jiǔ"

(* Expression to deny compliments *)
let %test "Quadruple FallingRising => Rising + FallingRising + Rising + FallingRising" =
  String.equal (Sandhi.sandhify "nǎ lǐ nǎ lǐ") "ná lǐ ná lǐ"