%{
/*
Sequenze di espressioni in linguaggio Haskell formate da:

    numeri interi
    operazioni aritmetiche: +, *, -
    test di uguaglianza: ==
    la funzione if then else

L’analizzatore deve valutare le espressioni ricevute in ingresso.
*/
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "parser.tab.h"  
%}

%%
[ \t]          ; // ignora spazi e tab
\n           { return '\n'; }

[0-9]+         { yylval.intval = atoi(yytext); return NUMERO; }
"+"            { return SOMMA; }
"*"            { return MOLTIPLICA; }
"-"            { return SOTTRAI; }
"=="           { return TESTEQ; }
"if"           { return IF; }
"then"         { return THEN; }
"else"         { return ELSE; }
"("            { return '('; }
")"            { return ')'; }

.               { printf("Carattere non riconosciuto: %s\n", yytext); }
%%