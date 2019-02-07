use std::time::Instant;
use rug::Integer;

fn main() {
    let now = Instant::now();

    fn factorial(n: u32) -> Integer {
        let _1 = Integer::from(1);
        if n == 0 {
            return _1
        }
        let mut res = _1;
        for i in 1..=n {
            res = res * i;
        }
        return res;
    }

    let res: u32 = factorial(100)
        .to_string()
        .chars()
        .map(|c| c.to_digit(10).unwrap() as u32)
        .sum();

    let elapsed = now.elapsed();
    let ms = elapsed.as_secs()*1000 + elapsed.subsec_millis() as u64;
    println!("{}\n{} ms",res,ms)
}
