%option noyywrap
%{
#include "headers/1605103_SymbolTable.h"
#include "y.tab.h"


extern YYSTYPE yylval;
void yyerror(char *);
const string removeSingleQuote(string s);
const string processString(string s);


extern int lines,errors;
extern vector<SymbolInfo*>para_list;
extern SymbolTable *symbolTable;


%}
/**End Of C-Code Section Inside Definition Section ***/

/**Start Of Pattern-Definition Section Inside Definition Section**/
WHITESPACE  (\t|\f|\r|\v|" ")+
NEWLINE [\n]

LETTER [a-zA-Z]
DIGIT [0-9]

IDENTIFIER (_|{LETTER})(_|{LETTER}|{DIGIT})*
INVALID_IDENTIFIER {DIGIT}(_|{LETTER}|{DIGIT})*

INTEGER ({DIGIT}+)
FLOAT1 ({INTEGER}|"")(".")({INTEGER})
FLOAT2 ({FLOAT1}|{INTEGER})("E")("-"|"")({INTEGER})
TOO_MANY_DECIMAL_POINTS ({INTEGER}|"")(".")(({INTEGER})("."))+({INTEGER}|"")
ILL_FORMED_NUMBER ({FLOAT2}|{FLOAT1}|"")(".")(({FLOAT2}|{FLOAT1})("."))*({FLOAT2}|{FLOAT1}|{INTEGER}|"")

RELOP "<"|">"|">="|"<="|"!="|"=="
BITOP "<<"|">>"|"^"|"&"|"|"
INCOP "++"
DECOP "--"
MULOP "%"|"*"|"/"
LOGICOP "&&"|"||"
ADDOP "+"|"-"

