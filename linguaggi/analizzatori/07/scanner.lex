%{
/*
Riconoscere, in un file di testo, le sequenze di caratteri che rappresentano un numero in uno dei seguenti formati:

    numero intero: stringa di cifre decimali, eventualmente precedute dal segno (+/-)
    numero frazionari: coppia di stringhe di cifre intervallate da un punto ed eventualmente precedute dal segno, una delle due stringe, ma non entrambe può essere vuota.
    floating point: numero intero o frazionario, seguito da “e”, oppure “E”, seguito da un numero intero.

Per ciascuna sequenza riconosciuta, stampare in uscita: la sequenza stessa, il tipo di numero rappresentato, il numero di cifre usate nella rappresentazione.
*/
#include <stdio.h>



int n_cifre(char* var){
    int count = 0;
    for (int i = 0; i<strlen(var) ;i++){
        char ch0 = '0';
        char ch9 = '9';
        char chV = var[i];
        if (ch0 <= chV && chV <= ch9) {
            count++;
        }
    }
    return count;
}

%}
intero [+|-]?[0-9]+
frazionario [+|-]?([0-9]+\.|\.[0-9]+|[0-9]+\.[0-9]+)
floating ({intero}|{frazionario})[e|E]{intero}


%%
{intero} {
    printf("(%s, intero, lunghezza: %d)\n", yytext, n_cifre(yytext));
}
{frazionario} {
    printf("(%s, frazionario, lunghezza: %d)\n ",yytext, n_cifre(yytext));
}
{floating} {
    printf("(%s, floating, lunghezza: %d)\n ",yytext, n_cifre(yytext));
}

.\n {}
%%

int main(void) {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}