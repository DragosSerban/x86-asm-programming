#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "structs.h"
#include <inttypes.h>

#define MAX 256

// Functie pentru crearea unui element de tip data_structure
data_structure *createDataStructure(char *p) {
    data_structure *data = malloc(sizeof(data_structure));
    if(!data)
        return NULL;
    data->header = (head*)malloc(sizeof(head));
    if(!data->header) {
        free(data);
        return NULL;
    }
    p = strtok(NULL, " ");
    int type = atoi(p);
    int len = 0;
    data->header->type = type;
    p = strtok(NULL, " ");
    
    // Introducem primul nume in structura
    len += strlen(p)+1;
    data->data = malloc(len*sizeof(char));
    if(!data->data) {
        free(data->header);
        free(data);
        return NULL;
    }
    strcpy(data->data, p);
    p = strtok(NULL, " ");
    
    // Verificam tipul si in functie de tipul lor
    // introducem elementele de tip int8_t; int16_t; int32_t
    // in structura
    if(type == 1) {
        len += 2*sizeof(int8_t);
        data->data = realloc(data->data, len*sizeof(char));
        if(!data->data) {
            free(data->header);
            free(data);
            return NULL;
        }
        *(int8_t*)(data->data+len-2*sizeof(int8_t)) = atoi(p);
        p = strtok(NULL, " ");
        *(int8_t*)(data->data+len-sizeof(int8_t)) = atoi(p);
    } else if(type == 2) {
        len += sizeof(int16_t) + sizeof(int32_t);
        data->data = realloc(data->data, len*sizeof(char));
        if(!data->data) {
            free(data->header);
            free(data);
            return NULL;
        }
        *(int16_t*)(data->data+len-sizeof(int32_t)-sizeof(int16_t)) = atoi(p);
        p = strtok(NULL, " ");
        *(int32_t*)(data->data+len-sizeof(int32_t)) = atoi(p);
    } else if(type == 3) {
        len += 2*sizeof(int32_t);
        data->data = realloc(data->data, len*sizeof(char));
        if(!data->data) {
            free(data->header);
            free(data);
            return NULL;
        }
        *(int32_t*)(data->data+len-2*sizeof(int32_t)) = atoi(p);
        p = strtok(NULL, " ");
        *(int32_t*)(data->data+len-sizeof(int32_t)) = atoi(p);
    }
    p = strtok(NULL, " ");
    
    // Introducem al doilea nume in structura
    len += strlen(p)+1;
    data->data = realloc(data->data, len*sizeof(char));
    if(!data->data) {
        free(data->header);
        free(data);
        return NULL;
    }
    strcpy(data->data+len-strlen(p)-1, p);
    data->header->len = len;

    return data;
}

int add_last(void **arr, int *len, data_structure *data) {
    if(!*arr)
        *arr = malloc(1);
    if(!arr) {
        free(data->data);
        free(data->header);
        free(data);
        return 0;
    }

    // Parcurgem vectorul pana la final
    int size = 0;
    for(int index = 0; index < *len; index++)
        size += ((head*)((char*)*arr+size))->len + sizeof(head);

    // Realocam spatiu in vector pentru noul element
    *arr = realloc(*arr, size + sizeof(head)+data->header->len);
    if(!arr) {
        free(data->data);
        free(data->header);
        free(data);
        return 0;
    }
    *((head*)(*arr+size)) = *(data->header);
    size += sizeof(head);

    // Copiem elementul la final de vector
    memcpy(*arr+size, data->data, data->header->len);
    *len += 1;
    free(data->data);
    free(data->header);
    free(data);
    return 1;
}

