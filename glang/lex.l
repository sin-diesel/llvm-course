%{
#define YYSTYPE void*
#include "grammar.tab.h"
extern "C" int yylex();
%}

%option yylineno
%option noyywrap

%%

[/][/].*\n              ; // comment
[0-9]+                  {
                        fprintf(stderr, "TINTEGER %s\n", yytext);
                        yylval = strdup(yytext);
                        return TINTEGER;
                        }

"="                     { fprintf(stderr, "TEQUAL\n");  return TEQUAL;}
"=="                    { fprintf(stderr, "TCEQ\n");    return TCEQ;}
"!="                    { fprintf(stderr, "TCNE\n");    return TCNE;}
"<"                     { fprintf(stderr, "TCLT\n");    return TCLT;}
"<="                    { fprintf(stderr, "TCLE\n");    return TCLE;}
">"                     { fprintf(stderr, "TCGT\n");    return TCGT;}
">="                    { fprintf(stderr, "TCGE\n");    return TCGE;}
"("                     { fprintf(stderr, "TLPAREN\n"); return TLPAREN;}
")"                     { fprintf(stderr, "TRPAREN\n"); return TRPAREN;}
"{"                     { fprintf(stderr, "TLBRACE\n"); return TLBRACE;}
"}"                     { fprintf(stderr, "TRBRACE\n"); return TRBRACE;}
"."                     { fprintf(stderr, "TDOT\n");    return TDOT;}
","                     { fprintf(stderr, "TCOMMA\n");  return TCOMMA;}


"return"                { fprintf(stderr, "TRETURN\n");        return TRETURN;}
"if"                    { fprintf(stderr, "TIF\n");            return TIF; }
"while"                 { fprintf(stderr, "TWHILE\n");         return TWHILE; }
"for"                   { fprintf(stderr, "TFOR\n");           return TFOR; }
"int"                   { fprintf(stderr, "TTYPE INT\n");      return TTYPE;}
"void"                  { fprintf(stderr, "TTYPE VOID\n");     return TTYPE;}
"start"                 { fprintf(stderr, "TSTART\n");         return TSTART;}
"finish"                { fprintf(stderr, "TFINISH\n");        return TFINISH;}
"goto"                  { fprintf(stderr, "TGOTO\n");          return TGOTO;}

"_Z12window_clearv"     { fprintf(stderr, "WINDOW_CLEAR\n");   return WINDOW_CLEAR;}
"_Z11check_eventv"      { fprintf(stderr, "CHECK_EVENT\n");    return CHECK_EVENT;}
"_Z5flushv"             { fprintf(stderr, "FLUSH\n");          return FLUSH;}
"_Z11init_windowjj"     { fprintf(stderr, "INIT_WINDOW\n");    return INIT_WINDOW;}
"_Z8int_randv"          { fprintf(stderr, "GEN_RAND\n");       return GEN_RAND;}
"put_pixel"             { fprintf(stderr, "PUT_PIXEL\n");      return PUT_PIXEL;}
"print"                 { fprintf(stderr, "PRINT\n");          return PRINT;}

[a-zA-Z_][a-zA-Z0-9_]*  { // identifier or array
                        fprintf(stderr, "TIDENTIFIER %s\n", yytext);
                        yylval = strdup(yytext);
                        return TIDENTIFIER;
                        }



[ \t\r\n]               ; // whitespace
.                       { return *yytext; }

%%