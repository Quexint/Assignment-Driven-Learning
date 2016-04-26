/*
 *  The scanner definition for COOL.
 */

/*
 *  Stuff enclosed in %{ %} in the first section is copied verbatim to the
 *  output, so headers and global definitions are placed here to be visible
 * to the code in the file.  Don't remove anything that was here initially
 */
%{
#include <cool-parse.h>
#include <stringtab.h>
#include <utilities.h>

/* The compiler assumes these identifiers. */
#define yylval cool_yylval
#define yylex  cool_yylex

/* Max size of string constants */
#define MAX_STR_CONST 1025
#define YY_NO_UNPUT   /* keep g++ happy */

extern FILE *fin; /* we read from this file */

/* define YY_INPUT so we read from the FILE fin:
 * This change makes it possible to use this scanner in
 * the Cool compiler.
 */
#undef YY_INPUT
#define YY_INPUT(buf,result,max_size) \
	if ( (result = fread( (char*)buf, sizeof(char), max_size, fin)) < 0) \
		YY_FATAL_ERROR( "read() in flex scanner failed");

char string_buf[MAX_STR_CONST]; /* to assemble string constants */
char *string_buf_ptr;

extern int curr_lineno;
extern int verbose_flag;

extern YYSTYPE cool_yylval;

/*
 *  Assignment: Add Your own definitions here
 */
int NEST_COMMENT_TIMES = 0;

%}

/*
 * Define names for regular expressions here.
 */

%START ONELINE_COMMENT NEST_COMMENT STRING

DARROW          =>
DASSIGN         <-
DLE             <=

DIGITS [0-9]+
LETTERS [A-Za-z]+
TYPE_IDEN [A-Z][A-Za-z0-9_]*
OBJ_IDEN [a-z][A-Za-z0-9_]*
TRUE_LETTER [t][Rr][Uu][Ee]
FALSE_LETTER [f][Aa][Ll][Ss][Ee]

/* COMMENT */
NEST_COMMENT_BEGIN "(*"
NEST_COMMENT_END "*)"
ONELINE_COMMENT_SYMBOL "--"

