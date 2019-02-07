use std::time::Instant;
use rayon::prelude::*;

fn collatz(mut x: u32) -> u32 {
    let mut length = 1;
    while x != 1 {
        // std::cout << "ADING" << '\n';
        if x % 2 == 0{
            x /= 2;
        }
        else {
            x = 3*x + 1;
        }
        length += 1;
    }
    return length;
}

fn main() {
    let now = Instant::now();

    // let mut maxlen = 0;
    // let mut res = 0;
    // for i in 1..1000000 {
    //     let size = collatz(i);
    //     if size > maxlen {
    //         maxlen = size;
    //         res = i;
    //     }
    // }

    let res = (1u32..1000000).into_par_iter().enumerate().map(|(i,n)| (i,collatz(n))).max_by(|(_,x), (_,y)| x.cmp(y)).unwrap().0;

    let elapsed = now.elapsed();
    let ms = elapsed.as_secs()*1000 + elapsed.subsec_millis() as u64;
    println!("{}\n{} ms",res,ms)
}
