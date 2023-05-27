open Base

(* "One of something" *)
let%test "yī + Falling => yí + Falling" =
  String.equal (Sandhi.sandhify "yī gè") "yí gè"

(* "Incorrect" *)
let%test "bù + Falling => bú + Falling" =
  String.equal (Sandhi.sandhify "bù duì") "bú duì"

(* "Hello" -- probably the most common application of tone sandhi of this! *)
let%test "Double FallingRising => Rising + FallingRising" =
  String.equal (Sandhi.sandhify "nǐ hǎo") "ní hǎo"

(* "999" -- a popular Chinese cough medicine *)
let%test "Triple FallingRising => Rising + Rising + FallingRising" =
  String.equal (Sandhi.sandhify "jiǔ jiǔ jiǔ") "jiú jiú jiǔ"
