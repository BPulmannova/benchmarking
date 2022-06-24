double babylonian(double root, double guess, int iterations);


#include <stdio.h>

int main(){
    printf("baby: %f\n", babylonian(2, 100, 1000000));
    return 0;
}