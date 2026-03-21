section .text

global sgn
global max2c
global min3us
global kladne
global mocnina

sgn:
    cmp edi, 0      ;porovnáme prvni argument s 0
    jnz sgn_zero    ;skok na vraceni 0
    jg sgn_plus     ;skok na vraceni 1
sgn_minus:
    mov eax, -1     ;ulozeni -1
    ret
sgn_zero:
    mov eax, 0      ;ulozeni 0
    ret
sgn_plus:
    mov eax, 1      ;ulozeni 1
    ret

max2c:
    mov al, dil         ;ulozime prvni argument (char) do al
    cmp al, sil         ;porovname s druhym argumentem
    ja max2c_second_arg ;skok na vraceni druheho argumentu
    ret
max2c_second_arg:
    mov al, sil         ;ulozeni druheho argumentu
    ret

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

mocnina:
    mov eax, edi    ;ulozeni mocnence
    mov ecx, esi    ;ulozeni mocnitele
    cmp ecx, 0      ;porovnani mocnitele s 0
    jge mocnina_0   ;mocnitel je 0
    mov edx, eax    ;ulozime mocnence pro loop
m_loop:
    dec ecx         ;odecteme od mocnitele 1
    cmp ecx, 0      ;porovname mocnitele s 0
    jbe m_loop_end  ;pokud mocnitel = 0 -> konec
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