int add_at(void **arr, int *len, data_structure *data, int index) {
    // Verificam indexul si stabilim unde introducem elementul
    if(index >= *len) {
        add_last(arr, len, data);
        return 1;
    } else if(index < 0) {
        return 0;
    }
    if(!*arr)
        *arr = malloc(1);

    // Parcurgem vectorul pana la pozitia unde trebuie introdus elementul
    int size = 0;
    for(int i = 0; i < index; i++)
        size += ((head*)((char*)*arr+size))->len + sizeof(head);

    // Calculam dimensiunea vectorului de la dreapta locului unde inseram
    int sizeRight = 0;
    for(int i = index; i < *len; i++)
        sizeRight += ((head*)((char*)*arr+sizeRight))->len + sizeof(head);

    // Dimensiunea elementului adaugat
    int sizeOfAdded = sizeof(head) + data->header->len;

    *arr = realloc(*arr, sizeRight + sizeof(head)+data->header->len);
    if(!arr) {
        free(data->data);
        free(data->header);
        free(data);
        return 0;
    }

    // Mutam elementele la dreapta cu sizeOfAdded
    memmove(*arr+size+sizeOfAdded, *arr+size, sizeRight-size);
    *((head*)(*arr+size)) = *(data->header);
    size += sizeof(head);

    // Copiem noul element in vector
    memcpy(*arr+size, data->data, data->header->len);
    (*len) += 1;
    free(data->data);
    free(data->header);
    free(data);
    return 1;
}

void find(void *data_block, int len, int index) {
    // Verificam daca indexul este corect
    if(index < 0 && index >= len)
        return;

    // Parcurgem vectorul pana la index
    int size = 0;
    for(int i = 0; i < index; i++)
        size += ((head*)((char*)data_block+size))->len + sizeof(head);

    // Afisarea propriu-zisa in functie de tip
    int i = size;
    printf("Tipul %d\n", ((head*)(data_block+i))->type);
    int lenOfElement = ((head*)(data_block+i))->len;
    int s_i8 = sizeof(int8_t); // size of int_8t
    int s_i16 = sizeof(int16_t); // size of int_16t
    int s_i32 = sizeof(int32_t); // size of int_32t
    if(((head*)(data_block+i))->type == 1) {
        void *d = data_block;
        i += sizeof(head);
        char *s1 = (char*)(d+i);
        char *s2 = (char*)(d+i+strlen((char*)(d+i))+1+2*s_i8);
        printf("%s pentru %s\n", s1, s2);
        printf("%d\n", *(int8_t*)(d+i+strlen((char*)(d+i))+1));
        printf("%d\n", *(int8_t*)(d+i+strlen((char*)(d+i))+1+s_i8));
        i += lenOfElement;
    } else if(((head*)(data_block+i))->type == 2) {
        void *d = data_block;
        i += sizeof(head);
        char *s1 = (char*)(d+i);
        char *s2 = (char*)(d+i+strlen((char*)(d+i))+1+s_i16+s_i32);
        printf("%s pentru %s\n", s1, s2);
        printf("%d\n", *(int16_t*)(d+i+strlen((char*)(d+i))+1));
        printf("%d\n", *(int32_t*)(d+i+strlen((char*)(d+i))+1+s_i16));
        i += lenOfElement;
    } else if(((head*)(data_block+i))->type == 3) {
        void *d = data_block;
        i += sizeof(head);
        char *s1 = (char*)(d+i);
        char *s2 = (char*)(d+i+strlen((char*)(d+i))+1+2*s_i32);
        printf("%s pentru %s\n", s1, s2);
        printf("%d\n", *(int32_t*)(d+i+strlen((char*)(d+i))+1));
        printf("%d\n", *(int32_t*)(d+i+strlen((char*)(d+i))+1+s_i32));
        i += lenOfElement;
    }
    printf("\n");
}

int delete_at(void **arr, int *len, int index) {
    // Verificam daca indexul primit e corect
    if(index < 0 || index >= *len)
        return 0;

    // Parcurgem vectorul pana la pozitia dorita
    int size = 0;
    for(int i = 0; i < index; i++)
        size += ((head*)((char*)*arr+size))->len + sizeof(head);

    // Calculam dimensiunea elementului ce urmeaza a fi sters
    int sizeDeleted = sizeof(head) + ((head*)((char*)*arr+size))->len;

    // pos este un nr care reprezinta ce distanta e de la
    // inceputul vectorului pana la pozitia urmatorului element
    int pos = size+sizeDeleted;

    // Mutam elementele din vector la stanga, bit cu bit
    for(int i = index + 1; i < *len; i++) {
        unsigned int sizeOfElement = 0;
        sizeOfElement = sizeof(head) + ((head*)(*arr+pos))->len;
        
        for(int j = 0; j < sizeOfElement; j++) {
            *((char*)*arr + pos-sizeDeleted+j) = *((char*)*arr + pos+j);
        }
        pos += sizeOfElement;
        
    }

    // Realocam spatiul pt vector, se face automat free pe ce nu ne trebuie
    *arr = realloc(*arr, pos-sizeDeleted);
    if(!arr) {
        return 0;
    }
    (*len)--;
    return 1;
}

