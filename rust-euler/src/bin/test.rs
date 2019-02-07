extern crate numbers;
use crate::numbers::*;


fn main() {
    let primes = prime_sieve(10);
    println!("{}",primes[7]);
}
