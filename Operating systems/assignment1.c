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

short encode_date(char day, char month, short year){
    return year << 9 | month << 5 | day;
}

void decode_date(short date, int *day, int *month, int *year){
    *day = date & 0b0000000000011111;
    *month = (date >> 5) & 0b00000001111;
    *year = date >> 9;
}

void my_memcpy(void *dest, void *src, size_t size){
    unsigned char *x = dest;
    unsigned char *y = src;

    for (int i = 0; i < size; i++, x++, y++){
        *x = *y;
    }
}