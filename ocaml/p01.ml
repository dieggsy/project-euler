open Base
open Stdio

let iterative () =
  let rec loop n sum =

    if n = 1000 then
      sum
    else if n % 3 = 0 || n % 5 = 0 then
      loop (n + 1) (sum + n)
    else
      loop (n + 1) sum
  in
  printf "%d\n" (loop 0 0)

let list_based () =
  let add x y = x + y in
  let is_multiple x =
    if x % 3 = 0 || x % 5 = 0 then true
    else false
  in
  let sum =
    List.fold
      (List.filter (List.range 0 1000) ~f:is_multiple)
      ~f:add ~init:0
  in
  printf "%d\n" sum

let closed_form () =
  let arithmetic_sum first last n =
    Q.to_int Q.(~$n * ((~$first + ~$last) / ~$2))
  in
  let max = 999 in
  let sum =
    (arithmetic_sum 3 ((max / 3) * 3) (max / 3))
    + (arithmetic_sum 5 ((max / 5) * 5) (max / 5))
    - (arithmetic_sum 15 ((max / 15) * 15) (max / 15))
  in
  printf "%d\n" sum



let () =
  printf "Naive iterative:\n";
  Time.time iterative;
  printf "List-based:\n";
  Time.time list_based;
  printf "Closed form:\n";
  Time.time closed_form;

