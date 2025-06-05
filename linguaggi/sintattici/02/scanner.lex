%{
/*
Il linguaggio formato da espressioni aritmetiche 
scritte in notazione polacca diretta e 
costruite a partire dalle costanti intere e le 4 operazioni aritmetiche. 
L’analizzatore deve valutare l’espressione ricevuta in ingresso.
*/

#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.h"
%}

%%
[ \t]           ;                   // ignora spazi e tab
[\+\-]?[0-9]+          { yylval.intval = atoi(yytext); return NUM; }
\n              { return '\n'; }
"+"             { return '+'; }
"-"             { return '-'; }
"*"             { return '*'; }
"/"             { return '/'; }
"("             { return '('; }
")"             { return ')'; }
.               { printf("Carattere non riconosciuto: %s\n", yytext); }
%%
