%{
/*
Ricevuto in input una sequenza di sostantivi nelle lingua italiana, trasformare al plurale i sostantivi femminili e al singolare quelli maschili. 
Il programma può applicare una semplice regola generale per catalogare un sostantivo come 
femminile-maschile, singolare-plurale 
ma deve riuscire a gestire almeno una decina di eccezioni a questo regola 
(es. mano, tema, radio, parentesi, uomo).

printf( "parola maschile originale %s , forma desiderata: %s \n" yytext, formaDesiderata(yytext) )

*/

char* eccezioni(char string[], char *genere) {
    if (strcmp(string,"mano") == 0) {
        strcpy(string,  "mani");
        *genere = 'f';
        return string;
    }
    else if (strcmp(string,"tema") == 0) {
        *genere = 'm';
        strcpy(string,  "temi");
        return string;
    }
    else if (strcmp(string,"radio") == 0) {
        *genere = 'f';
        strcpy(string, "radio");
        return string;
        }
    else if (strcmp(string,"parentesi") == 0) {
        *genere = 'f';
        strcpy(string, "parentesi");
        return string;
        }
    else if (strcmp(string,"uomini") == 0) {
        *genere = 'm';
        memcpy(string, "uomo", 5);
        return string;
        }
    return NULL;
}

char* formaDesiderata(char parola[], char *genere) {
    int n = strlen(parola)-1;

    char* string = malloc(n+2);
    memcpy( string, parola, n+2 );

    if ( eccezioni(string, genere) != NULL ) {
        return string;
    }
    else if ( parola[n] == 'a' ) {
        *genere = 'f';
        string[n] = 'e';
        return string;
    } 
    else if (strcmp(parola+(n-2),"chi") == 0) {
        *genere = 'm';
        string[n-1] = 'o';
        string[n] = '\0';
        return string;
    }
    else if ( parola[n] == 'o' || parola[n] == 'i' ) {
        *genere = 'm';
        string[n] = 'o';
        return string;
    }
    
    return string;
}

%}

parola [A-Za-z]+

%%
{parola} {
    char genere;
    char* string = formaDesiderata(yytext, &genere);
    printf( "genere: %c. forma desiderata: %s \n", genere, string );
}

%%
int main(void){
    yylex();
    return 0;
}
int yywrap(){
    return 1;
}