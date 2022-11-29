#include <stdio.h>
#include <stdlib.h>

void seed_solve(int seed){
    srand(seed);
}

int random_solve(int seed){
    return rand();
}