%{
#include <stdio.h>
int linea = 1;
int num_token = 1;
%}

/* Definición de tokens */
%s RESERVED

/* Palabras reservadas */
%%
SELECT { printf("%d\t%d\t%s\t1\t10\n", num_token++, linea, yytext); BEGIN(RESERVED); }
FROM { printf("%d\t%d\t%s\t1\t11\n", num_token++, linea, yytext); BEGIN(RESERVED); }
WHERE { printf("%d\t%d\t%s\t1\t12\n", num_token++, linea, yytext); BEGIN(RESERVED); }
IN { printf("%d\t%d\t%s\t1\t13\n", num_token++, linea, yytext); BEGIN(RESERVED); }
AND { printf("%d\t%d\t%s\t1\t14\n", num_token++, linea, yytext); BEGIN(RESERVED); }
OR { printf("%d\t%d\t%s\t1\t15\n", num_token++, linea, yytext); BEGIN(RESERVED); }
CREATE { printf("%d\t%d\t%s\t1\t16\n", num_token++, linea, yytext); BEGIN(RESERVED); }
TABLE { printf("%d\t%d\t%s\t1\t17\n", num_token++, linea, yytext); BEGIN(RESERVED); }
CHAR { printf("%d\t%d\t%s\t1\t18\n", num_token++, linea, yytext); BEGIN(RESERVED); }
NUMERIC { printf("%d\t%d\t%s\t1\t19\n", num_token++, linea, yytext); BEGIN(RESERVED); }
NOT { printf("%d\t%d\t%s\t1\t20\n", num_token++, linea, yytext); BEGIN(RESERVED); }
NULL { printf("%d\t%d\t%s\t1\t21\n", num_token++, linea, yytext); BEGIN(RESERVED); }
CONSTRAINT { printf("%d\t%d\t%s\t1\t22\n", num_token++, linea, yytext); BEGIN(RESERVED); }
KEY { printf("%d\t%d\t%s\t1\t23\n", num_token++, linea, yytext); BEGIN(RESERVED); }
PRIMARY { printf("%d\t%d\t%s\t1\t24\n", num_token++, linea, yytext); BEGIN(RESERVED); }
FOREIGN { printf("%d\t%d\t%s\t1\t25\n", num_token++, linea, yytext); BEGIN(RESERVED); }
REFERENCES { printf("%d\t%d\t%s\t1\t26\n", num_token++, linea, yytext); BEGIN(RESERVED); }
INSERT { printf("%d\t%d\t%s\t1\t27\n", num_token++, linea, yytext); BEGIN(RESERVED); }
INTO { printf("%d\t%d\t%s\t1\t28\n", num_token++, linea, yytext); BEGIN(RESERVED); }
VALUES { printf("%d\t%d\t%s\t1\t29\n", num_token++, linea, yytext); BEGIN(RESERVED); }
"," { printf("%d\t%d\t%s\t5\t50\n", num_token++, linea, yytext); }
"." { printf("%d\t%d\t%s\t5\t51\n", num_token++, linea, yytext); }
"(" { printf("%d\t%d\t%s\t5\t52\n", num_token++, linea, yytext); }
")" { printf("%d\t%d\t%s\t5\t53\n", num_token++, linea, yytext); }
"'" { printf("%d\t%d\t%s\t5\t54\n", num_token++, linea, yytext); }
.|\n { if (*yytext == '\n') linea++; }
%%

int main() {
    FILE *archivo = fopen("texto.txt", "r");
    yyin = archivo;
    printf("Num\tLinea\tToken\tTipo\tCodigo\n");
    yylex();
    fclose(archivo);
    return 0;
}

int yywrap() {
    return 1;
}
