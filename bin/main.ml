open Mandarin_sandhify.Sandhi


let rec read_input () =
  try
    match In_channel.(input_line stdin) with
    | None -> ()
    | Some str -> print_endline (sandhify str);
    read_input ()
  with
  | End_of_file -> ()

let () = read_input ()