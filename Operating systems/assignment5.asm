section .text

global swap
global division
global countdown
global nasobky
global minimum
global my_strlen
global my_strcat

swap:
    mov eax, dword [rdi]    ;do eax nacteme hodnotu prvniho argumentu
    mov edx, dword [rsi]    ;do edx nacteme hodnotu druheho argumentu
    mov dword [rdi], edx    ;do rdi ulozime hodnotu druheho argumentu
    mov dword [rsi], eax    ;do rsi ulozime hodnotu prvniho argumentu
    ret

division:
    mov eax, edi            ;do eax nacteme hodnotu prvniho argumentu
    div esi                 ;vydelime hodnotou druheho argumentu
    mov dword [rdx], eax    ;ulozime result
    mov dword [rcx], edx    ;ulozime remaider
    ret