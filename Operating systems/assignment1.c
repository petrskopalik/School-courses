#include <stdio.h>
#include <stdlib.h>

int pow2(int num){
    if (num == 0) return 1;
    int result = 2;
    while (num != 1){
        result *= 2;
        num--;
    }
    return result;
}

void int2bits(char *result, int number){
    int number_of_bits = 1;
    while (pow2(number_of_bits) <= number){
        number_of_bits++;
    }
    // printf("Počet bittů: %d\n", number_of_bits);

    for (int i = number_of_bits; i > 0; i--){
        result[number_of_bits - i] = (number & (1 << (i - 1))) ? '1' : '0';
    }
    result[number_of_bits] = '\0';
}

int bits2int(char *number){
    int size = 0;
    while (*(number + size) != '\0'){
        size++;
    }

    int result = 0;

    for (int index = 0; index < size; index++){
        result = result << 1;
        if (*(number + index) == '1') result |= 1;
    }
    
    return result;
}

typedef struct human{
    char *name;
    int age;
    struct human *next;
} human;

typedef struct human_list{
    human *root;
} human_list;

human_list* create_human_list(){
    return malloc(sizeof(human_list));
}

human* create_human(char *name, int age){
    human *new_human = malloc(sizeof(human));
    new_human->age = age;
    new_human->name = name;

    return new_human;
}

human* insert_human(human_list *list, human *new_human){
    new_human->next = list->root;
    list->root = new_human;

    return new_human;
}

void print_human(human *person){
    printf("Name: %s, Age: %d", person->name, person->age);
}

void print_humans(human *persons){
    print_human(persons);
    if (persons->next) print_humans(persons->next);
}

int main(){
    char test_int2bits_text[33];
    int test_int2bits_number = 8;

    int2bits(test_int2bits_text, test_int2bits_number);
    printf("%s\n", test_int2bits_text);

    char test_bits2int_n1[4] = "111";
    char test_bits2int_n2[10] = "111001101";
    char test_bits2int_n3[5] = "1110";
    char test_bits2int_n4[8] = "0011101";
    char test_bits2int_n5[12] = "11010011101";

    printf("Test1: %d\n", bits2int(test_bits2int_n1));
    printf("Test2: %d\n", bits2int(test_bits2int_n2));
    printf("Test3: %d\n", bits2int(test_bits2int_n3));
    printf("Test4: %d\n", bits2int(test_bits2int_n4));
    printf("Test5: %d\n", bits2int(test_bits2int_n5));

    return 0;
}