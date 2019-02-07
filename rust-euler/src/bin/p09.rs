use std::time::Instant;

fn main() {
    let now = Instant::now();
    fn b(a: u32) -> u32 {
        return ((1000 - a).pow(2) - a.pow(2)) / (2000 - 2 * a);
    }

    fn c_squared(a: u32, b: u32) -> u32 {
        return a.pow(2) + b.pow(2);
    };

    let mut res = 0;
    for a in 1u32..332 {
        let b = b(a);
        let c_squared = c_squared(a,b);
        if c_squared == (1000 - a - b).pow(2) {
            res = a * b * (c_squared as f64).sqrt() as u32;
            break;
        }
    }

    let elapsed = now.elapsed();
    let ms = elapsed.as_secs()*1000 + elapsed.subsec_millis() as u64;
    println!("{}\n{} ms",res,ms)
}
