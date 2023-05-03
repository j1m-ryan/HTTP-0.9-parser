%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}

%union {
    double decimal;
    char* string;
}

%token T_GET T_Host T_HTTP T_SLASH T_REQUEST_URI
%token <decimal> T_DECIMAL

%%

request:
    get request-uri http version
    {
        printf("Parsed successfully: GET followed by HTTP and version\n");
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

host:
    T_Host { printf("Found a Host\n"); }
;

slash:
    T_SLASH {
        printf("Found a slash\n");
    }
;

http: 
    T_HTTP {
        printf("Found http\n");
    }
;

version:
    T_DECIMAL {
        printf("Found version: %.1f\n", yylval.decimal);
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

    return 0;
}

void yyerror(const char* s) {
    printf("Error: %s\n", s);
}
