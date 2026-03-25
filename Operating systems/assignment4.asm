section .text

global sgn
global max2c
global min3us
global kladne
global mocnina

; int sgn(int i)
sgn:
    cmp edi, 0      ;porovnáme prvni argument s 0
    jl sgn_minus    ;skok na vraceni 0
    jg sgn_plus     ;skok na vraceni 1
    mov eax, 0      ;ulozeni 0
    ret
sgn_minus:
    mov eax, -1     ;ulozeni -1
    ret
sgn_plus:
    mov eax, 1      ;ulozeni 1
    ret

; char max2c(char a, char b)
max2c:
    mov al, dil         ;ulozime prvni argument (char) do al
    cmp al, sil         ;porovname s druhym argumentem
    ja max2c_end        ;skok na vraceni prvniho argumentu
    mov al, sil         ;ulozeni druheho argumentu
max2c_end:
    ret

; unsigned short min3us(unsigned short a, unsigned short b, unsigned short c)
min3us:
    mov eax, edi    ;ulozeni prvniho argumentu do eax
    cmp eax, esi    ;porovnani s druhym argumentem
    jb min3us_next  ;pokud eax < esi -> skok na porovnani s tretim argumentem
    mov eax, esi    ;ulozeni druheho argumentu do eax
min3us_next:
    cmp eax, edx    ;porovnani hodnoty v eax s tretim argumentem
    jb min3us_end   ;pokud eax < edx -> skok na konec
    mov eax, edx    ;ulozeni tretiho argumentu do eax
min3us_end:
    ret

; int kladne(int a, int b, int c)
kladne:
    cmp edi, 0  ;porovnani prniho argumentu s 0
    jle zaporne ;skok na vraceni nepravdy
    cmp esi, 0  ;porovnani druheho argumentu s 0
    jle zaporne ;skok na vraceni nepravdy
    cmp edx, 0  ;porovnani tretiho argumentu s 0
    jle zaporne ;skok na vraceni nepravdy
    mov eax, 1  ;ulozeni 1
    ret
zaporne:
    mov eax, 0  ;ulozeni 0
    ret

; int mocnina(int n, unsigned int m)
mocnina:
    mov eax, edi    ;ulozeni mocnence
    mov ecx, esi    ;ulozeni mocnitele
    cmp ecx, 0      ;porovnani mocnitele s 0
    jz mocnina_0    ;mocnitel je 0
    mov edx, eax    ;ulozime mocnence pro loop
m_loop:
    dec ecx         ;odecteme od mocnitele 1
    cmp ecx, 0      ;porovname mocnitele s 0
    jbe m_loop_end  ;pokud mocnitel <= 0 -> konec
    imul eax, edx   ;vynasobime hodnotu v eax hodnotou mocnence pred loop
    jmp m_loop      ;opakujeme loop
m_loop_end:
    ret
mocnina_0:
    cmp eax, 0      ;porovname mocnence s 0
    jg mocnina_ok   ;mocnenec > 0
    jl mocnina_ok   ;mocnenec < 0
    mov eax, -1     ;mocnenec = 0
    ret
mocnina_ok:
    mov eax, 1      ;cokoliv (mimo 0) na 0 je 1
    ret

section .note.GNU-stack noalloc noexec nowrite progbits