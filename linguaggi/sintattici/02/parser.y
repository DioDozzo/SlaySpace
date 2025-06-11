%{
#include <stdio.h>
#include <stdlib.h>

int yyparse(void);
void yyerror(const char *str) {
    fprintf(stderr, "Errore: %s\n", str);
}
int yylex();
int yywrap() { return 1; }

int main() { return yyparse(); }
%}
%union {
    int intval;
}

%token <intval> NUM
%type <intval> exp

%left '-' '+'
%left '*' '/'

%%
input:
    | input line
    ;

line: '\n'
    | exp '\n' {printf("questo valore è %d \n", $1); }
    ;

exp : NUM         { $$=$1    ;   }
    | '-' exp exp { $$=$2-$3 ;   }
    | '+' exp exp { $$=$2+$3 ;   }
    | '*' exp exp { $$=$2*$3 ;   }
    | '/' exp exp { if ($3 == 0) {
                        yyerror("Divisione per zero");
                        $$ = 0;
                    } else {
                        $$ = $2 / $3;
                    }
                  }
    | '(' exp ')' {$$=$2    ;   }
    ;


%%