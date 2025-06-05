%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *str) {
    fprintf(stderr, "Errore: %s\n", str);
}
int yylex();
int yywrap() { return 1; }

int main() { return yyparse(); }
%}
%union {
    int intval;
    char *id;
    struct Node *node;
}

%token <intval> NUM
%token <id> ID
%token SIN COS TAN
%token POW

%left '-' '+'
%left '*' '/'
%left SIN COS TAN 
%right POW

%%







%%