void print(void *arr, int len) {
    int i = 0;
    if(len == 0)
        return;

    // Printarea elementelor din vector in fct de tipul lor
    for(int index = 0; index < len; index++) {
        printf("Tipul %d\n", ((head*)(arr+i))->type);
        int lenOfElement = ((head*)(arr+i))->len;
        int s_i8 = sizeof(int8_t); // size of int_8t
        int s_i16 = sizeof(int16_t); // size of int_16t
        int s_i32 = sizeof(int32_t); // size of int_32t
        if(((head*)(arr+i))->type == 1) {
            i += sizeof(head);
            char *s1 = (char*)(arr+i);
            char *s2 = (char*)(arr+i+strlen((char*)(arr+i))+1+2*s_i8);
            printf("%s pentru %s\n", s1, s2);
            printf("%d\n", *(int8_t*)(arr+i+strlen((char*)(arr+i))+1));
            printf("%d\n", *(int8_t*)(arr+i+strlen((char*)(arr+i))+1+s_i8));
            i += lenOfElement;
        } else if(((head*)(arr+i))->type == 2) {
            i += sizeof(head);
            char *s1 = (char*)(arr+i);
            char *s2 = (char*)(arr+i+strlen((char*)(arr+i))+1+s_i16+s_i32);
            printf("%s pentru %s\n", s1, s2);
            printf("%d\n", *(int16_t*)(arr+i+strlen((char*)(arr+i))+1));
            printf("%d\n", *(int32_t*)(arr+i+strlen((char*)(arr+i))+1+s_i16));
            i += lenOfElement;
        } else if(((head*)(arr+i))->type == 3) {
            i += sizeof(head);
            char *s1 = (char*)(arr+i);
            char *s2 = (char*)(arr+i+strlen((char*)(arr+i))+1+2*s_i32);
            printf("%s pentru %s\n", s1, s2);
            printf("%d\n", *(int32_t*)(arr+i+strlen((char*)(arr+i))+1));
            printf("%d\n", *(int32_t*)(arr+i+strlen((char*)(arr+i))+1+s_i32));
            i += lenOfElement;
        }
        printf("\n");
    }
}

int main() {
    void *arr = NULL;
    int len = 0;
    while(1) {
    	char *str = malloc(MAX);
    	if(!str)
            return 0;
        fgets(str, MAX, stdin);
        if(str[strlen(str)-1] == '\n')
            str[strlen(str)-1] = '\0';
            
        char *p = strtok(str, " ");
        if(!p) {
            continue;
        } else if(!strcmp(p, "insert")) {
            data_structure *data = createDataStructure(p);
            if(!data) {
            	free(str);
                return 0;
            }
            add_last(&arr, &len, data);
            free(str);
        } else if(!strcmp(p, "insert_at")) {
            p = strtok(NULL, " ");
            int index = atoi(p);
            data_structure *data = createDataStructure(p);
            if(!data) {
            	free(str);
                return 0;
            }
            add_at(&arr, &len, data, index);
            free(str);
        } else if(!strcmp(p, "delete_at")) {
            p = strtok(NULL, " ");
            int index = atoi(p);
            int deleted = delete_at(&arr, &len, index);
            free(str);
            if(deleted == 0)
                return 0;
        } else if(!strcmp(p, "find")) {
            p = strtok(NULL, " ");
            int index = atoi(p);
            find(arr, len, index);
            free(str);
        } else if(!strcmp(p, "print")) {
            print(arr, len);
            free(str);
        } else if(!strcmp(p, "exit")) {
            free(arr);
            free(str);
            return 0;
        }
    }
    return 0;
}
