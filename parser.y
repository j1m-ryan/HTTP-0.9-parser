%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}

%token T_GET T_Host

%%

request:
    get host
    {
        printf("Parsed successfully: GET followed by Host\n");
    }
;

get:
    T_GET { printf("Found a GET\n"); }
;

host:
    T_Host { printf("Found a Host\n"); }
;

%%

int main(int argc, char** argv) {
    if (argc != 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        exit(1);
    }

    FILE* inputFile = fopen(argv[1], "r");
    if (!inputFile) {
        printf("Error opening file: %s\n", argv[1]);
        exit(1);
    }

    yyin = inputFile;
    yyparse();
    fclose(inputFile);

    return 0;
}

void yyerror(const char* s) {
    printf("Error: %s\n", s);
}
