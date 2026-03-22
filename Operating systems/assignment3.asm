section .text

global obsah_obdelnika
global obvod_ctverce
global obsah_ctverce
global obvod_trojuhelnika
global obvod_trojuhelnika2  ;rovnostrany trojuhelnik
global obsah_trojuhelnika
global objem_krychle
global avg

obsah_obdelnika:
    mov eax, edi    ;ulozime prvni argument do eax
    imul eax, esi   ;vynasobime hodnotu v eax, hodnotou druheho argumentu
    ret

obvod_ctverce:
    mov eax, edi    ;ulozime prvni argument do eax
    imul eax, 4     ;vynasobime 4x
    ret

obsah_ctverce:
    mov eax, edi    ;ulozime prvni argument do eax
    imul eax, edi   ;vynasobime hodnotu v eax hodnotou prvniho argumentu
    ret

obvod_trojuhelnika:
    mov eax, edi    ;ulozime prvni argument do eax
    add eax, esi    ;k hodnote v eax pricteme druhy argument
    add eax, edx    ;k hodnote v eax pricteme treti argument
    ret

obvod_trojuhelnika2:
    mov eax, edi    ;ulozime prvni argument do eax
    imul eax, 3     ;vynasobime hodnotu v eax 3x
    ret

obsah_trojuhelnika:
    mov eax, edi    ;ulozime prvni argument do eax
    imul eax, esi   ;vynasobime hodnotu v eax hodnotou druheho argumentu
    mov ecx, 2      ;do ecx uloz 2
    xor edx, edx
    div ecx         ;vydelime 2
    ret

objem_krychle:
    mov eax, edi    ;ulozime prvni argument do eax
    imul eax, edi   ;na druhou
    imul eax, edi   ;na treti
    ret

avg:
    mov eax, edi    ;ulozime prvni argument do eax
    add eax, esi    ;pricteme druhy argument
    add eax, edx    ;pricteme treti argument
    xor edx, edx
    mov ecx, 3      ;do ecx ulozime 3
    div ecx         ;hodnotu v eax vydelime 3
    ret

section .note.GNU-stack noalloc noexec nowrite progbits