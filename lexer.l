%{
#include "parser.tab.h"
%}

%%

GET { return T_GET; }
Host { return T_Host; }
HTTP {return T_HTTP;}
[0-9][.][0-9] {
    yylval.decimal = atof(yytext);
    return T_DECIMAL;
}
[/?a-zA-Z0-9_.~-]+(\?[a-zA-Z0-9_=&+%.-]+)? {
    yylval.string = strdup(yytext);
    return T_REQUEST_URI;
}

"/" {return T_SLASH;}

[ \t\n]+ { /* Ignore whitespace characters */ }

. { /* Ignore everything else */ }

%%

int yywrap() {
    return 1;
}
