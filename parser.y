%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);

int syntax_error = 0;
%}

%union {
    char* string;
}

%token T_GET T_REQUEST_URI T_NEWLINE T_SPACE
%token <decimal> T_DECIMAL

%%

request:
    get T_SPACE request-uri T_NEWLINE
    {
        printf("Parsed successfully:\n");
    }
;

get:
    T_GET { printf("Found a GET\n"); }
;

request-uri:
    T_REQUEST_URI {
        printf("Found a request uri: %s\n", yylval.string);
    }
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

    return syntax_error;
}

void yyerror(const char* s) {
    printf("Error: %s\n", s);
    syntax_error = 1;
}
