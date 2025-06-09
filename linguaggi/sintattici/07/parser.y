%{
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>


extern int yyparse();
void yyerror(const char *str) {    fprintf(stderr, "Errore: %s\n", str); }
int yylex();
int yywrap() { return 1; }

int main() {
    printf("Inserisci espressione in linguaggio Haskell :\n");
    return yyparse();
}
%}

%union {
    int intval;
}

%token <intval> NUMERO
%token SOMMA MOLTIPLICA SOTTRAI TESTEQ IF THEN ELSE

%type <intval> exp


%left  TESTEQ
%left SOMMA SOTTRAI
%left MOLTIPLICA
%nonassoc IF 
%nonassoc THEN 
%nonassoc ELSE

//------------------------------------
%%
input:
      /* empty */
    | input line
    ;


line:
    '\n'  
    | exp '\n' {
        printf("Solution: %d \n", $1);
        }
    ;

exp:
    NUMERO {
        $$ = $1;
        }
    | exp SOMMA exp {
        $$ = $1 + $3;
        }
    | exp MOLTIPLICA exp {
        $$ = $1 * $3;
        }
    | exp SOTTRAI exp {
        $$ = $1 - $3;
        }
    | exp TESTEQ exp {
        $$ = ($1 == $3);
        printf("Test di uguaglianza: %s\n", ($$ ? "True" : "False"));
        }

    | IF exp THEN exp ELSE exp {
            if ($2) {  // Se la condizione è vera
                $$ = $4;  // Se la condizione è vera, valuta il ramo "then"
            } else {
                $$ = $6;  // Altrimenti valuta il ramo "else"
            }
        }
    | '(' exp ')' {
        $$ = $2;
        }
;
  

    
%%