section .text
	global sort

; struct node {
;     	int val;
;    	struct node* next;
; };

;; struct node* sort(int n, struct node* node);
; 	The function will link the nodes in the array
;	in ascending order and will return the address
;	of the new found head of the list
; @params:
;	n -> the number of nodes in the array
;	node -> a pointer to the beginning in the array
; @returns:
;	the address of the head of the sorted list
sort:
	enter 0, 0
	;; salvam continutul registrelor ebx, edi, esi
	push ebx
	push edi
	push esi

	mov edi, [ebp+8] ;; numarul de elemente din lista
	mov esi, [ebp+12] ;; pointer catre vectorul de elemente

	;; mutam in eax pointerul NULL
	mov eax, 0
	;; mutam in ebx nr de elemente
	;; ebx este elementul curent cautat in vector
	mov ebx, edi

	;; vom folosi 2 for-uri pt a face ordonarea
ordoneaza_elementele:
	;; ecx repr pozitia curenta in vector unde cautam elementul
	mov ecx, edi
cauta_element:
	dec ecx
	;; comparam elementul din vector cu nr cautat
	cmp dword [esi+8*ecx], ebx
	jne cauta_element

	;; mutam in zona de pointer a celulei din lista corespunzatoare
	;; elementului gasit adresa din eax
	mov dword [esi+8*ecx+4], eax
	;; actualizam adresa din eax cu adresa elementului curent
	lea eax, [esi+8*ecx]

	;; trecem la cautarea urmatorului element mai mic decat cel actual
	dec ebx
	cmp ebx, 0
	jne ordoneaza_elementele

	pop esi
	pop edi
	pop ebx

	leave
	ret
