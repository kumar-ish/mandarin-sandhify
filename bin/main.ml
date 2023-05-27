open Mandarin_sandhify.Sandhi

let () =
  match In_channel.(input_line stdin) with
  | None -> print_endline "No input"
  | Some str -> print_endline (sandhify str)
