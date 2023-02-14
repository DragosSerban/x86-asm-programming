%include "../include/io.mac"

section .text
    global beaufort
    extern printf

; void beaufort(int len_plain, char *plain, int len_key, char *key, char tabula_recta[26][26], char *enc) ;
beaufort:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; len_plain
    mov ebx, [ebp + 12] ; plain (address of first element in string)
    mov ecx, [ebp + 16] ; len_key
    mov edx, [ebp + 20] ; key (address of first element in matrix)
    mov edi, [ebp + 24] ; tabula_recta
    mov esi, [ebp + 28] ; enc
    ;; DO NOT MODIFY
    ;; TODO: Implement spiral encryption
    ;; FREESTYLE STARTS HERE

    mov ecx, -1
decode:
    inc ecx
    ;; daca actualul byte din sirul de caractere este ocupat de 0,
    ;; atunci incheiem procesul din bucla
    cmp byte [ebx + ecx], 0
    je finish

    ;; eliberam spatiu in edx pentru impartirea cu impartitor pe 4 octeti
    xor edx, edx
    mov eax, ecx
    div dword [ebp + 16]
    ;; impartirea de mai sus calculeaza pozitia din key corespunzatoare
    ;; pozitiei literei din string

    ;; punem restul impartirii in registrul edi
    mov edi, edx
    mov edx, [ebp + 20]

    ;; copiem in al byte-ul de pe pozitia ecx din sirul de caractere
    mov al, byte [ebx + ecx]
    ;; copiem in ah byte-ul de pe pozitia edi din key
    mov ah, byte [edx + edi]
    ;; le comparam pentru a modifica elementele din sir corespunzator
    cmp al, ah
    jle smaller

    ;; cazul 1: caracterul din sir e mai mare decat cel din key
    ;; facem operatiile corespunzatoare pt a modifica caracterul
    ;; si in salvam la final la adresa din memorie corespunzatoare
    sub al, ah
    mov ah, 'Z'
    sub ah, al
    inc ah
    mov byte [esi + ecx], ah
    jmp decode

smaller:
    ;; cazul 2: caracterul din sir e mai mic decat cel din key
    ;; facem operatiile corespunzatoare pt a modifica caracterul
    ;; si in salvam la final la adresa din memorie corespunzatoare
    sub ah, al
    mov al, 'A'
    add al, ah
    mov byte [esi + ecx], al
    jmp decode

finish:
    ;; adaugam la final de sir caracterul 0
    mov byte [esi + ecx + 1], 0

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
