use std::time::Instant;
use std::fs::File;
use std::io::prelude::*;

fn main() {
    let now = Instant::now();

    let mut file = File::open("p22-names.txt").expect("No file");
    let mut contents = String::new();
    file.read_to_string(&mut contents).expect("Unable to read");
    let mut resvec = contents
        .split(",")
        .collect::<Vec<&str>>();
    resvec.sort();
    let res: u32 = resvec.iter()
        .map(|n| n.trim_matches('"')
             .chars()
             .map(|c| c as u32 - 64)
             .sum::<u32>())
        .enumerate()
        .map(|(i,val)| (i+1) as u32 * val)
        .sum() ;

    let elapsed = now.elapsed();
    let ms = elapsed.as_secs()*1000 + elapsed.subsec_millis() as u64;
    println!("{}\n{} ms",res,ms)
}
