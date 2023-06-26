(* Default pronunciations / Pinyin spellings of special words *)
let bu = "bù"
let yi = "yī"

(* Transformed versions of those, when tone sandhi is at play *)
let rising_yi = "yí"
let falling_yi = "yì"
let rising_bu = "bú"

(* Different types of tones for characters in Chinese
   Each character in Chinese is assigned one tone as a simplification for our purposes *)
type tone = Flat | Rising | FallingRising | Falling | Neutral
type word_type = Bu | Yi | Word of tone * string

let uchar_to_string u =
  let buffer = Buffer.create 4 in
  Uutf.Buffer.add_utf_8 buffer u;
  Buffer.contents buffer

let _tone_to_string = function
  | Flat -> "Flat"
  | Rising -> "Rising"
  | FallingRising -> "FallingRising"
  | Falling -> "Falling"
  | Neutral -> "Neutral"

let uchar_to_tone u =
  let xd = uchar_to_string u in
  if List.mem xd [ "ā"; "ē"; "ī"; "ō"; "ū"; "ǖ" ] then Flat
  else if List.mem xd [ "á"; "é"; "í"; "ó"; "ú"; "ǘ" ] then Rising
  else if List.mem xd [ "ǎ"; "ě"; "ǐ"; "ǒ"; "ǔ"; "ǚ" ] then FallingRising
  else if List.mem xd [ "à"; "è"; "ì"; "ò"; "ù"; "ǜ" ] then Falling
  else Neutral

let decode s =
  let f cs _ = function
    | `Uchar c -> ( match cs with Neutral -> uchar_to_tone c | _ -> cs)
    | `Malformed _ -> failwith "Malformed UTF-8"
  in
  Uutf.String.fold_utf_8 f Neutral s

let _string_to_word u =
  if u = bu then Bu else if u = yi then Yi else Word (decode u, u)

let split_into_tokens str = Str.split_delim (Str.regexp " ") str
let list_to_words l = List.map _string_to_word l

let transform_to_rising w =
  let convert_char_to_rising = function
    | "ǎ" -> "á"
    | "ě" -> "é"
    | "ǐ" -> "í"
    | "ǒ" -> "ó"
    | "ǔ" -> "ú"
    | "ǚ" -> "ǘ"
    | c -> c
  in
  let f cs _ = function
    | `Uchar c -> cs ^ convert_char_to_rising (uchar_to_string c)
    | `Malformed _ -> failwith "Malformed input"
  in
  Uutf.String.fold_utf_8 f "" w

let rec transform_words l =
  match l with
  (* Rules for yī *)
  | Yi :: Word (Falling, x) :: xs -> rising_yi :: x :: transform_words xs
  | Yi :: Word (_, x) :: xs -> falling_yi :: x :: transform_words xs
  | Yi :: xs -> yi :: transform_words xs
  (* Rules for bù *)
  | Bu :: Word (Falling, x) :: xs -> rising_bu :: x :: transform_words xs
  | Bu :: xs -> bu :: transform_words xs
  (* Rules for falling rising tones (third tones) *)
  | Word (FallingRising, x) 
    :: Word (FallingRising, y)
    :: Word (FallingRising, z)
    :: Word (FallingRising, a)
    :: xs ->  transform_to_rising x :: y :: transform_to_rising z :: a :: transform_words xs
  | Word (FallingRising, x)
    :: Word (FallingRising, y)
    :: Word (FallingRising, z)
    :: xs ->
      transform_to_rising x :: transform_to_rising y :: z :: transform_words xs
  | Word (FallingRising, x) :: Word (FallingRising, y) :: xs ->
      transform_to_rising x :: y :: transform_words xs
  (* Catch-all for otherwise non-matching *)
  | Word (_, x) :: xs -> x :: transform_words xs
  | _ -> []

let sandhify str =
  split_into_tokens str |> list_to_words |> transform_words |> String.concat " "

let print_list x = List.iter (Printf.printf "%s ") x
