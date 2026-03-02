#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>

//* Možné velikosti tabulky, jedná se o prvočísla, přibližně dvojnásobné velikosti
int sizes[9] = {11, 23, 53, 97, 193, 389, 853, 1543};

typedef struct Row{
    char* word;
    int number;
} Row;

int row_number(Row* x){
    return x->number;
}

char* row_word(Row* x){
    return x->word;
}

typedef struct element{
    char* word;
    Row* data;
    //* -1 - smazané, 0 - prázdné, 1 - plné
    int condition;
} element;

typedef struct Hash_table{
    element* data;
    int size;
} Hash_table;

int hash(char* word, int size){
    int cislo = 0;
    int i = 0;
    while (word[i] != '\0'){
        cislo = cislo + word[i];
        i++;
    }
    return cislo % size;
}

void hash_table_add(Hash_table* table, Row* row, int database_size){
    int index;
    int i = 0;
    while (i < database_size){
        index = (hash(row->word, database_size)+i)%database_size;
        //* Přidáváme v momentě, kdy je místo prázdné, jsou povoleny i duplicitní hodnoty
        if (table->data[index].condition != 1){
            table->data[index].condition = 1;
            table->data[index].data = row;
            table->data[index].word = row->word;
            break;
        }
        i++;
    }
}

Hash_table* create_hash_table_index(Row database[], int database_size){
    Hash_table* res = malloc(sizeof(Hash_table));
    assert(res);
    res->data = malloc(database_size*(sizeof(element)));
    assert(res->data);
    res->size = database_size;
    for (int i = 0; i < database_size; i++){
        //* Databáze může mít větší kapacitu než počet prvků, tedy posledních několik prvků může být NULL - ty nepřidáváme
        if (database[i].word == NULL){
            break;
        }
        hash_table_add(res, &database[i], database_size);
    }
    return res;
}

Row* hash_search(Hash_table table, char* word){
    int index;
    int i = 0;
    while (i < table.size){
        index = (hash(word, table.size)+i)%table.size;
        if (table.data[index].condition == 1 && strcmp(word, table.data[index].word) == 0){
            printf("Pozic zkontrolováno: %d. \n", i+1);
            return table.data[index].data;
        }
        else if (table.data[index].condition == 0){
            printf("Pozic zkontrolováno: %d. \n", i+1);
            return NULL;
        }
        i++;
    }
    printf("Pozic zkontrolováno: %d. \n", i+1);
    return NULL;
}

int hash_delete(Hash_table table, char* word){
    int index;
    for (int i = 0; i < table.size; i++){
        index = (hash(word, table.size)+i)%table.size;
        if (table.data[index].condition == 0){
            return 0;
        }
        if (table.data[index].condition == 1 && strcmp(word, table.data[index].word) == 0){
            table.data[index].condition = -1;
            table.data[index].word = NULL;
            table.data[index].data = NULL;
            return 1;
        }
    }
    return 0;
}

//* Úkol ze ZPC2
int get_number(FILE* f){
    int z = 0;
    int cislo = 0;
    while (1){
        z = getc(f);
        if (z == 32 || z == 10 || z == EOF){
            break;
        }
        cislo = cislo*10 + (z-48);
    }
    return cislo;
}

char* get_word(FILE* f){
    int z = 0;
    int size = 10;
    char* word = malloc(size);
    assert(word);
    int i = 0;
    while (1){
        if (i == size-1){
            size *= 2;
            word = realloc(word, size);
        }
        z = getc(f);
        if (z == 32 || z == 10 || z == EOF){
            break;
        }
        word[i] = (char)z;
        i++;
    }
    word[i] = '\0';
    return word;
}

Row* create_database(char* file_path){
    FILE* f = fopen(file_path, "rt");
    assert(f);

    int size = 0;
    Row* db = malloc(sizes[size]*sizeof(Row));
    assert(db);

    int i = 0;
    while(1){
        if (feof(f)){
            break;
        }
        if (i == sizes[size]){
            size++;
            if (size == 9){
                printf("Došly velikosti tabulek, dopiště prvočísla do sizes na začátku souboru.\n");
                size--;
                break;
            }
            else{
                db = realloc(db, sizes[size]*sizeof(Row));
            }
        }
        db[i].word = get_word(f);
        db[i].number = get_number(f);
        i++;
    }
    printf("Velikost talbulky je: %d\nPočet prvků je: %d\n", sizes[size], i);
    fclose(f);
    return db;
}

Row* naive_search_by_number(Row database[], int database_size, int number){
    int i = 0;
    while (i != database_size){
        if (database[i].number == number){
            printf("Zkontrolováno %d řádků. \n", i+1);
            return &(database[i]);
        }
        i++;
    }
    return NULL;
}

Row* naive_search_by_word(Row database[], int database_size, char* word){
    int i = 0;
    while (i < database_size){
        if (strcmp(database[i].word, word) == 0){
            printf("Zkontrolováno %d řádků. \n", i+1);
            return &(database[i]);
        }
        i++;
    }
    return NULL;
}

int main(){
    Row* db = create_database("table.txt");
    int database_size = 193;

    // for (int i = 0; i < database_size; i++) {
    //     printf("%s -> %d\n", gg[i].word, gg[i].number);
    // }
    char w[8] = "dolphin";
    printf("%s\n", naive_search_by_number(db, database_size, 1001)->word);
    printf("%d\n", naive_search_by_word(db, database_size, w)->number);

    Hash_table* table = create_hash_table_index(db, database_size);
    // for (int i = 0; i < database_size; i++) {
    //     if (table->data[i].word != NULL){
    //         printf("%s\n", table->data[i].word);
    //     }
    //     else{
    //         printf("Neexistuje.\n");
    //     }
    // }
    Row* res = hash_search(*table, w);
    if (res != NULL){
        printf("%s %d\n", res->word, res->number);
    }
    else{
        printf("Neexistuje.\n");
    }

    int a = hash_delete(*table, w);
    if (a == 1){
        printf("Smazáno\n");
    }

    res = hash_search(*table, w);
    if (res != NULL){
        printf("%s %d\n", res->word, res->number);
    }
    else{
        printf("Neexistuje.\n");
    }

    for (int i = 0; i < 165; i++){
        free(db[i].word);
    }
    free(table->data);
    free(table);
    free(db);
    return 0;
}