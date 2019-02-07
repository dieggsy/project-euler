use std::time::Instant;


fn main() {
    let now = Instant::now();

    fn num_divisors(n: u32) -> u32 {
        (2u32..n).take_while(|&i| i.pow(2) <= n)
            .filter(|&i| n % i == 0)
            .count() as u32 * 2 + 2
    }

    let res: u32 = (1u32..)
        .map(|n| (n * (n + 1)) / 2)
        .find(|&n| num_divisors(n) > 500)
        .unwrap();

    let elapsed = now.elapsed();
    let ms = elapsed.as_secs()*1000 + elapsed.subsec_millis() as u64;
    println!("{}\n{} ms",res,ms)
}
