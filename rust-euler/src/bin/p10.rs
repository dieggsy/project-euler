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

    let mut is_prime = [true;2000000];
    is_prime[0] = false;
    is_prime[1] = false;
    for n in 2..1999999 {
        if is_prime[n] {
            for m in (2*n..1999999).step_by(n) {
                is_prime[m] = false;
            }
        }
    }

    // let res = is_prime[10001];

    // let res: u64 = (1u64..2000000).into_par_iter().filter(|&n| small_prime_p(n as u32)).sum();
    // let res: u64 = (1u64..2000000).filter(|&n| small_prime_p(n as u32)).sum();
    let res: u64 = (1u64..2000000).filter(|&n| is_prime[n as usize]).sum();

    let elapsed = now.elapsed();
    let ms = elapsed.as_secs()*1000 + elapsed.subsec_millis() as u64;
    println!("{}\n{} ms",res,ms)
}
