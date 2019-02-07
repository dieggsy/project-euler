use std::time::Instant;
use numbers::*;
use rayon::prelude::*;

fn main() {
    let now = Instant::now();

    let sieve = primal::Sieve::new(100_000_000);

    let special = |n: u32| -> bool
    {
        !(1..n).take_while(|&i| i.pow(2) <= n)
            .filter(|&i| n % i == 0)
            .any(|d| !sieve.is_prime((d + n/d) as usize)
            )
    };

    let res: u64 = (1u64..100_000_000).into_par_iter()
        .filter(|&n| special(n as u32)).sum();
    // let res = is_prime[ 31 ];
    // let res = special(30);

    let elapsed = now.elapsed();
    let ms = elapsed.as_secs()*1000 + elapsed.subsec_millis() as u64;
    println!("{}\n{} ms",res,ms)
}
