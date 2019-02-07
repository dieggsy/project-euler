use std::time::Instant;
use numbers::arithmetic_sum;

fn main() {
    let now = Instant::now();

    // Attempt 1: Brute force
    // let mut res = 0;
    // for i in 1..1000 {
    //     if i % 3 == 0 || i % 5 == 0 {
    //         res += i;
    //     }
    // }

    // Attempt 2: Brute Force with iterators
    // let res: u32 = (1..1000).filter(|&n| n % 3 == 0 || n % 5 == 0).sum();


    // Attempt 3: Arithmetic sums
    let max = 999;
    let res: u32 =
        arithmetic_sum(3, (max/3) * 3, max/3)
        + arithmetic_sum(5, (max/5) * 5, max/5)
        - arithmetic_sum(15, (max/15) * 15, max/15);

    let elapsed = now.elapsed();
    let ms = elapsed.as_secs()*1000 + elapsed.subsec_millis() as u64;
    println!("{}\n{} ms",res,ms)
}
