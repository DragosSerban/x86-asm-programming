/* Serban Dragos-Andrei - 312 CB */

1. simple.asm
- comparam step-ul salvat in edx cu 26 (nr de caractere din
alfabetul englez
- daca step-ul e mai mic de 26, atunci sarim la eticheta eachLetter
- altfel decrementam constant edx constant pana cand rezultatul din
registru devine mai mic decat 26
- in eachLetter copiem litera de pe pozitia ecx in registrul al
- copiem litera in zona finala de memorie
- adaugam in acea zona finala step-ul actualizat (care este mai mic
decat 26, asa ca are loc in subregistrul dl
- verificam daca caracterul rezultat trebuie rotit sau nu
- daca caracterul este mai mare decat 'Z', atunci rotim caracterul
(sub byte [edi + ecx], 26)
- altfel verificam daca mai exista litere de trecut prin procesul
de mai sus

2. a. points-distance.asm
- verificam mai intai coordonatele x ale celor 2 puncte
- punem coordonata x a celui de-al doilea punct in cx
- o comparam cu coordonata x a primului punct
- daca nu sunt egale, inseamna ca y1 = y2, deci dreapta e paralela
cu OX
- daca sunt egale, inseamna ca x1 = x2, deci dreapta e paralela
cu OY
- cazul 1: paralela cu OY:
.plasam una dintre coordonatele y ale punctului intr-un registru,
.scadem cealalta coordonata si mutam rezulytatul in dword [eax]
- cazul 2: paralela cu OX:
.plasam una dintre coordonatele x ale punctului intr-un registru,
.scadem cealalta coordonata si mutam rezulytatul in dword [eax]

2. b. road.asm
- punem in ecx lungimea vectorului, decrementam
- vom porni de la finalul vectorului si vom prelua cate 2 puncte
si vom afla distanta dintre ele, incepem cu ultimul si penultimul,
penultimul si antepenultimul ...
- vom compara coordonatele x ale celor 2 puncte
- cazul 1: x1 = x2 (dreapta este paralela cu OY):
.comparam cele 2 coordonate y
.daca a doua este mai mica, facem scaderea si introducem distanta in
vectorul final de distante
.daca a doua coordonata este mai mare, facem scaderea invers si
introducem distanta in vectorul final de distante
- cazul 2: y1 = y2 (dreapta este paralela cu axa OX):
.comparam cele 2 coordonate x
.daca a doua este mai mica, facem scaderea si introducem distanta in
vectorul final de distante
.daca a doua coordonata este mai mare, facem scaderea invers si
introducem distanta in vectorul final de distante
- la final trecem la urmatoarea iteratie pana calculam toate
distantele

2. c. is_square.asm
- eticheta nextElement reprezinta punctul de lucru pt a determina
daca elementul urmator din vector este patratul unui alt numar
- pentru fiecare element din vector vom calcula patratele tuturor
numerelor naturale incepand de la 0 pana cand ajungem la valoarea
numarului dat sau o depasim
- atunci cand realizam inmultirea, salvam continutul lui eax pe
stiva (vom mai avea nevoie de el) - inmultirea lucreaza cu eax si edx
- calculam patrate pana cand ajungem la un patrat mai mare sau egal
cu elementul nostru
- daca este egal => patrat => punem 1 in vectorul final
- daca este mai mare => nu este patrat => punem 0 in vectorul final
- continuam iteratia pentru fiecare element din vectorul de distante

3. beaufort.asm
- parcurgem stringul, ne oprim cand dam de terminatorul de sir 0
- in ecx pastram pozitia actuala din string
- pentru a calcula pozitia din key corespunzatoare pozitiei din
string, vom face o impartire cu impartitor pe 4 octeti si vom
utiliza mai apoi registrul edx (restul)
- mutam restul impartirii in edi (edx il vom pastra pentru key
- facem schimbarea propriu-zisa:
.copiem in al byte-ulde pe pozitia actuala din string
.copiem in ah byte-ul de pe pozitia edi din key
.iar apoi le comparam, procedura fiind diferita in functie de
ce element este mai mare
- cazul 1: caracterul din sir e mai mare decat cel din key, facem
operatiile corespunzatoare pt a modifica caracterul si in salvam
la final la adresa din memorie corespunzatoare:
scadem din al pe ah, punem in ah 'Z', scadem din ah pe al,
incrementam ah
- cazul 2: caracterul din sir e mai mic decat cel din key, facem
operatiile corespunzatoare pt a modifica caracterul si in salvam
la final la adresa din memorie corespunzatoare:
scadem din ah pe al, punem in al pe 'A', adunam al si ah
- dupa ce parcurgem tot stringul, adaugam la final terminatorul
de sir

4. spiral.asm
- ne vom folosi de 5 variabile globale:
minLine (linia minima prin care vom mai trece in matrice)
minColumn (coloana minima prin care vom mai trece in matrice)
maxLine (linia maxima prin care vom mai trece in matrice)
maxColumn (coloana maxima prin care vom mai trece in matrice)
current (in care pastram pozitia elementului curent din string)
- vom folosi o bucla pentru a parcurge matricea in spirala in felul
urmator: mai intai prima linie, apoi ultima coloana, apoi ultima
linie, apoi prima coloana, apoi a doua linie, apoi penultima
coloana si tot asa
- vom folosi primele 4 variabile globale pentru a creea submatrici
pentru a parcurge mai usor fiecare element
- vom explica mai jos pentru prima iteratie din bucla:
- pt prima linie:
.vom parcurge doar elementele neparcurse inca, de aceea vom trece
peste toate liniile parcurse anterior
.calculam pozitia actuala prin inmultirea dintre numarul de linii
parcurse la inceput si N (eax), iar mai apoi adunam numarul de
coloane parcurse in stanga matricei
.adunam codul ASCII al elementului curent din string cu rezultatul
de la pozitia de mai sus si introducem noul element in vectorul final
- pt ultima coloana:
.calculam pozitia actuala prin inmultirea dintre numarul de linii
parcurse la inceput si N (eax), iar mai apoi adunam maxColumn-1
.adunam codul ASCII al elementului curent din string cu rezultatul
de la pozitia de mai sus si introducem noul element in vectorul final
- pt ultimul rand:
.calculam pozitia actuala prin inmultirea dintre indexul liniei
finale neparcurse si N (eax), iar mai apoi adunam maxColumn-1
.adunam codul ASCII al elementului curent din string cu rezultatul
de la pozitia de mai sus si introducem noul element in vectorul final
- pt prima coloana:
.calculam pozitia actuala prin inmultirea dintre indexul liniei
finale neparcurse si N (eax), iar mai apoi adunam indexul coloanei
cea mai din stanga parcurse
.adunam codul ASCII al elementului curent din string cu rezultatul
de la pozitia de mai sus si introducem noul element in vectorul final
- continua iteratia pana cand nu mai raman elemente in matrice
