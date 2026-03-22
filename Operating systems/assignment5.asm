section .text

global swap
global division
;global countdown
;global nasobky
;global minimum
;global my_strlen
;global my_strcat

swap:
    mov eax, dword [rdi]    ;do eax nacteme hodnotu prvniho argumentu
    mov edx, dword [rsi]    ;do edx nacteme hodnotu druheho argumentu
    mov dword [rdi], edx    ;do rdi ulozime hodnotu druheho argumentu
    mov dword [rsi], eax    ;do rsi ulozime hodnotu prvniho argumentu
    ret

division:
    mov eax, edi            ;do eax nacteme hodnotu prvniho argumentu
    xor edx, edx            ;vynulování edx
    mov r8, rdx             ;ulozeni adresy prvniho argumentu
    mov r9, rcx             ;ulozeni adresy prvniho argumentu
    div esi                 ;vydelime hodnotou druheho argumentu
    mov dword [r8], eax     ;ulozime result
    mov dword [r9], edx     ;ulozime remaider
    ret

section .note.GNU-stack noalloc noexec nowrite progbits