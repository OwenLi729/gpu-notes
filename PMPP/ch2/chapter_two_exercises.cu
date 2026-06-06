#include <stdio.h>

//basic pointer exercise

int main() {
    int x = 4; // 4 byte integer x set to 4
    int * pX = &x; // integer pointer pX (denoted with *) is equal to address of x (denoted with &)
    int y = *pX; // integer y is equal to the value pointed to by pX (denoted with *)
    printf("%d\n", y); //format specifier first!
    return 0;
}

