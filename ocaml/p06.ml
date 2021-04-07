open Base
open Stdio

let p06 () =
  let arithmetic_sum first last n =
    Q.to_int Q.(~$n * ((~$first + ~$last) / ~$2))
  in
  let sum_of_squares n =
    (n * (n + 1) * ((2 * n) + 1)) / 6
  in
  let square_of_sum n =
    (arithmetic_sum 1 n n) ** 2
  in
  printf "%d\n" ((square_of_sum 100) - (sum_of_squares 100))

let () =
  Time.time p06;
