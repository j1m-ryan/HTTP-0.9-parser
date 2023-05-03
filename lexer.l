%{
#include "parser.tab.h"
%}

%%

GET { return T_GET; }
Host { return T_Host; }

.|\n { /* Ignore everything else */ }

%%

int yywrap() {
    return 1;
}
