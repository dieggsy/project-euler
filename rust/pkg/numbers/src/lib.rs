use num::Num;

pub fn small_prime_p<N: Num + PartialOrd + Copy>(x: N) -> bool {
    let _0 = N::zero();
    let _1 = N::one();
    let _2 = _1 + _1;
    let _3 = _2 + _1;
    let _5 = _2 + _3;
    let _6 = _3 + _3;
    if x <= _3 {
        return x > _1;
    } else if x % _2 == _0 || x % _3 == _0 {
        return false;
    } else {
        let mut i = _5;
        while i * i <= x {
            if x % i == _0 || x % (i + _2) == _0 {
                return false;
            }
            i = i + _6;
        }
        return true;
    }
}

pub fn euler_sieve(n: usize) -> Vec<bool> {
    let mut is_prime = vec![true; n + 1];
    is_prime[0] = false;
    is_prime[1] = false;
    for i in 2..n {
        if is_prime[i] {
            for j in (i * i..n).step_by(i) {
                is_prime[j] = false;
            }
        }
    }
    is_prime
}

pub fn arithmetic_sum<N: Num + PartialOrd + Copy>(first: N, last: N, n: N) -> N {
    let _0 = N::zero();
    let _1 = N::one();
    let _2 = _1 + _1;
    return n * (first + last) / _2;
}

pub fn factorial<N: Num + PartialOrd + Copy>(n: N) -> N {
    let _0 = N::zero();
    let _1 = N::one();
    if n == _0 {
        return _1;
    }
    let mut res = _1;
    let mut i = n;
    while i >= _1 {
        res = res * i;
        i = i - _1;
    }
    return res;
}

#[macro_export]
macro_rules! max {
    ($x:expr) => ( $x );
    ($x:expr, $($xs:expr),+) => {
        {
            std::cmp::max($x, max!( $($xs),+ ))
        }
    };
}

#[macro_export]
macro_rules! min {
    ($x:expr) => ( $x );
    ($x:expr, $($xs:expr),+) => {
        {
            min($x, min!( $($xs),+ ))
        }
    };
}
