/**Start Of Definition Section**/
option noyywrap //Options Section inside Definitions Section

/**Start Of C-Code Section Inside Definition Section**/
%{

#include "1605103_SymbolTable.h"

SymbolTable st(10);
int lines=0,errors=0;
extern "C" int yylex();
void appendFile(const string & data,const string & file_name);

%}
/**End Of C-Code Section Inside Definition Section ***/

/**Start Of Pattern-Definition Section Inside Definition Section**/

WHITESPACE  (\t|\f|\r|\v)+
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

/**End Of Pattern-Definition Section Inside Definition Section**/
/**End Of Definition Section**/

/** Start of Rules Section**/
%%

{WHITESPACE} {}

{NEWLINE} {lines++;}

{INTEGER} {
	appendLog(lines,"CONST_INT",yytext);
	if(st.insert(SymbolInfo(yytext,"CONST_INT"))){
		appendToken("CONST_INT",yytext);
	}
	else appendLog("Symbol : "+string(yytext)+" already exists!");
}

{FLOAT1}|{FLOAT2} {
	appendLog(lines,"CONST_FLOAT",yytext);
	if(st.insert(SymbolInfo(yytext,"CONST_FLOAT"))){
		appendToken("CONST_FLOAT",yytext);
	}
	else appendLog("Symbol : "+string(yytext)+" already exists!");
}
{TOO_MANY_DECIMAL_POINTS} {
	appendLogError(lines,"Too Many Decimal Points! "+string(yytext));
	errors++;

}
{ILL_FORMED_NUMBER} {
	appendLogError(lines,"Ill formed number! "+string(yytext));
	errors++;
}



"int"		{
			appendToken("INT");
			appendLog(lines,"INT",yytext);
}
"char"		{
			appendToken("CHAR");
			appendLog(lines,"CHAR",yytext);
}
"float"		{
			appendToken("FLOAT");
			appendLog(lines,"FLOAT",yytext);
}
"double"		{
			appendToken("DOUBLE");
			appendLog(lines,"DOUBLE",yytext);
}
"void"		{
			appendToken("VOID");
			appendLog(lines,"VOID",yytext);
}


"if"		{
			appendToken("IF");
			appendLog(lines,"IF",yytext);

}
"else"		{
			appendToken("ELSE");
			appendLog(lines,"ELSE",yytext);
}
"do"		{
			appendToken("DO");
			appendLog(lines,"DO",yytext);
}
"while"		{
			appendToken("WHILE");
			appendLog(lines,"WHILE",yytext);
}

"for"		{
			appendToken("FOR");
			appendLog(lines,"FOR",yytext);
}

"break"		{
			appendToken("BREAK");
			appendLog(lines,"BREAK",yytext);
}
"continue"	{
			appendToken("CONTINUE");
			appendLog(lines,"CONTINUE",yytext);
}

"return"		{
			appendToken("RETURN");
			appendLog(lines,"RETURN",yytext);
}
"switch"		{
			appendToken("SWITCH");
			appendLog(lines,"SWITCH",yytext);
}
"case"		{
			appendToken("CASE");
			appendLog(lines,"CASE",yytext);
		}
"default"		{
			appendToken("DEFAULT");
			appendLog(lines,"DEFAULT",yytext);
}
";"		{
			appendToken("SEMICOLON",yytext);
			appendLog(lines,"SEMICOLON",yytext);
			//st.insert(SymbolInfo(yytext,"SEMICOLON"));
}

","		{
			appendToken("COMMA",yytext);
			appendLog(lines,"COMMA",yytext);
			//st.insert(SymbolInfo(yytext,"COMMA"));
}


"("		{
			appendToken("LPAREN",yytext);
			appendLog(lines,"LPAREN",yytext);
			//st.insert(SymbolInfo(yytext,"LPAREN"));
}
")"		{
			appendToken("RPAREN",yytext);
			appendLog(lines,"RPAREN",yytext);
			//st.insert(SymbolInfo(yytext,"RPAREN"));
}
"{"		{
			appendToken("LCURL",yytext);
			appendLog(lines,"LCURL",yytext);
			//st.insert(SymbolInfo(yytext,"LCURL"));
}
"}"		{
			appendToken("RCURL",yytext);
			appendLog(lines,"RCURL",yytext);

			//st.insert(SymbolInfo(yytext,"RCURL"));
}
"["		{
			appendToken("LTHIRD",yytext);
			appendLog(lines,"LTHIRD",yytext);
			//st.insert(SymbolInfo(yytext,"LTHIRD"));
}
"]"		{
			appendToken("RTHIRD",yytext);
			appendLog(lines,"RTHIRD",yytext);
			//st.insert(SymbolInfo(yytext,"RTHIRD"));
}
"!"		{
			appendToken("NOT",yytext);
			appendLog(lines,"NOT",yytext);
			//st.insert(SymbolInfo(yytext,"NOT"));

}
"+"|"-"		{
			appendToken("ADDOP",yytext);
			appendLog(lines,"ADDOP",yytext);
			//st.insert(SymbolInfo(yytext,"ADDOP"));

}

"++"|"--"	{
			appendToken("INCOP",yytext);
			appendLog(lines,"INCOP",yytext);
			//st.insert(SymbolInfo(yytext,"INCOP"));
}
"%"|"*"|"/"	{
			appendToken("MULOP",yytext);
			appendLog(lines,"MULOP",yytext);
			//st.insert(yytext,"MULOP");
}

"<"|">"|">="|"<="|"!="|"=="	{
					appendToken("RELOP",yytext);
					appendLog(lines,"RELOP",yytext);
					//st.insert(yytext,"RELOP");
}
"="		{
			appendToken("ASSIGNOP",yytext);
			appendLog(lines,"ASSIGNOP",yytext);
			//st.insert(yytext,"ASSIGNOP");
}
"&&"|"||"	{
			appendToken("LOGICOP",yytext);
			appendLog(lines,"LOGICOP",yytext);
			//st.insert(yytext,"LOGICOP");
}
"<<"|">>"|"^"|"&"|"|"		{
					appendToken("BITOP",yytext);
					appendLog(lines,"BITOP",yytext);
					//st.insert(yytext,"BITOP");
}
{IDENTIFIER} {
	appendLog(lines,"ID",yytext);
	if(st.insert(SymbolInfo(yytext,"ID"))){
		appendToken("ID",yytext);
	}
	else appendLog("Symbol: "+string(yytext)+" Already Exits");

}
{INVALID_IDENTIFIER} {
	appendLogError(lines,"Invalid Suffix On Numeric Constant Or,Invalid Prefix on Identifier for Character Sequence"+string(yytext));
	errors++;

}




%%
/** End of Rules Section**/
/**start of routine Section**/

int main(int argc,char *argv[]){


	if(argc!=2){
		printf("Invalid Input\n");
		return 0;
	}
	clearFiles();
	FILE *inputFile=fopen(argv[1],"r");
	if(inputFile==NULL){
		printf("Cant open file\n");
		return 0;
	}

	yyin= inputFile;

	yylex(); //start scanning

	fclose(yyin);
	return 0;
}

/**End Of Routine Section**/
