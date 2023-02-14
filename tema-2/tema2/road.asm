%include "../include/io.mac"

struc point
    .x: resw 1
    .y: resw 1
endstruc

section .text
    global road
    extern printf

road:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]      ; points
    mov ecx, [ebp + 12]     ; len
    mov ebx, [ebp + 16]     ; distances
    ;; DO NOT MODIFY
   
    ;; Your code starts here

    dec ecx
nextDistance:
    xor edx, edx
    dec ecx
    ;; pornim de la finalul array-ului, vom lua cate doua puncte pt a le
    ;; afla distanta, incepem cu ultimul si penultimul
    mov dx, word [eax+4*ecx+4]
    ;; comparam coordonatele X1 si X2
    cmp dx, word [eax+4*ecx]
    jne paralelCuAxaOX

    ;; cazul x1 = x2 (dreapta paralela cu OY)
    mov dx, word [eax+4*ecx+6]
    cmp dx, word [eax+4*ecx+2]
    ja secondPointIsAboveCase1

    ;; in cazul in care al doilea punct este mai mic
    mov dx, word [eax+4*ecx+2]
    sub dx, word [eax+4*ecx+6]
    ;; introducem distanta in vectorul final de distante
    mov dword [ebx+4*ecx], edx
    jmp checkForPoints

    ;; in cazul in care al doilea punct este mai mare
secondPointIsAboveCase1:
    mov dx, word [eax+4*ecx+6]
    sub dx, word [eax+4*ecx+2]
    ;; introducem distanta in vectorul final de distante
    mov dword [ebx+4*ecx], edx
    jmp checkForPoints

    ;; daca x1 diferit de x2 => y1 = y2 => dreapta paralela cu axa 0X
paralelCuAxaOX:
    ;; in dx ramane stocat word [eax+4*ecx+4]
    cmp dx, word [eax+4*ecx]
    ja secondPointIsAboveCase2

    ;; in cazul in care al doilea punct este mai mic
    mov dx, word [eax+4*ecx]
    sub dx, word [eax+4*ecx+4]
    ;; introducem distanta in vectorul final de distante
    mov dword [ebx+4*ecx], edx
    jmp checkForPoints

    ;; in cazul in care al doilea punct este mai mare
secondPointIsAboveCase2:
    mov dx, word [eax+4*ecx+4]
    sub dx, word [eax+4*ecx]
    ;; introducem distanta in vectorul final de distante
    mov dword [ebx+4*ecx], edx

    ;; verificam daca mai exista puncte intre care nu am calculat distanta
checkForPoints:
    cmp ecx, 0
    jne nextDistance

    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
