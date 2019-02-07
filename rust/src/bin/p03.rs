use std::time::Instant;
extern crate numbers;
use crate::numbers::*;
use rayon::prelude::*;

fn largest_prime_factor(n: u64) -> u64 {
    let max_factor: u64 = (1..(n as f64).sqrt() as u64)
        .into_par_iter()
        .filter(|&i| n % i == 0 && primal::is_prime(i))
        .max()
        .unwrap();

    return max_factor;
}


fn main() {
    let now = Instant::now();

    let res = largest_prime_factor(600851475143);

    let elapsed = now.elapsed();
    let ms = elapsed.as_secs()*1000 + elapsed.subsec_millis() as u64;
    println!("{}\n{} ms",res,ms)
}
