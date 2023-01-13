#include <stdio.h>

int main(void){
    char input[0x100];
    while(fgets(input, 0x100, stdin)){
        printf("Echoing back: \n%s\n", input);
        for (int i = 0; i < 0x100; i += 0x10){
            for (int j = 0; j < 0x10; j += 4){
                printf("0x%02x%02x%02x%02x ", (unsigned char)input[i+j], (unsigned char)input[i+j+1], (unsigned char)input[i+j+2], (unsigned char)input[i+j+3]);
            }
            printf("\n");
        }
    }
    return 0;
}