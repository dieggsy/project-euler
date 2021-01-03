use std::time::Instant;

fn reversible(i: u32) -> bool {
    let mut n = i;
    let mut reverse = 0;
    while n != 0 {
        reverse *= 10;
        reverse = reverse + n % 10;
        n /= 10;
    }
    return (i + reverse) .to_string().chars()
        .find(|n| n.to_digit(10).unwrap() & 1 == 0).is_none()
}

fn main() {
    let now = Instant::now();
    let mut res = 0;
    for i in 0..1000 {
        res += reversible(i) as u32;
    }
    let elapsed = now.elapsed();
    let ms = elapsed.as_secs()*1000 + elapsed.subsec_millis() as u64;
    println!("{:?}\n{} ms",res,ms)
}
