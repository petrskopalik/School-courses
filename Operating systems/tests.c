#include <stdio.h>

#include "assignment1.h"
#include "assignments.h"

int main(int argc, char const *argv[])
{
    // printf("===============ASSIGNMENT X TESTS===============\n");
    // printf("===============TESTS END===============\n");
    printf("===============ASSIGNMENT 1 TESTS===============\n");
    char test_int2bits_text[33];
    int test_int2bits_number = 8;

    int2bits(test_int2bits_text, test_int2bits_number);
    printf("%s\n", test_int2bits_text);

    char test_bits2int_n1[4] = "111";
    char test_bits2int_n2[10] = "111001101";
    char test_bits2int_n3[5] = "1110";
    char test_bits2int_n4[8] = "0011101";
    char test_bits2int_n5[12] = "11010011101";

    printf("Test 1 bits2int: %d\n", bits2int(test_bits2int_n1));
    printf("Test 2 bits2int: %d\n", bits2int(test_bits2int_n2));
    printf("Test 3 bits2int: %d\n", bits2int(test_bits2int_n3));
    printf("Test 4 bits2int: %d\n", bits2int(test_bits2int_n4));
    printf("Test 5 bits2int: %d\n", bits2int(test_bits2int_n5));

    char day = 10;
    char month = 2;
    short year = 26;

    short code = encode_date(day, month, year);
    printf("Datum zakodovane: 0x%04X\n", code);

    int d, m, y;
    decode_date(code, &d, &m, &y);
    printf("Odzakodovane datum: Den = %d, Mesic = %d, Rok = %d\n", d, m, y);
    printf("===============ASSIGNMENT 1 TESTS===============\n");

    printf("===============ASSIGNMENT 3 TESTS===============\n");
    printf("===============TESTS END===============\n");

    return 0;
}