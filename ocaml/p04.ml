open Base
open Stdio

let p04 () =
  let is_palindrome int =
    let str = Int.to_string int in
    String.equal (String.rev str) str
  in
  let rec loop i res =
    let rec loop1 j res =
      let prod = i * j in
      if i > 999 then res
      else if j > 999 then loop (i + 1) res
      else if (is_palindrome prod) && (prod > res) then
        loop1 (j + 1) prod
      else
        loop1 (j +  1) res
    in
    loop1 i res
  in
  printf "%d\n" (loop 900 0)

let () =
  Time.time p04
