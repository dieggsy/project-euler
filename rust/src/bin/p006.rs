use std::time::Instant;
use numbers::*;

fn main() {
    let now = Instant::now();
    fn sum_of_squares(n: u32) -> u32 {
        return n * (n + 1) * (2*n + 1) / 6
    }
    fn square_of_sum(n: u32) -> u32 {
        return arithmetic_sum(1,n,n).pow(2);
        // return ((n + 1) * (n + 1) / 2u32).pow(2);
    }
    // let mut sum_of_squares = 0;
    // let sum_of_squares = 100 * (100+1) * (2*100+1) / 6;
    // let mut square_of_sum = 0;
    // let square_of_sum: u32 = (101 * (100 + 1) / 2u32).pow(2);
    // for i in 1u32..101 {
    //     sum_of_squares += i.pow(2);
    //     // square_of_sum += i;
    // }
    // square_of_sum *= square_of_sum;
    let res = square_of_sum(100) - sum_of_squares(100);

    let elapsed = now.elapsed();
    let ms = elapsed.as_secs()*1000 + elapsed.subsec_millis() as u64;
    println!("{}\n{} ms",res,ms)
}
