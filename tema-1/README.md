Prima functie folosita este cea de creare a unui element de tip data_structure. Asadar, functia createDataStructure primeste ca argumente un pointer la pozitia primului cuvant din sirul de caractere citit si un pointer la sirul propriu-zis.
- Functia aloca un element de tip data_structure. Daca alocarea nu reuseste, se sterge continutul sirului. Apoi, se aloca o structura de tip header. Se trece la urmatorul cuvant din sir, se introduce in structura tipul elementului, apoi se aloca spatiul necesar pentru primul nume. Se copiaza numele in zona void *data. Se trece mai departe in sirul de caractere. Se verifica tipul elementului:
- Daca este tipul 1, atunci se realoca spatiu pentru 2 elemente de tip int8_t si se copiaza numerele;
- Daca este tipul 2, atunci se realoca spatiu pentru 2 elemente de tip int16_t si int32_t respectiv si se copiaza numerele;
- Daca este tipul 3, atunci se realoca spatiu pentru 2 elemente de tip int32_t si se copiaza numerele;
- Apoi se realoca spatiu dimensiunea celui de-al doilea nume si se copiaza ultimul nume citit. La final se elibereaza memoria pentru string.
A doua functie este de adaugare element la final de vector: add_last. Daca nu exista vectorul, atunci se aloca un octet.
- Urmeaza un loop de tip for care trece prin vector si ajunge la final, unde trebuie introdus noul element. Realocam spatiu marimea initiala a vectorului + len + sizeof(head). Daca nu reuseste alocarea, se elibereaza memoria structurii de date.
- Se copiaza headerul, iar mai apoi cu functia memcpy se copiaza elementele propriu-zise din zona de date. Lungimea vectorului este incrementata, iar apoi dezalocam spatiul utilizat pentru structura de pasare a datelor.
Functia de adaugare element intr-o anumita zona din vector (add_at) verifica indexul pe care il primeste. Daca e mai mare decat lungimea vectorului, atunci elementul se adauga la final. Daca e mai mic ca 0, atunci elementul nu se adauga. Daca nu exisra vectorul, atunci se aloca spatiu pentru un octet.
- Se parcurg primele elemente pana la index cu un "for" si se gaseste dimensiunea vectorului pana acolo. Apoi se parcurg toate elementele de la index la final si se gaseste dimensiunea vectorului de la index la sfarsit. Apoi se calculeaza dimensiunea elementului adaugat, se realoca spatiu pentru vector.
- Se muta elementele de la dreapta indexului cu sizeOfAdded mai la dreapta, iar apoi in spatiul ramas se cpiaza noul element. Se incrementeaza lungimea, apoi dezalocam spatiul utilizat pentru structura de pasare a datelor.
Functia find nu returneaza nimic daca nu exista un element cu indexul specificat. Altfel, parcurge vectorul si ii afla dimensiunea pana la indexul specificat. Se afiseaza tipul elementului, iar mai apoi in functie de tip se afiseaza cele doua nume si:
- 2 elemente de tip int8_t (tip1);
- Un element de tip int16_t, unul de tip int32_t (tip2);
- 2 elemente de tip int32_t (tip3).
Functia delete_at sterge elementul de la pozitia index. Din nou, daca elementul nu exista, atunci returneaza 0. Altfel, parcurge vectorul si afla dimensiunea pana la index. Calculeaza dimensiunea elementului ce urmeaza a fi sters, dar si pos (pozitia urmatorului element).
- Parcurgem fiecare element de la index+1 in sus si mutam fiecare octet al sau la stanga cu sizeOfDeleted pozitii. Se realoca dimensiunea vectorului si decrementam *len.
Functia de printare parcurge vectorul si afiseaza in functie de tipul elementului cele 2 nume si:
- 2 elemente de tip int8_t (tip1);
- Un element de tip int16_t, unul de tip int32_t (tip2);
- 2 elemente de tip int32_t (tip3).
In functia main se citeste instructiunea cu fgets si se elimina '\n' de la finalul sirului de caractere. Apoi acesta se copiaza intr-un nou sir alocat dinamic, ce urmeaza a fi impartit in mai multe cuvinte prin strtok. In functie de primul cuvant, apelam functia corespunzatoare: "insert", "insert_at", "delete_at", "find", "print". Cuvantul "exit" dezaloca memoria si inchide programul.
