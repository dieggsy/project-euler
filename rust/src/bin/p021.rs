use std::time::Instant;
use rayon::prelude::*;

fn main() {
    let now = Instant::now();

    fn d(n: u32) -> u32 {
        1 + (2..n).take_while(|&i| i.pow(2) <= n)
            .filter(|i| n % i == 0)
            .map(|i| {
                if n / i == i {
                    i
                } else {
                    i + n/i}
            })
            .sum::<u32>()
    }


    fn is_amicable(n: u32) -> bool {
        let other = d(n);
        if other != n && d(other) == n {
            true
        } else {
            false
        }
    }

    let res: u32 = (2u32..10000).into_par_iter().filter(|&n| is_amicable(n)).sum();

    let elapsed = now.elapsed();
    let ms = elapsed.as_secs()*1000 + elapsed.subsec_millis() as u64;
    println!("{}\n{} ms",res,ms)
}
