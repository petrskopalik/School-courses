extern putchar
extern malloc
extern strlen

section .text

global print_row
global print_rect
global factorial
global my_strdup
global fib
global print_facts

; void print_row(int n, char c)
print_row:
    mov edx, edi        ;ulozeni prvniho argumentu - n
    mov ecx, esi        ;ulozeni druheho argumentu - char
print_row_loop:
    push rdx            ;ulozeni n na zasobnik
    push rcx            ;ulozeni char na zasobnik
    mov edi, ecx        ;predani argumetnu
    mov al, 0           ;0 arg s plovouci radkovou carkou
    call putchar        ;zavolani putchar
    pop rcx             ;vraceni char
    pop rdx             ;vraceni n
    dec edx             ;snizeni poctu o 1
    cmp edx, 0          ;porovnani n s 0
    jg print_row_loop   ;pokud n > 0 opakuj loop
    mov edi, 10         ;10 = /n
    mov al, 0           ;0 arg s plovouci radkovou carkou
    call putchar        ;tisk /n
    ret

; void print_rect(int rows, int cols)
print_rect:
    mov edx, edi        ;ulozeni prvniho argumentu - rows
    mov ecx, esi        ;ulozeni druheho argumentu - cols
print_rect_loop:
    push rdx            ;ulozeni rows na zasobnik
    push rcx            ;ulozeni cols na zasobnik
    mov edi, ecx        ;argument pro delku radku
    mov esi, 42         ;argument pro znak
    mov al, 0           ;0 arg s plovouci radkovou carkou
    call print_row      ;vytisknuti row
    pop rcx             ;vraceni cols
    pop rdx             ;vraceni rows
    dec edx             ;dekrementace rows
    cmp edx, 0          ;porovnani s 0
    jg print_rect_loop  ;pokud rows > 0 - opakuj loop
    ret

; unsigned int factorial(unsigned int n)
factorial:
    mov eax, 1          ;ulozeni vysledku
    mov ecx, edi        ;ulozeni argumentu - n
factorial_loop:
    cmp ecx, 1          ;porovnani n s 1
    jle factorial_end   ;pokud n <= 1 -> konec
    imul eax, ecx       ;vynasobeni vysledku s aktualnim n
    dec ecx             ;zmenseni n
    jmp factorial_loop  ;opakuj loop
factorial_end:
    ret

; char *my_strdup(char *s)
my_strdup:
    push rdi                        ;uloz argument *s na zasobnik
    mov al, 0                       ;0 arg s plovouci radkovou carkou
    call strlen                     ;zavolani strlen
    mov r8, rax                     ;ulozeni vysledku (delky retezce) strlen do r8
    push r8                         ;ulozeni r8 na zasobnik
    mov edi, eax                    ;predani argumentu pro malloc
    mov al, 0                       ;0 arg s plovouci radkovou carkou
    call malloc                     ;zavolani malloc, vrati adresu v rax
    pop r8                          ;vraceni delky retezce do r8
    pop rdi                         ;vraceni argumentu *s do rdi
    cmp r8, 0                       ;porovnani delky retezce s 0
    je my_strdup_end                ;skok na konec
    mov rcx, 0                      ;aktualni index v retezci
    ;pouzito rax - adresa nove pameti, rdi - adresa retezce, r8 - delka retezce, rcx - index retezce     
my_strdup_loop:
    mov dl, byte [rdi + rcx * 1]    ;ulozeni aktualniho char (z puvodniho retezce) do dl
    mov byte [rax + rcx * 1], dl    ;ulozeni char do noveho retezce
    inc rcx                         ;inkrementace indexu
    cmp rcx, r8                     ;porovnani indexu a delky retezce
    je my_strdup_end                ;pokud ano tak konec
    jmp my_strdup_loop              ;opakuj loop
my_strdup_end:
    ret

; unsigned int fib(unsigned short n)
fib:
    mov esi, 0      ;predposledni
    mov eax, 1      ;posledni
fib_loop:
    cmp edi, 1      ;n <= 1
    jle fib_end     ;pokud ano -> 
    dec edi         ;dekrementace n
    mov r8, eax
    add eax, esi
    mov esi, r8
    jmp fib_loop
fib_end:
    ret


section .note.GNU-stack noalloc noexec nowrite progbits