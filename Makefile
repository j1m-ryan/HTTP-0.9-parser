CC = gcc
CFLAGS = -Wall
BISON = bison
FLEX = flex
LIBS = -lfl
OUTPUT = http09_parser

all: $(OUTPUT)

parser.tab.c parser.tab.h: parser.y
	$(BISON) -d parser.y

lex.yy.c: lexer.l parser.tab.h
	$(FLEX) lexer.l

$(OUTPUT): parser.tab.c lex.yy.c
	$(CC) $(CFLAGS) parser.tab.c lex.yy.c -o $(OUTPUT) $(LIBS)

.PHONY: clean
clean:
	rm -f parser.tab.c parser.tab.h lex.yy.c $(OUTPUT)