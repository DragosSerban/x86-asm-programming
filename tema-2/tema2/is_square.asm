%include "../include/io.mac"

section .text
    global is_square
    extern printf

is_square:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov ebx, [ebp + 8]      ; dist
    mov eax, [ebp + 12]     ; nr
    mov ecx, [ebp + 16]     ; sq
    ;; DO NOT MODIFY
   
    ;; Your code starts here

    ;; nextElement reprezinta punctul de lucru pt a determina daca elementul
    ;; urmator din vector este patratul unui alt numar
nextElement:
    dec eax
    mov esi, -1
    ;; vom calcula patratele tuturor numerelor naturale incepand de la 0
    ;; pana cand ajungem la valoarea numarului dat sau o depasim
stillSearching:
    inc esi
    ;; vom realiza inmultirea pt care sunt rezervate eax si edx, deci salvam
    ;; continutul lui eax pe stiva
    push eax
    mov eax, esi
    mul eax
    mov edi, eax
    pop eax

    ;; daca patratul actual este mai mic decat numarul, continua cautarea
    cmp edi, dword [ebx+4*eax]
    jb stillSearching
    cmp edi, dword [ebx+4*eax]
    je isSquare

    ;; daca nu este patrat, atunci pune 0 la pozitia respectiva in vector
    mov dword [ecx+4*eax], 0
    jmp checkForElements

isSquare:
    ;; daca este patrat, atunci pune 1 la pozitia respectiva in vector
    mov dword [ecx+4*eax], 1

    ;; checkForElements verifica daca mai exista elemente in vector
checkForElements:
    cmp eax, 0
    jnz nextElement

    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
