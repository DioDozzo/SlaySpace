%{
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

void yyerror(const char *str) {
    fprintf(stderr, "Errore: %s\n", str);
}
int yylex();
int yywrap() { return 1; }

int main() {
    printf("Inserisci un'espressione:\n");
    int ret = yyparse();
    return ret;
}

typedef struct Node {
  char* op;
  struct Node* left;
  struct Node* right;
  int intval;
  bool is_leaf;
} Node;

Node* new_binary_node(const char* op, Node* left, Node* right) {
    Node* node = malloc(sizeof(Node));
    node->op = strdup(op);
    node->left = left;
    node->right = right;
    node->intval = 0;
    node->is_leaf = false;
    return node;
}
Node* new_unary_node(const char* op, Node* operand) {
    Node* node = malloc(sizeof(Node));
    node->op = strdup(op);
    node->left = operand;
    node->right = NULL;
    node->intval = 0;
    node->is_leaf = false;
    return node;
}
void print_tree(Node* node, int level) {
    if (!node) return;

    for (int i = 0; i < level; i++) printf("  ");

    if (node->is_leaf) {
        if (node->op != NULL)
            printf("ID: %s\n", node->op);
        else
            printf("NUM: %d\n", node->intval);
    } else {
        printf("OP: %s\n", node->op);
        if (node->left)  print_tree(node->left, level + 1);
        if (node->right) print_tree(node->right, level + 1);
    }
}
void free_tree(Node* node) {
    if (!node) return;

    if (node->left)  free_tree(node->left);
    if (node->right) free_tree(node->right);
    if (node->op)    free(node->op);

    free(node);
}


%}
//-------------------------------------------------------------------
%union {
    int intval;
    char* id;
    struct Node *node;
}

%token <intval> NUM
%token <id> ID
%token SIN 
%token COS 
%token TAN
%token POW

%type <node> exp

%left '-' '+'
%left '*' '/'
%left SIN COS TAN 
%right POW



//----------------------------------------------------------------------------------------------
%%
input:
  | input line
  ;

line:
    '\n'
  | exp '\n' {
        printf("Albero sintattico:\n");
        print_tree($1, 0);
        free_tree($1);
    }
;


exp:
      ID {
          $$ = malloc(sizeof(Node));
          $$->op = strdup($1);
          $$->left = NULL;
          $$->right = NULL;
          $$->intval = 0;
          $$->is_leaf = true;
      }
    |  NUM {
          $$ = malloc(sizeof(Node));
          $$->op = NULL;
          $$->left = NULL;
          $$->right = NULL;
          $$->intval = $1;
          $$->is_leaf = true;
      }
    | exp '+' exp { 
          $$ = new_binary_node("+", $1, $3); 
      }
    | exp '-' exp { 
          $$ = new_binary_node("-", $1, $3); 
      }
    | exp '*' exp { 
          $$ = new_binary_node("*", $1, $3); 
      }
    | exp '/' exp {
          if ($3->is_leaf && $3->intval == 0) {
              yyerror("Divisione per zero");
              $$ = NULL;
          } else {
              $$ = new_binary_node("/", $1, $3);
          }
      }
    | exp POW exp {
          $$ = new_binary_node("pow", $1, $3); 
      }
    | SIN '(' exp ')' {
          $$ = new_unary_node("sin", $3);
      }
    | COS '(' exp ')' {
          $$ = new_unary_node("cos", $3);
      }
    | TAN '(' exp ')' {
          $$ = new_unary_node("tan", $3);
      }
    | '(' exp ')' {
          $$ = $2;
      }
    ;

%%
//--------------------------