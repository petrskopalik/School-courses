#include <stdio.h>
#include <assert.h>

#include "assignment1.h"
#include "assignments.h"

int main(int argc, char const *argv[])
{
    // printf("========== ASSIGNMENT X TESTS START ==========\n");
    // printf("========== ASSIGNMENT X TESTS END   ==========\n\n");
    printf("========== ASSIGNMENT 1 TESTS START ==========\n");
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
    printf("========== ASSIGNMENT 1 TESTS END   ==========\n\n");

    printf("========== ASSIGNMENT 3 TESTS START ==========\n");
    assert(6 == obsah_obdelnika(2, 3));
    assert(16 == obvod_ctverce(4));
    assert(16 == obsah_ctverce(4));
    assert(6 == obvod_trojuhelnika(1, 2, 3));
    assert(6 == obvod_trojuhelnika2(2));
    assert(6 == obsah_trojuhelnika(3, 4));
    assert(27 == objem_krychle(3));
    assert(2 == avg(1, 2, 3));
    printf("========== ASSIGNMENT 3 TESTS END   ==========\n\n");

    printf("========== ASSIGNMENT 4 TESTS START ==========\n");
    assert(0 == sgn(0));
    assert(1 == sgn(20));
    assert(-1 == sgn(-4));
    assert('b' == max2c('a', 'b'));
    assert(1 == min3us(1, 23323, 32761));
    assert(1 == kladne(1, 2, 3));
    assert(0 == kladne(1, 2, -2));
    assert(0 == kladne(0, 1, 2));
    assert(512 == mocnina(2, 9));
    assert(1 == mocnina(100, 0));
    assert(-1 == mocnina(0, 0));
    printf("========== ASSIGNMENT 4 TESTS END   ==========\n\n");

    printf("========== ASSIGNMENT 5 TESTS START ==========\n");
    int swap_a = 10;
    int swap_b = -10;
    swap(&swap_a, &swap_b);
    assert(-10 == swap_a);
    assert(10 == swap_b);

    unsigned int division_result = 0;
    unsigned int division_remaider = 0;
    division(10, 9, &division_result, &division_remaider);
    assert(1 == division_result);
    assert(1 == division_remaider);

    int countdown_result[10];
    int countdown_expected[10] = {10, 9, 8, 7, 6, 5, 4, 3, 2, 1};
    countdown(&(countdown_result[0]));
    for (size_t i = 0; i < 10; i++){
        assert(countdown_expected[i] == countdown_result[i]);
    }

    short nasobky_result[10];
    // short nasobky_expected[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}; // 1
    short nasobky_expected[10] = {5, 10, 15, 20, 25, 30, 35, 40, 45, 50}; // 5
    nasobky(&(nasobky_result[0]), 5);
    for (size_t i = 0; i < 10; i++){
        // printf("%hd ", nasobky_result[i]);
        assert(nasobky_expected[i] == nasobky_result[i]);
    }
    // printf("\n");

    int minimum_args[10] = {5, 6, 3, 2, 10, -1, 2, 8, 9, 0};
    int minimum_result = -1;
    assert(minimum_result == minimum(10, &(minimum_args[0])));

    char my_strlen_arg[3] = "ab";
    unsigned int my_strlen_result = 2;
    assert(my_strlen_result == my_strlen(&(my_strlen_arg[0])));
    printf("========== ASSIGNMENT 5 TESTS END   ==========\n\n");

    printf("========== ASSIGNMENT 6 TESTS START ==========\n");
    print_row(5, 'a');
    printf("\n");
    print_rect(5, 5);
    printf("\n");
    // printf("%u\n", factorial(5));
    assert(120 == factorial(5));
    char my_strdup_arg[13] = "Hello world!";
    char *my_strdup_result = my_strdup(&(my_strdup_arg[0]));
    printf("%s\n", my_strdup_result);

    printf("========== ASSIGNMENT 6 TESTS END   ==========\n\n");

    return 0;
}