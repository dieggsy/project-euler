use std::time::Instant;
use std::fs::File;
use std::io::prelude::*;

fn main() {
    let now = Instant::now();

    let mut file = File::open("p99-base-exp.txt").expect("No file");
    let mut contents = String::new();
    file.read_to_string(&mut contents).expect("Unable to read");
    fn str_to_logexp(s: &str) -> f64 {
        let v = s.split(",").map(|n| n.parse::<f64>().expect("Not a num")).collect::<Vec<_>>();
        v[1] * v[0].log(10.0)
    };
    let res = contents
        .lines()
        .enumerate()
        .max_by(|&a,&b| {
            str_to_logexp(a.1).partial_cmp(&str_to_logexp(b.1)).unwrap()
        })
        .unwrap().0 + 1;

    let elapsed = now.elapsed();
    let ms = elapsed.as_secs()*1000 + elapsed.subsec_millis() as u64;
    println!("{}\n{} ms",res,ms)
}
