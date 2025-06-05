

%{ //DEFINIZZIONI
    
/*
Riconoscere in un file di testo le seguenti classi di lessemi
    parole chiave: var, function, procedure, while, do, if then, else, for

    identificatori: stringhe che iniziano con una lettere minuscola dell’alfabeto seguite da lettere, 
        cifre, e i simboli ’_‘,’-’.      [a-z][a-zA-Z0-9-_]*

    costanti numeriche: sequenze di cifre,

    operatori: “+”, “++”, “-”, “–”, “=”, “==”,

Per ogni lessema riconosciuto, stampare una coppia (classe, valore).
*/

%}

/*regular expressions*/
stringhe [a-z][a-zA-Z0-9_-]* 
parole "var"|"function"|"procedure"|"while"|"do"|"if then"|"else"|"for"
costanti [0-9]+
operatori (\+{1}|\+{2}|-{1}|-{2}|={1}|={2})

%%

{stringhe} {
    printf("classe: stringhe, valore: %s\n", yytext);
}
{parole} {
    printf("classe: parole, valore: %s\n", yytext);
}
{costanti} {
    printf ("classe: costanti, valore: %s\n", yytext);
}
{operatori} {
    printf("classe: operatori, valore: %s\n", yytext);
}
%%

int main(void) {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}


