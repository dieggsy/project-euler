#include <stdio.h>

int main () {
    int sum = 0;
    int oldi;
    for (int i = 1, j = 2; j <= 4000000; oldi = i, i = j, j = oldi + j) {
        if (j % 2 == 0) {
            sum += j;
        }
    }

    printf("%d\n", sum);
    return 0;
}
