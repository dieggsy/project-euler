use std::time::Instant;

fn main() {
    let now = Instant::now();

    let N = 1000_000;
    let max = 3f64 / 7f64;
    let n_min = (N * 2) / 5;
    let n_max = (N * 3) / 7;
    // let d_min = N - (N * 3) / ((N / 2) + 1);
    // let d_min = (N / 5) * 5;
    let d_min = (N / 6) * 6;
    let d_max = (N / 7) * 7;
    // let d_min = N - n_max ;
    println!("n in {}..{}", n_min, n_max);
    println!("d in {}..{}", d_min, d_max);
    let mut res = (0, 0);
    let mut resfrac = 0.0f64;
    for n in n_min..n_max {
        for d in (d_min..=N).rev() {
            let gcd = num::integer::gcd(n, d);
            let tup = (n / gcd, d / gcd);
            let tupfrac = tup.0 as f64 / tup.1 as f64;
            if tupfrac > resfrac && tupfrac < max {
                res = tup;
                resfrac = tupfrac;
            }
        }
    }

    let elapsed = now.elapsed();
    let ms = elapsed.as_secs() * 1000 + elapsed.subsec_millis() as u64;
    println!("{:?}\n{} ms", res, ms)
}
