%{
#include "parser.tab.h"
%}

%%

GET { return T_GET; }
([/?a-zA-Z0-9_.~-]|(%[0-9a-fA-F]{2}))+(\?([a-zA-Z0-9_=&+%.-]|(%[0-9a-fA-F]{2}))+)* {
    yylval.string = strdup(yytext);
    return T_REQUEST_URI;
}
[ ] { return T_SPACE; }
\n {return T_NEWLINE;}

. {  }

%%

int yywrap() {
    return 1;
}
