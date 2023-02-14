%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY
   
    ;; Your code starts here

    xor eax, eax
verifyStep:
    ;; comparam step-ul cu 26
    cmp edx, 26
    jle eachLetter
    ;; daca e mai mare, scadem 26 din el pana devine mai mic ca 26
    ;; (26 litere mari sunt in alfabetul englez
    sub edx, 26
    jmp verifyStep

    ;; luam fiecare litera in parte pt a o modifica
eachLetter:
    dec ecx
    ;; copiem litera de pe pozitia ecx in registrul al
    mov al, byte [esi+ecx]
    ;; copiem litera in zona finala de memorie
    mov byte [edi+ecx], al
    ;; adaugam step-ul (care va fi mai mic decat 26 acum)
    ;; deci se va afla in dl  tot rezultatul
    add byte [edi+ecx], dl
    ;; verificam daca trebuie rotit caracterul sau nu
    cmp byte [edi+ecx], 'Z'
    jle thisLetterIsDone
    ;; rotim caracterul
    sub byte [edi+ecx], 26

thisLetterIsDone:
    ;; verificam daca mai avem litere in sir pt a le modifica
    cmp ecx, 0
    jnz eachLetter

    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
