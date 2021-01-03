use numbers::*;
// use rug::Integer;

// use num::Num;

fn main() {
    let now = std::time::Instant::now();

    // fn

    let elapsed = now.elapsed();
    let ms = elapsed.as_secs()*1000 + elapsed.subsec_millis() as u64;
    println!("{:?}\n{} ms",res,ms)

}
