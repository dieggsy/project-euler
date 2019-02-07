use std::time::Instant;

fn main() {
    let now = Instant::now();

    let (mut i, mut j) = (1, 2);
    let mut oldi;
    let mut res: u32 = 0;
    while j <= 4000000 {
        if j % 2 == 0 {
            res += j;
        }
        oldi = i;
        i = j;
        j = oldi + j;
    }


    let elapsed = now.elapsed();
    let ms = elapsed.as_secs()*1000 + elapsed.subsec_millis() as u64;
    println!("{}\n{} ms",res,ms)
}
