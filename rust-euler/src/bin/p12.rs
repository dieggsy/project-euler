use std::time::Instant;

fn num_divisors(n: u32) -> u32 {
    let mut divisors: u32 = 0;
    let mut i : u32 = 1;
    while i.pow(2) <= n {
        if n % i == 0 {
            if n / i == i {
                divisors +=1;
            }
            else {
                divisors += 2;
            }
        }
        i += 1;
    }
    return divisors;
}

fn main() {
    let now = Instant::now();

    // let mut num = 1;
    // let mut res = 1;
    // while num_divisors(res) <= 500 {
    //     num += 1;
    //     res += num;
    // }

    let res: u32 = (1u32..)
        .map(|n| (n * (n + 1)) / 2)
        .find(|&n| num_divisors(n) > 500)
        .unwrap();

    let elapsed = now.elapsed();
    let ms = elapsed.as_secs()*1000 + elapsed.subsec_millis() as u64;
    println!("{}\n{} ms",res,ms)
}
