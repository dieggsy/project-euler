open Base
open Stdio

let p05 () =
  let rec gcd a b =
    match b with
    | 0 -> a
    | _ -> gcd b (a % b)
  in
  let lcm a b = a * b / gcd a b in
  printf "%d\n" (List.fold (List.range 2 21) ~f:lcm ~init:1)

let () =
  Time.time p05

