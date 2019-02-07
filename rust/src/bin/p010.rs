use std::time::Instant;
// use crate::numbers::*;
// use rayon::prelude::*;

fn main() {
    let now = Instant::now();

    // let mut res: u64 = 0;
    // for i in 1..2000000 {
    //     if small_prime_p(i) {
    //         res += i as u64;
    //     }
    // }

    // let sieve = primal::Sieve::new(2000000);
    let is_prime = numbers::euler_sieve(2000000);

    let res: u64 = (1u64..2000000).filter(|&n| is_prime[n as usize]).sum();
    // let res: u64 = (1u64..2000000).filter(|&n| sieve.is_prime(n as usize)).sum();

    let elapsed = now.elapsed();
    let ms = elapsed.as_secs()*1000 + elapsed.subsec_millis() as u64;
    println!("{}\n{} ms",res,ms)
}
