open Base
open Stdio

let p02 () =
  let fib_until (n) =
    let rec loop i j sum =
      if j > n then sum
      else loop j (i + j) (if j % 2 = 0 then sum + j else sum)
    in
    loop 1 2 0
  in
  printf "%d\n" (fib_until 4000000)

let () =
  Time.time p02
