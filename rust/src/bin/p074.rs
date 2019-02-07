use std::time::Instant;
use numbers::*;
use std::collections::HashSet;
use rayon::prelude::*;

fn main() {
    let now = Instant::now();

    fn digit_fact_sum(n: u64) -> u64 {
        n.to_string()
            .chars()
            .map(|c| factorial(c.to_digit(10).unwrap() as u64))
            .sum()
    }

    fn chain_length(mut n: u64) -> usize {
        let mut seen = HashSet::new();
        seen.insert(n);
        let mut dfactsum = digit_fact_sum(n);
        while !seen.contains(&dfactsum) {
            seen.insert(dfactsum);
            n = dfactsum;
            dfactsum = digit_fact_sum(n);
        }
        seen.len()
    }

    let res = (1u64..1000000).into_par_iter().filter(|&n| chain_length(n) == 60).count();

    let elapsed = now.elapsed();
    let ms = elapsed.as_secs()*1000 + elapsed.subsec_millis() as u64;
    println!("{}\n{} ms",res,ms)
}
