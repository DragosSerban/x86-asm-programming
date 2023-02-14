Task1:
- la inceput mutam in registre parametrii functiei (nr de elem din lista +
pointerul spre vectorul de elemente)
- cum vom incepe cu cel mai mare element din vector, trebuie sa ii adaugam
pointerul NULL in celula (acesta reprezinta ultimul element din lista), de
aceea vom avea 0 in eax la inceput
- mutam in ebx nr de elemente din vector; ebx este elementul curent cautat
in vector
- vom folosi 2 bucle for pt a face ordonarea elementelor in lista in felul
urmator: vom cauta fiecare element in vector (incepand cu cel mai mare);
daca il gasim ii salvam adresa intr-un registru si actualizam pointerul din
celula corespunzatoare cu adresa salvata la iteratia anterioara in registru
- vom folosi ecx drept contor; vom scadea din el pana cand gasim pozitia
elementului cautat
- trecem la cautarea urmatorului element mai mic decat actualul

Task2:
a.
- la metoda cmmmc vom folosi urmatorul algoritm: vom calcula cmmdc-ul dintre
cele 2 numere, iar mai apoi vom inmulti cele doua numere, iar rezultatul este
raportul dintre inmultire si cmmdc
- la inceput vom da push pe stiva de 2 ori la cele 2 numere date ca parametrii
la functie (odata pentru a le inmulti si odata pentru a le calcula cmmdc-ul)
- algoritmul de cmmdc consta in impartirea primului nr la al doilea, iar apoi
vom compara restul impartirii cu 0, daca este 0, atunci cmmdc-ul a fost gasit;
el este valoarea impartitorului. Daca restul nu este 0, atunci valoarea
primului nr devine egala cu impartitorul, iar cel de-al doilea nr devine egal
cu restul si reluam algoritmul de mai sus pana avem un rest egal cu 0
- apoi vom prelua din stiva parametrii salvati la inceput si le vom calcula
inmulirea, iar apoi impartim la cmmdc (aflat in registrul ebx). Rezultatul
final se afla in eax. Punem la loc in stiva adresa de return a functiei
b.
- copiem adresa de return in registrul edi, punem cei 2 parametrii ai functiei
in eax si respectiv ebx
- folosim 2 countere: unul pt nr de paranteze neinchise (edx) si unul cu care
ne vom plimba prin sirul de caractere (ecx); il vom parcurge de la 0
- ebx+ecx va reprezenta adresa la care verificam caracterul. Daca este paranteza
deschisa, atunci sarim la eticheta deschisa, altfel sarim la eticheta inchisa
- eticheta deschisa: incrementam edx si sarim la eticheta urmatorul_element
- eticheta inchisa: incrementam edx si ajungem la eticheta urmatorul_element
- eticheta urmatorul_element: incrementam ecx, pt a trece la urmatoarea adresa
- verificam daca lungimea sirului este mai mare decat ecx-ul actual. Daca da,
atunci repetam algoritmul de mai sus
- dupa ce parcurgem tot sirul, verificam daca nr de paranteze inchise este egal
cu cel al parantezelor deschise
- daca este egal, atunci secventa este corecta, deci in eax vom avea 1 (returnam
1)
- daca nu este egal, atunci secventa nu este corecta, deci in eax vom avea 0
(returnam 0)
- dam push adresei de return

Task3:
get_words:
- salvam in registre primii 2 parametrii ai functiei
- avem o variabila globala, un string sep, pe care il vom folosi la strtok ca
string de separatori
- dam push in stiva la sep si la string, iar apoi apelam functia strtok
- mutam in primul element al vectorului un pointer catre primul cuvant
- in edx vom avea nr curent de cuvinte cu adresa in vector
- folosim un while loop (cat timp exista cuvinte netransferate in vector)
- dam push la sep si NULL, iar apoi apelam strtok, iar cu ajutorul counterului
edx copiem adresa cuvantului rezultat in vectorul de pointeri
- verificam daca mai exista cuvinte cu adresa necopiata in vector si daca da,
reluam procedeul anterior
sort:
- in C functia arata asa: qsort(words, number_of_words, sizeof(char*), compare);
asa ca dam push la toti parametrii functiei qsort si mai jos vom descrie
functionalitatea functiei compare
- functia compare:
- mai intai copiem al doilea parametru al functiei de comparare si aflam
lungimea cuvantului prin apelarea functiei strlen; copiem in stiva rezultatul
pt a nu fi afectat de al doilea apel al functiei strlen, descris mai jos
- copiem primul parametru al functiei de comparare; aflam lungimea cuvantului
prin strlen
- comparam lungimile obtinute ale celor 2 cuvinte; daca nu sunt egale, atunci
incheiem functia si transmitem prin eax rezultatul scaderii dintre lungimea
primului cuvant si a celui de-al doilea
- altfel copiem cele 2 adrese ale cuvintelor si apelam strcmp pt a stabili daca
primul este mai mic lexicografic sau nu decat al doilea; returnam rezultatul
functiei strcmp
