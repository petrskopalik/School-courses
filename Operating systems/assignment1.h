#ifndef ASSIGNMENT1_H
#define ASSIGNMENT1_H

void int2bits(char *result, int number);
int bits2int(char *number);
void decode_date(short date, int *day, int *month, int *year);
short encode_date(char day, char month, short year);

#endif