open Stdio

let time f =
  let t = Caml.Sys.time() in
  let _ = f() in
  printf "Execution time: %fs\n" (Caml.Sys.time() -. t);
