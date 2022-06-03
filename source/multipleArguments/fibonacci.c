#include <stdio.h>

int fibonacci(int n) {
    int result = 0;
    int previous = 1;
    for (int i=0; i<n; i++){
        int temp = result;
        result += previous;
        previous = temp;
    }
    return result;
}

int main(){
    printf("fibonacci: %d\n", fibonacci(10000000));
    return 0;
}