STRING_CHAR  ["]
WHITE_SPACE_CHAR [ \n\f\r\t\v]

%%

 /*
  *  Nested comments
  */
<INITIAL>{ONELINE_COMMENT_SYMBOL}.*  { BEGIN ONELINE_COMMENT; }
<ONELINE_COMMENT>"\n" {
  BEGIN INITIAL;
  curr_lineno++;
}
<ONELINE_COMMENT><<EOF>> { BEGIN INITIAL; }

<INITIAL,NEST_COMMENT>{NEST_COMMENT_BEGIN} {
  BEGIN NEST_COMMENT;
  NEST_COMMENT_TIMES++;
}
<INITIAL>{NEST_COMMENT_END} {
  BEGIN INITIAL;
  cool_yylval.error_msg = "Unmatched *)";
  return (ERROR);
}
<NEST_COMMENT>{NEST_COMMENT_END} {
  NEST_COMMENT_TIMES--;
  if(NEST_COMMENT_TIMES == 0)
    BEGIN INITIAL;
}
<NEST_COMMENT><<EOF>> {
  BEGIN INITIAL;
  cool_yylval.error_msg = "EOF in comment";
  return (ERROR);
}
<NEST_COMMENT>(.|"\n") {
  if(yytext[0]=='\n')
    curr_lineno++;
}


 /*
  *  The multiple-character operators.
  */

<INITIAL>{DARROW}		{ return (DARROW); }
<INITIAL>{DASSIGN}  { return (ASSIGN); }
<INITIAL>{DLE}  { return (LE); }


 /*
  * Keywords are case-insensitive except for the values true and false,
  * which must begin with a lower-case letter.
  */
 /* Keywords */
<INITIAL>{LETTERS}  {
  if(strcasecmp(yytext, "class")==0) return (CLASS);
  else if(strcasecmp(yytext, "else")==0) return (ELSE);
  else if(strcasecmp(yytext, "fi")==0) return (FI);
  else if(strcasecmp(yytext, "if")==0) return (IF);
  else if(strcasecmp(yytext, "in")==0) return (IN);
  else if(strcasecmp(yytext, "inherits")==0) return (INHERITS);
  else if(strcasecmp(yytext, "let")==0) return (LET);
  else if(strcasecmp(yytext, "loop")==0) return (LOOP);
  else if(strcasecmp(yytext, "pool")==0) return (POOL);
  else if(strcasecmp(yytext, "then")==0) return (THEN);
  else if(strcasecmp(yytext, "while")==0) return (WHILE);
  else if(strcasecmp(yytext, "case")==0) return (CASE);
  else if(strcasecmp(yytext, "esac")==0) return (ESAC);
  else if(strcasecmp(yytext, "of")==0) return (OF);
  else if(strcasecmp(yytext, "new")==0) return (NEW);
  else if(strcasecmp(yytext, "isvoid")==0) return (ISVOID);
  else if(strcasecmp(yytext, "not")==0) return (NOT);
  else REJECT;
}

 /* True and False */
<INITIAL>{TRUE_LETTER}  {
  cool_yylval.boolean = true;
  return (BOOL_CONST);
}
<INITIAL>{FALSE_LETTER} {
  cool_yylval.boolean = false;
  return (BOOL_CONST);
}

 /* Int Const */
<INITIAL>{DIGITS}  {
  cool_yylval.symbol = inttable.add_string(yytext);
  return (INT_CONST);
}

 /* Identifier */
<INITIAL>{TYPE_IDEN}  {
  cool_yylval.symbol = idtable.add_string(yytext);
  return (TYPEID);
}
<INITIAL>{OBJ_IDEN}  {
  cool_yylval.symbol = idtable.add_string(yytext);
  return (OBJECTID);
}

 /*
  *  String constants (C syntax)
  *  Escape sequence \c is accepted for all characters c. Except for 
  *  \n \t \b \f, the result is c.
  *
  */

<INITIAL>{STRING_CHAR}  {
  BEGIN STRING;
  string_buf_ptr = string_buf;
}
<STRING>{STRING_CHAR} {
  BEGIN INITIAL;
  if(string_buf_ptr != &(string_buf[MAX_STR_CONST])){
    *string_buf_ptr = '\0';
    cool_yylval.symbol = stringtable.add_string(string_buf);
    return (STR_CONST);
  }
}
<STRING>"\\\n"  {
  if(string_buf_ptr != &(string_buf[MAX_STR_CONST])){
    *string_buf_ptr++ = '\n';

    if(string_buf_ptr == &(string_buf[MAX_STR_CONST])){
      cool_yylval.error_msg = "String constant too long";
      return (ERROR);
    }
  }
}
<STRING>"\\\0"  {
  if(string_buf_ptr != &(string_buf[MAX_STR_CONST])){
    string_buf_ptr = &(string_buf[MAX_STR_CONST]);
    cool_yylval.error_msg = "String contains escaped null character";
    return (ERROR);
  }
}
<STRING>"\\".  {
  if(string_buf_ptr != &(string_buf[MAX_STR_CONST])){
    if(yytext[1] == 'b') *string_buf_ptr++ = '\b';
    else if(yytext[1] == 't') *string_buf_ptr++ = '\t';
    else if(yytext[1] == 'n') *string_buf_ptr++ = '\n';
    else if(yytext[1] == 'f') *string_buf_ptr++ = '\f';
    else *string_buf_ptr++ = yytext[1];

    if(string_buf_ptr == &(string_buf[MAX_STR_CONST])){
      cool_yylval.error_msg = "String constant too long";
      return (ERROR);
    }
  }
}
<STRING>"\n"  {
  BEGIN INITIAL;
  if(string_buf_ptr != &(string_buf[MAX_STR_CONST])){
    cool_yylval.error_msg = "Unterminated string constant";
    return (ERROR);
  }
}
<STRING>"\0"  {
  if(string_buf_ptr != &(string_buf[MAX_STR_CONST])){
    string_buf_ptr = &(string_buf[MAX_STR_CONST]);
    cool_yylval.error_msg = "String contains null character";
    return (ERROR);
  }
}

<STRING><<EOF>>  {
  BEGIN INITIAL;
  if(string_buf_ptr != &(string_buf[MAX_STR_CONST])){
    cool_yylval.error_msg = "Unterminated string constant";
    return (ERROR);
  }
}

<STRING>. {
  if(string_buf_ptr != &(string_buf[MAX_STR_CONST])){
    *string_buf_ptr++ = yytext[0];
    if(string_buf_ptr == &(string_buf[MAX_STR_CONST])){
      cool_yylval.error_msg = "String constant too long";
      return (ERROR);
    }
  }
}

<INITIAL>{WHITE_SPACE_CHAR} { if(yytext[0] == '\n') curr_lineno++; }
<INITIAL>[.,:;+\-*/=(){}~<@] { return yytext[0]; }

. {
  string_buf[0] = yytext[0];
  string_buf[1] = '\0';

  cool_yylval.error_msg = string_buf;
  return (ERROR);
}

%%
