use std::time::Instant;

fn main() {
    let now = Instant::now();

    fn d(n: u32) -> u32 {
        1 + (2..=(n as f64).sqrt() as u32)
            .filter(|i| n % i == 0)
            .map(|i| {
                if n / i == i {
                    i
                } else {
                    i + n/i}
            })
            .sum::<u32>()
    }

    let mut sum_of_abundant = [false; 28123*2+1] ;

    let abundant = (12usize..=28123).filter(|&n| d(n as u32) > n as u32).collect::<Vec<usize>>();

    for a in 0..abundant.len() {
        for b in a..abundant.len() {
            sum_of_abundant[abundant[a] + abundant[b]] = true;
        }
    }

    let res: usize = (0usize..=28123).filter(|n| !sum_of_abundant[*n]).sum();

    let elapsed = now.elapsed();
    let ms = elapsed.as_secs()*1000 + elapsed.subsec_millis() as u64;
    println!("{}\n{} ms",res,ms)
}
