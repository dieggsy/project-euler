// -*- mode: cpp -*-
#include <cmath>
#include <type_traits>

// #include <array>
// // #include <algorithm>

// static const int NN = 1000; // Very small prime limit

// static constexpr std::array<bool,NN+1> fill_array() {
//     std::array<bool, NN+1> ps { };
//     for (auto &elem : ps) {
//         elem = true;
//     }
//     // ps.fill(true);
//     // std::fill(ps.begin(),ps.end(),true);
//     ps[0] = false;
//     ps[1] = false;
//     for (int n = 2; n <= NN; ++n) {
//         if (ps[n]) {
//             for (int m = 2 * n; m <= NN; m+=n) {
//                 ps[m] = false;
//             }
//         }
//     }
//     return ps;
// }
// static constexpr std::array<bool, NN+1> prime = fill_array();

template <
    typename T,
    typename = std::enable_if<std::is_arithmetic<T>::value>
    >
bool small_prime_p(T x) {
    if (x <= 3) { return x > 1; }
    else if (x % 2 == 0 || x % 3 == 0) { return false; }
    else {
        T i = 5;
        while (i*i <= x) {
            if (x % i == 0 || x % (i + 2) == 0) {
                return false;
            }
            i+=6;
        }
    }
    return true;
}

template <
    typename T,
    typename = std::enable_if<std::is_arithmetic<T>::value>
    >
T nth_digit(T m, int n) {
    return ((m % static_cast<T>(std::pow(10,n + 1))) - (m % static_cast<T>(std::pow(10, n))))
        / static_cast<T>(std::pow(10, n));
}

template <
    typename T,
    typename = std::enable_if<std::is_arithmetic<T>::value>
    >
T digit_sum(T n) {
    T pow = 0;
    T res = 0;
    while (std::pow(10,pow) <= n) {
        T digit = nth_digit(n, pow);
        res += digit;
        ++pow;
    }
    return res;
}

template <
    typename T,
    typename = std::enable_if<std::is_arithmetic<T>::value>
    >
T factorial(T n) {
    T result = 1;
    if (n == 0) {
        return result;
    }
    for (int i = n; i >= 1;--i) {
        result *= i;
    }
    return result;
}

template <
    typename T,
    typename = std::enable_if<std::is_arithmetic<T>::value>
    >
T binomial_coefficient(T n, T k) {
    if (k > n || k < 0) {
        return 0;
    } else if (k == 0 || k == n) {
        return 1;
    }
    k = std::min(k, n - k);
    T res = 1;
    for (T i = 1; i <= k; ++i) {
        res *= (n + 1 - i);
        res /= i;
    }
    return res;
}
