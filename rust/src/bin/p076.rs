use std::time::Instant;

fn main() {
    let now = Instant::now();

    let to_exp: Vec<Vec<u64>> = vec![vec![1, 1, 1, 1, 1, 1, 1, 1, 1],
                                     vec![1, 0, 1, 0, 1, 0, 1, 0, 1],
                                     vec![1, 0, 0, 1, 0, 0, 1, 0, 0],
                                     vec![1, 0, 0, 0, 1, 0, 0, 0, 1],
                                     vec![1, 0, 0, 0, 0, 1, 0, 0, 0],
                                     vec![1, 0, 0, 0, 0, 0, 1, 0, 0],
                                     vec![1, 0, 0, 0, 0, 0, 0, 1, 0],
                                     vec![1, 0, 0, 0, 0, 0, 0, 0, 1]];

    let res: Vec<u64> = to_exp.iter().fold(vec![1], |acc, x| {
        let m = acc.len();
        let n = x.len();
        let mut res = vec![0; m + n - 1];
        for i in 0..m {
            for j in 0..n {
                res[i + j] = res [i + j] + acc[i] * x[j];
            }
        }
        res
    });

    let elapsed = now.elapsed();
    let ms = elapsed.as_secs() * 1000 + elapsed.subsec_millis() as u64;
    println!("{:?}\n{} ms", res, ms)
}
