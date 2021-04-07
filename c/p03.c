#include <stdio.h>
#include <math.h>
#include <stdbool.h>

bool small_prime_p(long x) {
    if (x <= 1 ) { return false; }
    else if (x <= 3) { return true; }
    else if (x % 2 == 0 || x % 3 == 0) { return false; }
    else {
        int i = 5;
        while (true) {
            if (pow(i,2) > x) {
                return true;
            }
            else if (x % i == 0 || x % (i + 2) == 0) {
                return false;
            }
            ++i;
        }
    }
}

int largest_prime_factor (long n) {
    /* int max_factor = 1; */
    /* mpz_t integ; */
    /* for (int i = 1; i < sqrt(n); ++i) { */
    /*     /\* mpz_init_set_ui(integ, i); *\/ */
    /*     /\* if (n % i == 0 && mpz_probab_prime_p(integ, 40)) { *\/ */
    /*     if (n % i == 0 && small_prime_p(i)) { */
    /*         max_factor = i; */
    /*     } */
    /* } */
    int max_factor = sqrt(n);
    while (!(n % max_factor == 0 && small_prime_p(max_factor))) {
        --max_factor;
    }
    return max_factor;
}

int main () {
    printf("%d\n", largest_prime_factor(600851475143));
    return 0;
}

