extern putchar

section .text

global print_row
global print_rect
global factorial
global my_strdup
global fib
global print_facts

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

factorial:
    mov eax, 1          ;ulozeni vysledku
    mov ecx, esi        ;ulozeni argumentu - n
factorial_loop:
    cmp ecx, 1          ;porovnani n s 1
    jle factorial_end   ;pokud n <= 1 -> konec
    imul eax, ecx       ;vynasobeni vysledku s aktualnim n
    dec ecx             ;zmenseni n
    jmp factorial_loop  ;opakuj loop
factorial_end:
    ret

section .note.GNU-stack noalloc noexec nowrite progbits