/**Start Of Definition Section**/
option noyywrap //Options Section inside Definitions Section

/**Start Of C-Code Section Inside Definition Section**/
%{

#include "1605103_SymbolTable.h"
#include "y.tab.h"

extern YYSTYPE yylval;
extern SymbolTable st(10);
extern int lines=1,errors=0;
extern "C" int yylex();

const string removeSingleQuote(string s);
const string processString(string s);

extern FILE *error;
extern string currentid;
void yyerror(char *);

extern vector<SymbolInfo*>para_list;

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
INCOP "++"|"--"
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
	lexerLog(detectionLine,"COMMENT",processed);
}
{UNFINISHED_COMMENT} {
	appendLogError(lines,"Unfinished Comment " + processString(yytext));
	errors++;
}

{STRING} {
	int detectionLine = lines;
	string processed = processString(yytext);
	lexerLog(detectionLine,"STRING",string(yytext));
	appendToken("STRING",processed);

	SymbolInfo *s= new  SymbolInfo(processed, "STRING");
	yylval.symbolinfo =s;

	return STRING;
}
{UNFINISHED_STRING} {
	appendLogError(lines,"Unfinished String " +string(yytext));
	errors++;
}

{CONST_CHAR}|{CONST_ESCAPE_CHAR} {
	lexerLog(lines,"CONST_CHAR",yytext);
	string s = removeSingleQuote(yytext);
	appendToken("CONST_CHAR",s);

	SymbolInfo *sm= new  SymbolInfo(yytext, "CONST_CHAR");
	yylval.symbolinfo= sm;

	return CONST_CHAR;
}
{MULTI_CHAR_CONSTANT} {
	appendLogError(lines,"Multi Character Constant " + string(yytext));
	errors++;
}
{UNFINISHED_CHAR} {
	appendLogError(lines,"Unfinished Character "+string(yytext));
	errors++;
}
{INVALID_CHAR} {
	if(string(yytext)=="''")appendLogError(lines,"Empty Character Constant "+string(yytext));
	else appendLogError(lines,"Invalid Character "+string(yytext));
	errors++;
}

{INTEGER} {
	lexerLog(lines,"CONST_INT",yytext);
	appendToken("CONST_INT",yytext);

	SymbolInfo *s= new  SymbolInfo(yytext, "CONST_INT");
	yylval.symbolinfo= s;
	
	return CONST_INT;
}
{FLOAT1}|{FLOAT2} {
	lexerLog(lines,"CONST_FLOAT",yytext);
	appendToken("CONST_FLOAT",yytext);
	
	SymbolInfo *s= new  SymbolInfo(yytext, "CONST_FLOAT");
	yylval.symbolinfo = s;
	
	return CONST_FLOAT;
}
{TOO_MANY_DECIMAL_POINTS} {
	appendLogError(lines,"Too Many Decimal Points! "+string(yytext));
	errors++;

}
{ILL_FORMED_NUMBER} {
	appendLogError(lines,"Ill formed number! "+string(yytext));
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
	appendToken("SEMICOLON",yytext);
	lexerLog(lines,"SEMICOLON",yytext);

	return SEMICOLON;
}

"," {
	appendToken("COMMA",yytext);
	lexerLog(lines,"COMMA",yytext);

	return COMMA;
}
"(" {
	appendToken("LPAREN",yytext);
	lexerLog(lines,"LPAREN",yytext);

	return LPAREN;
}
")" {
	appendToken("RPAREN",yytext);
	lexerLog(lines,"RPAREN",yytext);

	return RPAREN;
}
"{" {
	appendToken("LCURL",yytext);
	lexerLog(lines,"LCURL",yytext);

	return LCURL;
}
"}" {
	appendToken("RCURL",yytext);
	lexerLog(lines,"RCURL",yytext);

	return RCURL;
}
"[" {
	appendToken("LTHIRD",yytext);
	lexerLog(lines,"LTHIRD",yytext);

	return RTHIRD;
}
"]" {
	appendToken("RTHIRD",yytext);
	lexerLog(lines,"RTHIRD",yytext);

	return LTHIRD;
}
"!" {
	appendToken("NOT",yytext);
	lexerLog(lines,"NOT",yytext);

	return NOT;

}
"=" {
	appendToken("ASSIGNOP",yytext);
	lexerLog(lines,"ASSIGNOP",yytext);

	return ASSIGNOP;
}

{ADDOP} {
	appendToken("ADDOP",yytext);
	lexerLog(lines,"ADDOP",yytext);
	
	SymbolInfo *s= new SymbolInfo(yytext,"ADDOP");
	yylval.symbolinfo =s;

	return ADDOP;
	

}
{INCOP}	{
	appendToken("INCOP",yytext);
	lexerLog(lines,"INCOP",yytext);
	
	SymbolInfo *s= new SymbolInfo(yytext,"INCOP");
	yylval.symbolinfo =s;

	return INCOP;
}
{MULOP}	{
	appendToken("MULOP",yytext);
	lexerLog(lines,"MULOP",yytext);

	SymbolInfo *s= new SymbolInfo(yytext,"MULOP");
	yylval.symbolinfo =s;

	return MULOP;
}
{RELOP}	{
	appendToken("RELOP",yytext);
	lexerLog(lines,"RELOP",yytext);
	
	SymbolInfo *s= new SymbolInfo(yytext,"RELOP");
	yylval.symbolinfo =s;

	return RELOP;
}
{LOGICOP} {
	appendToken("LOGICOP",yytext);
	lexerLog(lines,"LOGICOP",yytext);

	SymbolInfo *s= new SymbolInfo(yytext,"LOGICOP");
	yylval.symbolinfo =s;

	return LOGICOP;
}
{BITOP} {
	appendToken("BITOP",yytext);
	lexerLog(lines,"BITOP",yytext);
	
	SymbolInfo *s= new SymbolInfo(yytext,"BITOP");
	yylval.symbolinfo =s;

	return BITOP;
}

{IDENTIFIER} {
	lexerLog(lines,"ID",yytext);
	appendToken("ID",yytext);

	SymbolInfo *s= new SymbolInfo(yytext,"ID");
	yylval.symbolinfo =s;
	
	return ID;

}
{INVALID_IDENTIFIER} {
	appendLogError(lines,"Invalid Suffix On Numeric Constant Or,Invalid Prefix on Identifier for Character Sequence "+string(yytext));
	errors++;
}

. {
	//if it cant match any rule above,it will match this.
	appendLogError(lines,"Unrecognized Character "+string(yytext));
}


%%
/** End of Rules Section**/
/**start of routine Section**/

// int main(int argc,char *argv[]){

// 	if(argc!=2){
// 		printf("Invalid Input\n");
// 		return 0;
// 	}
// 	clearFiles();
// 	FILE *inputFile=fopen(argv[1],"r");
// 	if(inputFile==NULL){
// 		printf("Cant open file\n");
// 		return 0;
// 	}

// 	yyin= inputFile;

// 	yylex(); //start scanning

// 	st.printAllScopeTables();
// 	lexerLog("\nTotal Lines: "+to_string(lines)+" Total Error: "+to_string(errors));

// 	fclose(yyin);
// 	return 0;
// }

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
