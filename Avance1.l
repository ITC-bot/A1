%{
#include <stdio.h>
#include <string.h>
%}

%option noyywrap

%%

SELECT      { printf("SELECT\n"); }
FROM        { printf("FROM\n"); }
WHERE       { printf("WHERE\n"); }
AND         { printf("AND\n"); }
[A-Za-z]+   { printf("NOMBRE DE COLUMNA: %s\n", yytext); }
'[^']*'     { printf("VALOR: %s\n", yytext); }
">="        { printf("OPERADOR: >=\n"); }
,           { printf("COMA\n"); }
;           { printf("PUNTO Y COMA\n"); }
[ \t\n]+    { /* ignorar espacios en blanco y saltos de línea */ }
.           { printf("CARACTER DESCONOCIDO: %s\n", yytext); }

%%

int main()
{
    FILE *archivo = fopen("texto.txt", "r");
    yyin = archivo;
    yylex();
    fclose(archivo);
    return 0;
}
