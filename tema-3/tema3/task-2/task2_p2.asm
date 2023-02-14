section .text
	global par

;; int par(int str_length, char* str)
;
; check for balanced brackets in an expression
par:
	;; in edi vom pastra adresa de return
	pop edi

	;; scoatem din stiva cei 2 parametrii ai functiei
	pop eax
	pop ebx

	;; ecx va fi counterul cu care ne vom plimba prin sirul de caractere
	xor ecx, ecx
	;; in edx vom pastra nr de paranteze deschise, dar nu inchise
	xor edx, edx

verifica:
	;; verificam daca la adresa actuala se regaseste o paranteza deschisa
	;; sau inchisa
	cmp byte [ebx+ecx], '('
	je deschisa
	cmp byte [ebx+ecx], ')'
	je inchisa
	
deschisa:
	;; daca este deschisa, atunci incrementam nr de paranteze deschise, dar
	;; nu inchise
	inc edx
	jmp urmatorul_element

inchisa:
	;; daca este inchisa, atunci incrementam nr de paranteze deschise, dar
	;; nu inchise
	dec edx

urmatorul_element:
	;; incrementam counterul
	inc ecx
	;; verificam daca lungimea sirului este mai mare decat counterul
	;; daca da, atunci verificam urmatoarea paranteza 
	cmp eax, ecx
	jg verifica

	;; verificam daca nr de paranteze inchise este egal cu cel al
	;; parantezelor deschise
	xor eax, eax
	cmp edx, 0
	jne nu_este_corect

este_corect:
	;; eax devine 1
	inc eax

nu_este_corect:
	;; eax ramane 0

	;; dam push adresei de return
	push edi

	ret
