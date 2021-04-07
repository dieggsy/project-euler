#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <string.h>

bool is_palindrome(int i) {
    char s[10];
    sprintf(s, "%d", i);
    for (int i=0,j=strlen(s)-1;j>=0; ++i, --j) {
        if (s[i] != s[j]) {
            return false;
        }
    }
    return true;
}

int main () {
    int biggest = 0;
    for (int i = 999; i > 100; --i) {
        for (int j = 990; j > 100; --j) {
            int prod = i * j;
            if (is_palindrome(prod) && prod > biggest) {
                biggest = prod;
            }

        }
    }
    printf("%d\n", biggest);
    return 0;
}