CHAR [ -~]{-}['\\]
ESCAPE_CHAR \\["'\\ntrvfab0]
CONST_CHAR \'{CHAR}\'
CONST_ESCAPE_CHAR \'{ESCAPE_CHAR}\'
MULTI_CHAR_CONSTANT \'{CHAR}{CHAR}+\'|\'{ESCAPE_CHAR}{ESCAPE_CHAR}+\'
INVALID_CHAR \'({CHAR}|[\\])*\'
UNFINISHED_CHAR \'({CHAR}|[\\])*[^'\n]?|(\'\\\')

STRING \"([^\"\n\\]|(\\\n)|(\")|{ESCAPE_CHAR})*\"
UNFINISHED_STRING \"([^\"\n]|(\\[\n]))*

DOUBLE_SLASH_COMMENT "//"((.*\\\n.*)|(.*))*
BLOCK_COMMENT "/*"([^*]|("*"[^/]))*"*/"
UNFINISHED_COMMENT "/*"([^*]|("*"[^/]))*[^"*/"]


/**End Of Pattern-Definition Section Inside Definition Section**/
/**End Of Definition Section**/

/** Start of Rules Section**/
%%

{WHITESPACE} {}
{NEWLINE} {lines++;}

{DOUBLE_SLASH_COMMENT}|{BLOCK_COMMENT}  {
	int detectionLine = lines;
	string processed = processString(yytext);
	Util::lexerLog(detectionLine,"COMMENT",processed);
}
{UNFINISHED_COMMENT} {
	Util::appendLogError(lines,"Unfinished Comment " + processString(yytext),LEXER);
	errors++;
}

{STRING} {
	int detectionLine = lines;
	string processed = processString(yytext);
	Util::lexerLog(detectionLine,"STRING",string(yytext));
	Util::appendToken("STRING",processed);

	SymbolInfo *s= new  SymbolInfo(processed, "STRING");
	yylval.Symbol = s;

	return STRING;
}
{UNFINISHED_STRING} {
	Util::appendLogError(lines,"Unfinished String " +string(yytext),LEXER);
	errors++;
}

{CONST_CHAR}|{CONST_ESCAPE_CHAR} {
	Util::lexerLog(lines,"CONST_CHAR",yytext);
	string s = removeSingleQuote(yytext);
	Util::appendToken("CONST_CHAR",s);

	SymbolInfo *sm= new  SymbolInfo(yytext, "CONST_CHAR");
	yylval.Symbol= sm;

	return CONST_CHAR;
}
{MULTI_CHAR_CONSTANT} {
	Util::appendLogError(lines,"Multi Character Constant " + string(yytext),LEXER);
	errors++;
}
{UNFINISHED_CHAR} {
	Util::appendLogError(lines,"Unfinished Character "+string(yytext),LEXER);
	errors++;
}
{INVALID_CHAR} {
	if(string(yytext)=="''")Util::appendLogError(lines,"Empty Character Constant "+string(yytext),LEXER);
	else Util::appendLogError(lines,"Invalid Character "+string(yytext),LEXER);
	errors++;
}

{INTEGER} {
	Util::lexerLog(lines,"CONST_INT",yytext);
	Util::appendToken("CONST_INT",yytext);

	SymbolInfo *s= new  SymbolInfo(yytext, "CONST_INT");
	yylval.Symbol = s;

	return CONST_INT;
}
{FLOAT1}|{FLOAT2} {
	Util::lexerLog(lines,"CONST_FLOAT",yytext);
	Util::appendToken("CONST_FLOAT",yytext);

	SymbolInfo *s= new  SymbolInfo(yytext, "CONST_FLOAT");
	yylval.Symbol = s;

	return CONST_FLOAT;
}
{TOO_MANY_DECIMAL_POINTS} {
	Util::appendLogError(lines,"Too Many Decimal Points! "+string(yytext),LEXER);

	errors++;

}
{ILL_FORMED_NUMBER} {
	Util::appendLogError(lines,"Ill formed number! "+string(yytext),LEXER);
	errors++;
}

"int" {
	return INT;
}
"char" {
	return CHAR;
}
"float"	{
	return FLOAT;
}
"double" {
	return DOUBLE;
}
"void" {
	return VOID;
}
"if" {
	return IF;
}
"else" {
	return ELSE;
}
"do" {
	return DO;
}
"while"	{
	return WHILE;
}

"for" {
	return FOR;
}
"break" {
	return BREAK;
}

"return" {
	return RETURN;
}
"println" {
	return PRINTLN;
}

";" {
	Util::appendToken("SEMICOLON",yytext);
	Util::lexerLog(lines,"SEMICOLON",yytext);

	return SEMICOLON;
}

"," {
	Util::appendToken("COMMA",yytext);
	Util::lexerLog(lines,"COMMA",yytext);

	return COMMA;
}
"(" {
	Util::appendToken("LPAREN",yytext);
	Util::lexerLog(lines,"LPAREN",yytext);

	return LPAREN;
}
")" {
	Util::appendToken("RPAREN",yytext);
	Util::lexerLog(lines,"RPAREN",yytext);

	return RPAREN;
}
"{" {
	Util::appendToken("LCURL",yytext);
	Util::lexerLog(lines,"LCURL",yytext);

	return LCURL;
}
"}" {
	Util::appendToken("RCURL",yytext);
	Util::lexerLog(lines,"RCURL",yytext);

	return RCURL;
}
"[" {
	Util::appendToken("LTHIRD",yytext);
	Util::lexerLog(lines,"LTHIRD",yytext);

	return LTHIRD;
}
"]" {
	Util::appendToken("RTHIRD",yytext);
	Util::lexerLog(lines,"RTHIRD",yytext);

	return RTHIRD;
}
"!" {
	Util::appendToken("NOT",yytext);
	Util::lexerLog(lines,"NOT",yytext);

	return NOT;

}
"=" {
	Util::appendToken("ASSIGNOP",yytext);
	Util::lexerLog(lines,"ASSIGNOP",yytext);

	return ASSIGNOP;
}

{ADDOP} {
	Util::appendToken("ADDOP",yytext);
	Util::lexerLog(lines,"ADDOP",yytext);

	SymbolInfo *s= new SymbolInfo(yytext,"ADDOP");
	yylval.Symbol =s;

	return ADDOP;


}
{INCOP}	{
	Util::appendToken("INCOP",yytext);
	Util::lexerLog(lines,"INCOP",yytext);

	SymbolInfo *s= new SymbolInfo(yytext,"INCOP");
	yylval.Symbol =s;

	return INCOP;
}
{DECOP}	{
	Util::appendToken("DECOP",yytext);
	Util::lexerLog(lines,"DECOP",yytext);

	SymbolInfo *s= new SymbolInfo(yytext,"DECOP");
	yylval.Symbol =s;

	return DECOP;
}

{MULOP}	{
	Util::appendToken("MULOP",yytext);
	Util::lexerLog(lines,"MULOP",yytext);

	SymbolInfo *s= new SymbolInfo(yytext,"MULOP");
	yylval.Symbol =s;

	return MULOP;
}
{RELOP}	{
	Util::appendToken("RELOP",yytext);
	Util::lexerLog(lines,"RELOP",yytext);

	SymbolInfo *s= new SymbolInfo(yytext,"RELOP");
	yylval.Symbol =s;

	return RELOP;
}
{LOGICOP} {
	Util::appendToken("LOGICOP",yytext);
	Util::lexerLog(lines,"LOGICOP",yytext);

	SymbolInfo *s= new SymbolInfo(yytext,"LOGICOP");
	yylval.Symbol =s;

	return LOGICOP;
}
{BITOP} {
	Util::appendToken("BITOP",yytext);
	Util::lexerLog(lines,"BITOP",yytext);

	SymbolInfo *s= new SymbolInfo(yytext,"BITOP");
	yylval.Symbol =s;

	return BITOP;
}

{IDENTIFIER} {
	Util::lexerLog(lines,"ID",yytext);
	Util::appendToken("ID",yytext);

	SymbolInfo *s= new SymbolInfo(yytext,"ID");
	yylval.Symbol =s;

	return ID;

}
{INVALID_IDENTIFIER} {
	Util::appendLogError(lines,"Invalid Suffix On Numeric Constant Or,Invalid Prefix on Identifier for Character Sequence "+string(yytext),LEXER);
	errors++;
}

. {
	//if it cant match any rule above,it will match this.
	Util::appendLogError(lines,"Unrecognized Character "+string(yytext),LEXER);
	errors++;
}


%%

const string removeSingleQuote(string s){
	if(s[1]!='\\'){
		if(s[1] == ' ') return " ";
		string r;
		r.push_back(s[1]);
		return r;
	}
	switch(s[2]){
			case 'a':
			 return "\a";

			case 'b':
			 return "\b";

			case 't':
			 return "\t";

			case 'n':
			 return "\n";

			case 'v':
			 return "\v";

			case 'f':
			 return "\f";

			case 'r':
			 return "\r";

			case '\"':
			 return "\"";

			case '\'':
			 return "\'";

			case '\\':
			 return "\\";

			case '0':
			 return "\0";
    }

}
const string processString(string s){
	string result;
	int len = s.size();
	for(int i=0;i<len;i++){
		if(s[i]=='\n')lines++;
		if(s[i]=='\\' and s[i+1]=='\n')
		continue;
		int state=0;
		if(s[i]=='\\'){
			if(s[i+1]=='n')
				result.push_back('\n');
			else if(s[i+1]=='t')
				result.push_back('\t');
			else if(s[i+1]=='a')
				result.push_back('\a');
			else if(s[i+1]=='f')
				result.push_back('\f');
			else if(s[i+1]=='r')
				result.push_back('\r');
			else if(s[i+1]=='v')
				result.push_back('\v');
			else if(s[i+1]=='b')
				result.push_back('\b');
			else if(s[i+1]=='\0')
				result.push_back('\0');
			else if(s[i+1]=='\\')
				result.push_back('\\');
			else if(s[i+1]=='\'')
				result.push_back('\'');
			else if(s[i+1]=='\"')
				result.push_back('\"');

		}
		else if(s[i]=='\n' )
			continue;
		else{
			state=1;
			result.push_back(s[i]);
		}
		if(state==0) i++;
	}
	return result;
}
/**End Of Routine Section**/
