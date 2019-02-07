use std::time::Instant;
use rug::Integer;
use rug::ops::*;

fn main() {
    let now = Instant::now();

    let res: u32 = Integer::from(2).pow(1000)
        .to_string()
        .chars()
        .map(|c| c.to_digit(10).unwrap() as u32)
        .sum::<u32>();

    let elapsed = now.elapsed();
    let ms = elapsed.as_secs()*1000 + elapsed.subsec_millis() as u64;
    println!("{}\n{} ms",res,ms)
}
