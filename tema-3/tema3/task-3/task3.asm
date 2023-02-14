global get_words
global compare_func
global sort

section .data
	sep db " ,.", 10, 0

section .text
	extern strtok
	extern strlen
	extern strcmp
	extern qsort

compare:
    enter 0,0

    ;; copiem al doilea parametru al functiei de comparare
    mov edx, [ebp+12]
    ;; aflam lungimea cuvantului
    push dword [edx]
    call strlen
    add esp, 4
    ;; copiem in stiva rezultatul
    push eax

    ;; copiem primul parametru al functiei de comparare
    mov ecx, [ebp+8]
    ;; aflam lungimea cuvantului
    push dword [ecx]
    call strlen
    add esp, 4

    ;; comparam cele 2 lungimi
    pop ecx
    sub eax, ecx

    ;; daca nu sunt egale, atunci incheiem functia
    cmp eax, 0
    jne este_sortat

    ;; copiem cele 2 adrese ale cuvintelor si apelam strcmp
    ;; pt a stabili ordinea cuvintelor
    mov edx, [ebp+12]
    push dword [edx]
    mov ecx, [ebp+8]
    push dword [ecx]
    call strcmp
    add esp, 8

este_sortat:
    leave
    ret

;; sort(char **words, int number_of_words, int size)
;  functia va trebui sa apeleze qsort pentru soratrea cuvintelor 
;  dupa lungime si apoi lexicografix
sort:
    enter 0, 0
    push ebx
    push edi
    push esi

    ;; qsort(words, number_of_words, sizeof(char*), compare);
    ;; dam push la parametrii functiei qsort
    push compare
    push 4
    push dword [ebp+12]
    push dword [ebp+8]
    call qsort
    add esp, 16

    pop esi
    pop edi
    pop ebx

    leave
    ret

;; get_words(char *s, char **words, int number_of_words)
;  separa stringul s in cuvinte si salveaza cuvintele in words
;  number_of_words reprezinta numarul de cuvinte
get_words:
    enter 0, 0
    push ebx
    push edi
    push esi

    ;; salvam in registre parametrii functiei
    mov eax, [ebp+8] ;; stringul
    mov ebx, [ebp+12] ;; vectorul de cuvinte

    ;; folosim functia strtok pt a impartii in cuvinte
    push sep
    push eax
    call strtok
    add esp, 8

    ;; mutam in primul element al vectorului un pointer catre primul cuvant
    mov dword [ebx], eax
    mov edx, 1 ;; nr curent de cuvinte cu adresa in vector

    ;; folosim un while loop (cat timp exista cuvinte netransferate in vector)
while:
    push edx ;; salvam edx inainte de apelarea strtok
    ;; p = strtok(NULL, sep); (aici p este inlocuit de eax)
    push sep
    push 0
    call strtok
    add esp, 8

    pop edx
    ;; copiem adresa cuvantului rezultat in vectorul de pointeri
    mov dword [ebx+4*edx], eax
    inc edx
    ;; verificam daca mai exista cuvinte cu adresa necopiata in vector
    mov ecx, [ebp+16]
    cmp edx, ecx
    jl while

    pop esi
    pop edi
    pop ebx

    leave
    ret
