%{
/*
Riconoscere stringhe di cifre e caratteri, che rappresentano i numeri in uno dei seguenti formati:

    numero interi: stringa di cifre decimali, eventualmente precedute dal segno (+/-)
    numeri esadecimali: stringa di cifre esadecimali (0-9, a-f, A-F) preceduta dalla sequenze “0x”, oppure una stringa di cifra esadecimali seguita da ‘H’.
    numeri ottali: stringa di cifre ottali (0-7) preceduta dalla sequenze “0o”, oppure una stringa di cifre ottali seguite da ‘O’.

Per ciascuna stringa riconosciuta stampare in uscita il formato del numero riconosciuto, il suo valore decimale.
*/
int dec_value(char* str_dec, int base) {
    char* endptr;
    endptr = NULL;
    int val = strtol(str_dec, &endptr, base); 
    return val;
}

%}

ottale (0[oO][0-7]+)|([0-7]+[oO])
intero [\+\-]?[0-9]+
esadecimale (0[xX][0-9a-fA-F]+)|([0-9a-fA-F]+[hH])



%%
{intero} {
    printf("intero: %s, valore decimale: %d\n", yytext, dec_value(yytext, 10));
}
{esadecimale} {
    char *start = yytext;
    if (yytext[0] == '0' && (yytext[1] == 'x' || yytext[1] == 'X')) {
        start += 2; // Skip "0x" or "0X"
    }
    printf("esadecimale: %s, valore decimale: %d\n", yytext, dec_value(start, 16));
}
{ottale} {
    char *start = yytext;
    if (yytext[0] == '0' && (yytext[1] == 'o' || yytext[1] == 'O')) {
        start += 2; // Skip "0o" or "0O"
    }
    printf("ottale: %s, valore decimale: %d\n", yytext, dec_value(start, 8));
}

. { printf("carattere non riconosciuto: %s\n", yytext); } 
%%

int main(void) {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}