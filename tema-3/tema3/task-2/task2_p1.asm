section .text
	global cmmmc

;; int cmmmc(int a, int b)
;
;; calculate least common multiple fow 2 numbers, a and b
cmmmc:
	;; in ecx se va afla adresa de return
	pop ecx

	;; scoatem din stiva cei 2 parametrii ai functiei
	pop eax
	pop ebx

	;; le dam push in stiva odata pt a ii avea copiati
	push ebx
	push eax
	;; le mai dam push inca odata pt a ii utiliza la algoritmul de cmmdc
	push ebx
	push eax

cmmdc:
	xor edx, edx
	pop eax
	pop ebx

	;; impartim primul nr la al doilea (eax/ebx)
	div ebx
	;; comparam restul cu 0 (daca este 0, am gasit cmmdc-ul -
	;; valoarea lui se va afla in ebx)
	cmp edx, 0
	je gasire_cmmmc

	;; al doilea nr devine restul, iar primul va fi egal cu valoarea
	;; precedenta a celui de-al doilea
	push edx
	push ebx
	jmp cmmdc

gasire_cmmmc:
	;; vom prelua din stiva cei doi parametrii salvati la inceput
	;; (valorile initiale ale lui a si b)
	pop eax
	pop edx
	;; le inmultim iar mai apoi impartim rezultatul la cmmdc-ul gasit
	;; (rezultatul final din eax va fi cmmmc-ul)
	mul edx
	div ebx

	;; dam push adresei de return
	push ecx

	ret
