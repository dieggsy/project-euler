use std::time::Instant;
use rug::Integer;
use rug::ops::*;

fn main() {
    let now = Instant::now();

    let mut res: String = (Integer::from(28433) * Integer::from(2).pow(7830457) + Integer::from(1))
        .to_string()
        .chars()
        .rev()
        .take(10)
        .collect::<String>()
        .chars()
        .rev()
        .collect::<String>();

    let elapsed = now.elapsed();
    let ms = elapsed.as_secs()*1000 + elapsed.subsec_millis() as u64;
    println!("{}\n{} ms",res,ms)
}
