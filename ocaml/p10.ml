open Base
open Stdio

let imperative () =
  let ps = Array.create ~len:2000001 true in
  ps.(0) <- false;
  ps.(1) <- false;
  let rec loop n sum =
    if n > 2000000 then
      sum
    else
      let m = ref (n + n) in
      while !m < 2000000 do
        ps.(!m) <- false;
        m := !m + n
      done;
      loop (n + 1) (if ps.(n) then (sum + n) else sum)
  in
  printf "%d\n" (loop 2 0)

let () =
  Time.time imperative

