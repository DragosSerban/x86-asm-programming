%include "../include/io.mac"

section .data
	minLine dd 0
	minColumn dd 0
	maxLine dd 0
	maxColumn dd 0
	current dd 0

section .text
    global spiral
    extern printf

; void spiral(int N, char *plain, int key[N][N], char *enc_string);
spiral:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; N (size of key line)
    mov ebx, [ebp + 12] ; plain (address of first element in string)
    mov ecx, [ebp + 16] ; key (address of first element in matrix)
    mov edx, [ebp + 20] ; enc_string (address of first element in string)
    ;; DO NOT MODIFY
    ;; TODO: Implement spiral encryption
    ;; FREESTYLE STARTS HERE

    ;; setam valoarea variabilelor globale
    ;; linia minima prin care vom mai trece
    mov dword [minLine], 0
    ;; coloana minima prin care vom mai trece
    mov dword [minColumn], 0
    ;; linia maxima prin care vom mai trece
    mov dword [maxLine], eax
    ;; coloana maxima prin care vom mai trece
    mov dword [maxColumn], eax
    ;; current este o variabila in care se va salva pozitia elementului curent
    ;; din string
    mov dword [current], 0

stillHaveElements:

    ;; parcurgem matricea in forma spirala incepand cu prima linie
    mov edi, dword [minColumn]

firstLine:
    ;; vom parcurge doar elementele neparcurse inca
    ;; de aceea vom trece peste toate liniile parcurse anterior
    ;; calculam pozitia actuala prin inmultirea dintre numarul de linii
    ;; parcurse la inceput si N (eax), iar mai apoi adunam numarul de
    ;; coloane parcurse in stanga matricei
    mov esi, dword [minLine]
    mul esi
    add eax, edi

    push edi
    ;; mutam in esi pozitia elementului curent din string
    mov esi, dword [current]
    
    ;; mutam in edi elementul curent din matrice
    mov edi, dword [ecx + 4*eax]

    xor eax, eax
    ;; in al vom stoca elementul curent din string
    mov al, byte [ebx + esi]

    mov edx, [ebp + 20]
    ;; mutam caracterul intr-un registru si il actualizam prin adunare
    mov byte [edx + esi], al
    add dword [edx + esi], edi

    ;; incrementam pozitia elementului curent (trecem la urmatorul element)
    inc dword [current]
    mov eax, [ebp + 8]
    pop edi

    ;; incrementam edi si trecem la urmatorul element de pe linie daca exista
    inc edi
    cmp edi, dword [maxColumn]
    jl firstLine

    ;; actualizam linia minima prin care vom mai trece
    inc dword [minLine]

    ;; pe liniile urmatoare ne oprim din cautarea elementelor
    ;; daca minLine == maxLine (pentru cazul matrice patratica
    ;;cu numar impar de linii si coloane
    mov edi, dword [minLine]
    cmp edi, dword [maxLine]
    je stop

    ;; trecem la elementele de pe ultima coloana netraversata pana acum
    mov edi, dword [minLine]

lastColumn:
    ;; calculam pozitia actuala prin inmultirea dintre numarul de linii
    ;; parcurse la inceput si N (eax), iar mai apoi adunam
    ;; dword [maxColumn] si scadem 1
    mul edi
    add eax, dword [maxColumn]
    dec eax

    push edi
    ;; mutam in esi pozitia elementului curent din string
    mov esi, dword [current]

    ;; mutam in edi elementul curent din matrice
    mov edi, dword [ecx + 4*eax]

    xor eax, eax
    ;; in al vom stoca elementul curent din string
    mov al, byte [ebx + esi]

    mov edx, [ebp + 20]
    ;; mutam caracterul intr-un registru si il actualizam prin adunare
    mov byte [edx + esi], al
    add dword [edx + esi], edi

    ;; incrementam pozitia elementului curent (trecem la urmatorul element)
    inc dword [current]
    mov eax, [ebp + 8]
    pop edi

    ;; incrementam edi  si trecem la urmatorul element de pe coloana,
    ;; daca exista
    inc edi
    cmp edi, dword [maxLine]
    jl lastColumn

    ;; actualizam coloana maxima prin care vom mai trece
    dec dword [maxColumn]

    ;; parcurgem ultima linie neparcursa
    mov edi, dword [maxColumn]
    dec edi

lastRow:
    ;; calculam pozitia actuala prin inmultirea dintre indexul liniei finale
    ;; neparcurse si N (eax), iar mai apoi adunam edi
    mov esi, dword [maxLine]
    dec esi
    mul esi
    add eax, edi

    push edi
    ;; mutam in esi pozitia elementului curent din string
    mov esi, dword [current]

    ;; mutam in edi elementul curent din matrice
    mov edi, dword [ecx + 4*eax]

    xor eax, eax
    ;; in al vom stoca elementul curent din string
    mov al, byte [ebx + esi]

    mov edx, [ebp + 20]
    ;; mutam caracterul intr-un registru si il actualizam prin adunare
    mov byte [edx + esi], al
    add dword [edx + esi], edi

    ;; incrementam pozitia elementului curent (trecem la urmatorul element)
    inc dword [current]
    mov eax, [ebp + 8]
    pop edi

    ;; decrementam edi si trecem la elementul anterior de pe linie,
    ;; daca exista
    dec edi
    cmp edi, dword [minColumn]
    jge lastRow

    ;; actualizam linia maxima prin care vom mai trece
    dec dword [maxLine]

    ;; daca dword [minLine] si dword [maxLine] sunt identice, atunci
    ;; oprim programul
    mov edi, dword [minLine]
    cmp edi, dword [maxLine]
    je stop

    ;; parcurgem prima coloana neparcursa
    mov edi, dword [maxLine]
    dec edi

firstColumn:
    ;; calculam pozitia actuala prin inmultirea dintre indexul liniei finale
    ;; neparcurse si N (eax), iar mai apoi adunam dword [minColumn]
    mul edi
    add eax, dword [minColumn]

    push edi
    ;; mutam in esi pozitia elementului curent din string
    mov esi, dword [current]

    ;; mutam in edi elementul curent din matrice
    mov edi, dword [ecx + 4*eax]

    xor eax, eax
    ;; in al vom stoca elementul curent din string
    mov al, byte [ebx + esi]

    mov edx, [ebp + 20]
    ;; mutam caracterul intr-un registru si il actualizam prin adunare
    mov byte [edx + esi], al
    add dword [edx + esi], edi

    ;; incrementam pozitia elementului curent (trecem la urmatorul element)
    inc dword [current]
    mov eax, [ebp + 8]
    pop edi

    ;; decrementam edi si trecem la elementul anterior de pe coloana,
    ;; daca exista
    dec edi
    cmp edi, dword [minLine]
    jge firstColumn

    ;; actualizam coloana minima prin care vom mai trece
    inc dword [minColumn]

    jmp stillHaveElements

stop:
    ;; se incheie programul

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
