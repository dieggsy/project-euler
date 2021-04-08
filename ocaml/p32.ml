open Base
open Stdio

let p11 () =
  let next_permutation arr =
    let arr = Array.copy arr in
    let rev_from arr n =
      (* Reverse an array from n onwards *)
      let rev_inplace t =
        let i = ref n in
        let j = ref (Array.length t - 1) in
        while !i < !j do
          Array.swap t !i !j;
          Int.incr i;
          Int.decr j
        done
      in
      rev_inplace arr;
    in
    (* This is basically the Wikipedia algo from here:
       https://en.wikipedia.org/wiki/Permutation#Generation_in_lexicographic_order
       *)
    let len = Array.length arr in
    let rec geti n =
      if n = -1 then
        -1
      else if arr.(n + 1) > arr.(n) then n
      else geti (n - 1)
    in
    let i = geti (len - 2) in
    if i = -1 then None
    else
      (* I like to pretend this is lisp *)
      (let rec getj n =
         if arr.(n) > arr.(i) then n
         else getj (n - 1)
       in
       let j = getj (len - 1) in
       Array.swap arr i j;
       rev_from arr ( i + 1 );
       Some arr)
  in
  let num_of_digits arr =
    (* Create a number whose digits are stored in an int array *)
    let str = Array.map ~f:(fun x -> Int.to_string x) arr in
    Int.of_string (Array.fold ~f:(fun x y -> x ^ y) str ~init:"")
  in
  let get_product arr ~digits:n =
    (* Get the 'product' or number from last n digits *)
    num_of_digits (Array.sub arr ~pos:(Array.length arr - n) ~len:n)
  in
  let get_multiplicand arr ~digits:n =
    (* Get the multiplicand, or first n digits *)
    num_of_digits (Array.sub arr ~pos:0 ~len:n)
  in
  let get_multiplier arr ~multiplicand_digits:n =
    (* Get the multiplier, given a /multiplicand/ of n digits. This 5 is
       hardcoded because we know the product is 4 digits. See below *)
    num_of_digits (Array.sub arr ~pos:n ~len:(5 - n))
  in
  let is_identity arr m =
    let a = get_multiplicand arr ~digits:m in
    let b = get_multiplier arr ~multiplicand_digits:m in
    (* There's a conscious decision to chose a product with 4 digits - if I
       choose a product with e.g. 3 digits, a * b /will/ result in at least a 5
       digit number. If I choose a product with 5 digits, a * b will result in
       at most a 4 digit number. *)
    let c = get_product arr ~digits:4 in
    if a * b = c then Some c
    else None

  in
  let rec loop m p res =
    match p with
    | None -> res
    | Some arr ->
       (match (is_identity arr m) with
        | Some prod ->
           loop m (next_permutation arr)
             (if (List.mem res prod ~equal:(fun x y -> x = y)) then res
              else prod :: res)
        | None -> loop m (next_permutation arr) res)
  in
  printf "%d\n"
    (List.fold ~f:(fun x y -> x + y) ~init:0
       (* There are only two options for multiplier/multiplicand size, since
          we're iterating over every possible permutation and product is fixed
          at 4 digits *)
       ((loop 2 (Some [|1;2;3;4;5;6;7;8;9|]) [])
        @ (loop 1 (Some [|1;2;3;4;5;6;7;8;9|]) [])))

let () =
  Time.time p11
