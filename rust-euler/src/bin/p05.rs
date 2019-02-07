use std::time::Instant;

fn main() {
    let now = Instant::now();

    // let mut res = 1;
    // for i in 2u64..21 {
    //     res = num::integer::lcm(i,res);
    // }
    let res = (2u64..21).fold(1,|acc,x| num::integer::lcm(x,acc));

    let elapsed = now.elapsed();
    let ms = elapsed.as_secs()*1000 + elapsed.subsec_millis() as u64;
    println!("{}\n{} ms",res,ms)
}
