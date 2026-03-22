#ifndef ASSIGNMENTS_H
#define ASSIGNMENTS_H

// assignment3.asm
extern int obsah_obdelnika(int a, int b);
extern int obvod_ctverce(int a);
extern int obsah_ctverce(int a);
extern int obvod_trojuhelnika(int a, int b, int c);
extern int obvod_trojuhelnika2(int a);
extern int obsah_trojuhelnika2(int a, int b);
extern int objem_krychle(int a);
extern unsigned int avg(unsigned int a, unsigned int b, unsigned int c);

// assignment4.asm
extern int sgn(int i);
extern char max2c(char a, char b);
extern unsigned short min3us(unsigned short a, unsigned short b, unsigned short c);
extern int kladne(int a, int b, int c);
extern int mocnina(int n, unsigned int m);

// assignment5.asm
extern void swap(int *a, int *b);
extern void division(unsigned int x, unsigned int y, unsigned int *result, unsigned int *remainder);
extern void countdown(int *values);
extern void nasobky(short *multiples, short n);
extern int minimum(int count, int *values);
extern unsigned int my_strlen(char *s);
extern void my_strcat(char *dest, char *src);

#endif