%{
#include <stdio.h>
#include <string.h>

typedef struct {
    char nombre[100];
    char valor[100];
    int linea;
} identificador;

typedef struct {
    char nombre[50];
    char tipo[10];
    char valor[50];
    int linea;
} constante;

int num_ident = 0;
identificador tabla_ident[100];
int linea = 1;
int num_token = 1;
int contador_ident = 401;
int contador_const = 600;
constante tabla_const[100];
int num_const = 0;

void yyerror(const char *mensaje) {
    fprintf(stderr, "Error linea %d: %s\n", linea, mensaje);
}

%}

IDENTIFIER [A-Za-z][A-Za-z0-9_]*
CONSTANT   '[^']*'

%s RESERVED


%%
[ \t\r]+ {}
[\n]     { linea++; }
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
"‘" { printf("%d\t%d\t%s\t5\t54\n", num_token++, linea, yytext); }

"+" { printf("%d\t%d\t%s\t7\t70\n", num_token++, linea, yytext); }
"-" { printf("%d\t%d\t%s\t7\t71\n", num_token++, linea, yytext); }
"*" { printf("%d\t%d\t%s\t7\t72\n", num_token++, linea, yytext); }
"/" { printf("%d\t%d\t%s\t7\t73\n", num_token++, linea, yytext); }

">" { printf("%d\t%d\t%s\t8\t81\n", num_token++, linea, yytext); }
"<" { printf("%d\t%d\t%s\t8\t82\n", num_token++, linea, yytext); }
"=" { printf("%d\t%d\t%s\t8\t83\n", num_token++, linea, yytext); }
">=" { printf("%d\t%d\t%s\t8\t84\n", num_token++, linea, yytext); }
"<=" { printf("%d\t%d\t%s\t8\t85\n", num_token++, linea, yytext); }

. { yyerror("Caracter desconocido"); }

[[:alpha:]_][[:alnum:]_]* {
    printf("%d\t%d\t%s\t4\t%d\n", num_token++, linea, yytext, contador_ident);
    identificador nuevo_ident;
    strcpy(nuevo_ident.nombre, yytext);
    sprintf(nuevo_ident.valor, "%d", contador_ident);
    nuevo_ident.linea = linea;
    tabla_ident[num_ident++] = nuevo_ident;
    contador_ident++;
}

'([^']*)' { 
    printf("%d\t%d\t%s\t%d\t6\n", num_token++, linea, yytext, contador_const);
    constante nueva_const;
    strcpy(nueva_const.nombre, yytext);
    strcpy(nueva_const.tipo, "62"); 
    sprintf(nueva_const.valor, "%d", contador_const);
    nueva_const.linea = linea;
    tabla_const[num_const++] = nueva_const;
    contador_const++;
}

[0-9]+ {  
    printf("%d\t%d\t%s\t%d\t64\n", num_token++, linea, yytext, contador_const);
    constante nueva_const;
    strcpy(nueva_const.nombre, yytext);
    strcpy(nueva_const.tipo, "61"); 
    sprintf(nueva_const.valor, "%d", contador_const);
    nueva_const.linea = linea;
    tabla_const[num_const++] = nueva_const;
    contador_const++;
}

%%

int main() {
    FILE *archivo = fopen("texto.txt", "r");
    yyin = archivo;
    printf("\n--Tabla lexica--\n");
    printf("Num\tLinea\tToken\tTipo\tCodigo\n");
    yylex();
    printf("\n--Tabla de identificadores--\n");
    printf("Nombre\tValor\tLínea\n");
    for(int i=0; i<num_ident; i++) {
        printf("%s\t%s\t%d\n", tabla_ident[i].nombre, tabla_ident[i].valor, tabla_ident[i].linea);
    }
    printf("\n--Tabla de constantes--\n");
    printf("No.\tConstante\tTipo\tValor\n");
    for (int i = 0; i < num_const; i++) {
        printf("%d\t%s\t%s\t%s\n", i+1, tabla_const[i].nombre, tabla_const[i].tipo, tabla_const[i].valor);
    }
    fclose(archivo);
    return 0;
}

int yywrap() {
    return 1;
}