use std::time::Instant;

fn is_palindrome_p(i: u32) -> bool {
    let mut n = i;
    let mut reverse = 0;
    while n != 0 {
        reverse *= 10;
        reverse = reverse + n % 10;
        n /= 10;
    }
    return i == reverse;

}


fn main() {
    let now = Instant::now();

    let mut res = 0;
    for i in 900..=999 {
        for j in 900..=999 {
            let prod = i*j;
            if is_palindrome_p(prod) && prod > res {
                res = prod;
            }
        }
    }

    let elapsed = now.elapsed();
    let ms = elapsed.as_secs()*1000 + elapsed.subsec_millis() as u64;
    println!("{}\n{} ms",res,ms)
}
