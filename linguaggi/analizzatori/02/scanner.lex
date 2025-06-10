%{
/*
Rimuovere i commenti da un testo Haskell. 
I commenti Haskell, hanno due possibili formati
        iniziano con la stringa di caratteri -- e terminano con il ritorno a capo
        iniziano con la stringa di caratteri {- e terminano con la stringa -}

Si cerchi inoltre di risolvere il problema di riconoscere coppie di commenti innestati, 
ossia la stringa 
{- aa {- bb -} cc -} viene riconosciuta come un singolo commento 
e non come il commento {- aa {- bb -} seguito dalla stringa cc -}
*/
#include <stdio.h>

int comment_nesting_level = 0;

%}

%x IN_COMMENT 

%%
"--".* { ; }

"{-"   { BEGIN(IN_COMMENT); 
         comment_nesting_level = 1; }

<IN_COMMENT>"{-"      { comment_nesting_level++; } 
<IN_COMMENT>"-}"      { comment_nesting_level--; 
                        if (comment_nesting_level == 0) {
                            BEGIN(INITIAL); 
                            }
                      }
<IN_COMMENT>.         {;}
<IN_COMMENT>\n        {;}


.|\n    { putchar(yytext[0]); }

%%

int yywrap(){
    return 1;
}
int main(){
    printf("Inizio del file\n");
    yylex();
    printf("Fine del file\n");
    return 0;
}