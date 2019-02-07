use std::time::Instant;
extern crate numbers;

use numbers::*;

fn main() {
    let now = Instant::now();

    let mut nth_prime: u32 = 2;
    let mut res: u32 = 3;

    while nth_prime < 10001 {
        res += 2;
        if small_prime_p(res) {
            nth_prime += 1;
        }
    }

    let elapsed = now.elapsed();
    let ms = elapsed.as_secs()*1000 + elapsed.subsec_millis() as u64;
    println!("{}\n{} ms",res,ms)
}
