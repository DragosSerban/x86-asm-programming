%include "../include/io.mac"

struc point
    .x: resw 1
    .y: resw 1
endstruc

section .text
    global points_distance
    extern printf

points_distance:
    ;; DO NOT MODIFY
    
    push ebp
    mov ebp, esp
    pusha

    mov ebx, [ebp + 8]      ; points
    mov eax, [ebp + 12]     ; distance
    ;; DO NOT MODIFY
   
    ;; Your code starts here

    xor ecx, ecx
    ;; punem coordonata x a celui de-al doilea punct in cx
    mov cx, word [ebx+4]
    ;; comparam cu coordonata primului punct
    cmp cx, word [ebx]
    jne paralelCuAxaOX

    ;; x1 = x2 => dreapta e paralela cu OY
    mov cx, word [ebx+6]
    sub cx, word [ebx+2]
    ;; plasam distanta in [eax]
    mov dword [eax], ecx
    jmp finish

    ;; in caz ca x1 diferit de x2 => Y1 = Y2 => dreapta e paralela cu OX
paralelCuAxaOX:
    sub cx, word [ebx]
    ;; plasam distanta in [eax]
    mov dword [eax], ecx

finish:

    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret

    ;; DO NOT MODIFY
