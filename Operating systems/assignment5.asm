section .text

global swap
global division
global countdown
global nasobky
global minimum
global my_strlen
;global my_strcat

swap:
    mov eax, dword [rdi]    ;do eax nacteme hodnotu prvniho argumentu
    mov edx, dword [rsi]    ;do edx nacteme hodnotu druheho argumentu
    mov dword [rdi], edx    ;do rdi ulozime hodnotu druheho argumentu
    mov dword [rsi], eax    ;do rsi ulozime hodnotu prvniho argumentu
    ret

division:
    mov eax, edi            ;do eax nacteme hodnotu prvniho argumentu
    mov r8, rdx             ;ulozeni adresy prvniho argumentu
    mov r9, rcx             ;ulozeni adresy prvniho argumentu
    xor edx, edx            ;vynulování edx
    div esi                 ;vydelime hodnotou druheho argumentu
    mov dword [r8], eax     ;ulozime result
    mov dword [r9], edx     ;ulozime remaider
    ret

countdown:
    mov eax, 0                      ;ulozeni indexu do eax
    mov r8d, 10                     ;ulozeni 10 do r8d
countdown_loop:
    cmp eax, 10                     ;kontrola pokud je index = 10
    je countdown_end                ;index = 10 -> konec
    mov dword [rdi + rax * 4], r8d  ;posunuti se v poli o 1 int a ulozeni hodnoty v r8d do pole
    inc eax                         ;eax++
    dec r8d                         ;r8d--
    jmp countdown_loop              ;opakovani loop
countdown_end:
    ret

nasobky:
    mov eax, 0                      ;index
    mov r8w, si                     ;ulozeni
nasobky_loop:
    cmp eax, 10                     ;kontrola pokud je index = 10
    je nasobky_end                  ;index = 10 -> konec
    mov word [rdi + rax * 2], r8w   ;posunuti se v poli o 1 short a ulozeni hodnoty v r8w do pole
    inc eax                         ;eax++
    add r8w, si                     ;vypocet dalsiho nasobku
    jmp nasobky_loop                ;opakovani loop
nasobky_end:
    ret

minimum:
    mov eax, dword [rsi]            ;minumum
    mov ecx, 1                      ;index    
minimum_loop:
    cmp ecx, edi                    ;kontrola jestli je index = poctu prvku
    je minimum_end                  ;pokud ano -> konec
    mov r8d, dword [rsi + rcx * 4]  ;kopirovani hodnoty z pole do r8d
    cmp eax, r8d                    ;porovnani
    jl minimum_continue             ;pokud neni mensi tak continue
    mov eax, r8d                    ;ulozeni noveho minima
minimum_continue:
    inc ecx                         ;navyseni indexu
    jmp minimum_loop                ;opakovani loop
minimum_end:
    ret

my_strlen:
    mov eax, 0                      ;pocet a index
my_strlen_loop:
    mov r8b, byte [rdi + rax * 1]   ;presunuti char do r8b
    cmp r8b, 0                      ;kontrola jestli nejsme na konci slova
    jz my_strlen_end                ;skok na konce
    inc eax                         ;eax++
    jmp my_strlen_loop              ;opakovani loop
my_strlen_end:
    ret

section .note.GNU-stack noalloc noexec nowrite progbits