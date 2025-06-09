%{

/*
Il linguaggio formato da espressioni aritmetiche costruite a partire da:

    identificatori,
    costanti numeriche: numeri naturali,
    le 4 operazioni aritmetiche,
    esponente: **,
    le funzioni analitiche: sin, cos, tan,
    parentesi.

L’ordine di priorità tra i vari operatori è definito in questo modo: 
    per le operazioni aritmetiche vale l’ordine usale, 
    l’esponente ha priorità sulle funzioni trigonometriche che a loro volta hanno priorità sul prodotto. 
    Tutte le operazioni sono associative a sinistra, meno l’esponente che associa a destra.

L’analizzatore deve restituire l’albero della struttura sintattica dell’espressione ricevuta in ingresso.
*/
#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.h"
%}
%%
[ \t]           ;      // ignora spazi e tab
[0-9]+          { yylval.intval = atoi(yytext); return NUM; }       //numero naturale

\n              { return '\n'; }

"+"             { return '+'; }
"-"             { return '-'; }
"*"             { return '*'; }
"/"             { return '/'; }

"("             { return '('; }
")"             { return ')'; }

"**"            { return POW; }
"sin"           { return SIN; }
"cos"           { return COS; }
"tan"           { return TAN; }

[a-zA-Z_][a-zA-Z0-9_]* { yylval.id = strdup(yytext); return ID; }   // identificatore

.               { printf("Carattere non riconosciuto: %s\n", yytext); }
%%
