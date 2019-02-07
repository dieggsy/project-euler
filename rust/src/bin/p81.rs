use std::time::Instant;
use std::fs::File;
use std::io::prelude::*;
use ndarray::prelude::*;
use util::data_file;

fn main() {
    let now = Instant::now();

    let mut file = File::open(data_file("p81-matrix.txt")).expect("No file");
    let mut matstr = String::new();
    file.read_to_string(&mut matstr).expect("Unable to read");

    let mut mat = Array2::<u64>::zeros((80,80));

    matstr.trim().lines().enumerate().for_each(|(row,line)| {
        line.split(",").enumerate().for_each(|(col,numstr)| {
            mat[[row,col]] = numstr.parse().expect("Not a number!");
        })
    });
    for row in 0..80  {
        for col in 0..80 {
            let left = match col {
                0 => None,
                _ => Some([row, col-1])
            };
            let up = match row {
                0 => None,
                _ => Some([row-1, col])
            };
            match (left, up) {
                (Some(li), Some(ui)) => {
                    mat[[row,col]] += std::cmp::min(mat[li], mat[ui])
                },
                (None, Some(i)) | (Some(i), None) => mat[[row,col]] += mat[i],
                (None, None) => {}
            }
        }
    };
    let res = mat[[79,79]];


    let elapsed = now.elapsed();
    let ms = elapsed.as_secs()*1000 + elapsed.subsec_millis() as u64;
    println!("{}\n{} ms",res,ms)
}
