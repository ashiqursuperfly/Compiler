/**Start Of Definition Section**/
option noyywrap //Options Section inside Definitions Section

/**Start Of C-Code Section Inside Definition Section**/
%{

#include "1605103_SymbolTable.h"
SymbolTable st(10);
int lines=1,errors=0;
extern "C" int yylex();

const string removeSingleQuote(string s);
const string processString(string s);

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

STRING \"([^\"\n]|(\\[\n])|(\"))*\"
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

{DOUBLE_SLASH_COMMENT} {
	int detectionLine = lines;
	string processed = processString(yytext);
	appendLog(detectionLine,"COMMENT",processed);
}
{BLOCK_COMMENT} {
	int detectionLine = lines;
	string processed = processString(yytext);
	appendLog(detectionLine,"COMMENT",processed);
}
{UNFINISHED_COMMENT} {
	appendLogError(lines,"Unfinished Comment " + processString(yytext));
	errors++;
}

{STRING} {
	int detectionLine = lines;
	string processed = processString(yytext);
	appendLog(detectionLine,"STRING",processed);
	appendToken("STRING",processed);
}
{UNFINISHED_STRING} {
	appendLogError(lines,"Unfinished String " + processString(yytext));
	errors++;
}

{CONST_CHAR} {
	appendLog(lines,"CONST_CHAR",yytext);
	string s = removeSingleQuote(yytext);
	appendToken("CONST_CHAR",s);
	if(!st.insert(SymbolInfo(yytext,"CONST_CHAR")))
	appendLog("Line:"+to_string(lines)+" Symbol Already Exists!");
}
{CONST_ESCAPE_CHAR} {
	appendLog(lines,"CONST_CHAR",yytext);
	string s = removeSingleQuote(yytext);
	appendToken("CONST_CHAR",s);
	if(!st.insert(SymbolInfo(yytext,"CONST_CHAR")))
	appendLog("Line:"+to_string(lines)+" Symbol Already Exists!");
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
	appendLog(lines,"CONST_INT",yytext);
	appendToken("CONST_INT",yytext);
	if(!st.insert(SymbolInfo(yytext,"CONST_INT")))
	appendLog("Line:"+to_string(lines)+" Symbol " + string(yytext) +" Already Exists");
}
{FLOAT1}|{FLOAT2} {
	appendLog(lines,"CONST_FLOAT",yytext);
	appendToken("CONST_FLOAT",yytext);
	if(!st.insert(SymbolInfo(yytext,"CONST_FLOAT")))
	appendLog("Line:"+to_string(lines)+" Symbol " + string(yytext) +" Already Exists");
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
	appendToken("INT");
	appendLog(lines,"INT",yytext);
}
"char" {
	appendToken("CHAR");
	appendLog(lines,"CHAR",yytext);
}
"float"	{
	appendToken("FLOAT");
	appendLog(lines,"FLOAT",yytext);
}
"double" {
	appendToken("DOUBLE");
	appendLog(lines,"DOUBLE",yytext);
}
"void" {
	appendToken("VOID");
	appendLog(lines,"VOID",yytext);
}
"if" {
	appendToken("IF");
	appendLog(lines,"IF",yytext);

}
"else" {
	appendToken("ELSE");
	appendLog(lines,"ELSE",yytext);
}
"do" {
	appendToken("DO");
	appendLog(lines,"DO",yytext);
}
"while"	{
	appendToken("WHILE");
	appendLog(lines,"WHILE",yytext);
}

"for" {
	appendToken("FOR");
	appendLog(lines,"FOR",yytext);
}
"break" {
	appendToken("BREAK");
	appendLog(lines,"BREAK",yytext);
}
"continue" {
	appendToken("CONTINUE");
	appendLog(lines,"CONTINUE",yytext);
}

"return" {
	appendToken("RETURN");
	appendLog(lines,"RETURN",yytext);
}
"switch" {
	appendToken("SWITCH");
	appendLog(lines,"SWITCH",yytext);
}
"case" {
	appendToken("CASE");
	appendLog(lines,"CASE",yytext);
		}
"default" {
	appendToken("DEFAULT");
	appendLog(lines,"DEFAULT",yytext);
}

";" {
	appendToken("SEMICOLON",yytext);
	appendLog(lines,"SEMICOLON",yytext);
	//if(!st.insert(SymbolInfo(yytext,"SEMICOLON")))
	//	appendLog("Line:"+to_string(lines)+" Symbol " + string(yytext) +" Already Exists");
}

"," {
	appendToken("COMMA",yytext);
	appendLog(lines,"COMMA",yytext);
	//if(!st.insert(SymbolInfo(yytext,"COMMA")))
	//	appendLog("Line:"+to_string(lines)+" Symbol " + string(yytext) +" Already Exists");
}
"(" {
	appendToken("LPAREN",yytext);
	appendLog(lines,"LPAREN",yytext);
	//if(!st.insert(SymbolInfo(yytext,"LPAREN")))
	//	appendLog("Line:"+to_string(lines)+" Symbol " + string(yytext) +" Already Exists");
}
")" {
	appendToken("RPAREN",yytext);
	appendLog(lines,"RPAREN",yytext);
	//if(!st.insert(SymbolInfo(yytext,"RPAREN")))
	//	appendLog("Line:"+to_string(lines)+" Symbol " + string(yytext) +" Already Exists");
}
"{" {
	appendToken("LCURL",yytext);
	appendLog(lines,"LCURL",yytext);
	//if(!st.insert(SymbolInfo(yytext,"LCURL")))
	//	appendLog("Line:"+to_string(lines)+" Symbol " + string(yytext) +" Already Exists");
}
"}" {
	appendToken("RCURL",yytext);
	appendLog(lines,"RCURL",yytext);
	//if(!st.insert(SymbolInfo(yytext,"RCURL")))
	//	appendLog("Line:"+to_string(lines)+" Symbol " + string(yytext) +" Already Exists");
}
"[" {
	appendToken("LTHIRD",yytext);
	appendLog(lines,"LTHIRD",yytext);
	//if(!st.insert(SymbolInfo(yytext,"LTHIRD")))
	//	appendLog("Line:"+to_string(lines)+" Symbol " + string(yytext) +" Already Exists");
}
"]" {
	appendToken("RTHIRD",yytext);
	appendLog(lines,"RTHIRD",yytext);
	//if(!st.insert(SymbolInfo(yytext,"RTHIRD")))
	//	appendLog("Line:"+to_string(lines)+" Symbol " + string(yytext) +" Already Exists");
}
"!" {
	appendToken("NOT",yytext);
	appendLog(lines,"NOT",yytext);
	//if(!st.insert(SymbolInfo(yytext,"NOT")))
	//	appendLog("Line:"+to_string(lines)+" Symbol " + string(yytext) +" Already Exists");

}
"=" {
	appendToken("ASSIGNOP",yytext);
	appendLog(lines,"ASSIGNOP",yytext);
	//if(!st.insert(SymbolInfo(yytext,"ASSIGNOP")))
	//	appendLog("Line:"+to_string(lines)+" Symbol " + string(yytext) +" Already Exists");
}

{ADDOP} {
	appendToken("ADDOP",yytext);
	appendLog(lines,"ADDOP",yytext);
	//if(!st.insert(SymbolInfo(yytext,"ADDOP")))
	//	appendLog("Line:"+to_string(lines)+" Symbol " + string(yytext) +" Already Exists");

}
{INCOP}	{
	appendToken("INCOP",yytext);
	appendLog(lines,"INCOP",yytext);
	//if(!st.insert(SymbolInfo(yytext,"INCOP")))
	//	appendLog("Line:"+to_string(lines)+" Symbol " + string(yytext) +" Already Exists");
}
{MULOP}	{
	appendToken("MULOP",yytext);
	appendLog(lines,"MULOP",yytext);
	//if(!st.insert(SymbolInfo(yytext,"MULOP")))
	//	appendLog("Line:"+to_string(lines)+" Symbol " + string(yytext) +" Already Exists");
}

{RELOP}	{
	appendToken("RELOP",yytext);
	appendLog(lines,"RELOP",yytext);
	//if(!st.insert(SymbolInfo(yytext,"RELOP")))
	//  appendLog("Line:"+to_string(lines)+" Symbol " + string(yytext) +" Already Exists");
}
{LOGICOP} {
	appendToken("LOGICOP",yytext);
	appendLog(lines,"LOGICOP",yytext);
	//if(!st.insert(SymbolInfo(yytext,"LOGICOP")))
	//	appendLog("Line:"+to_string(lines)+" Symbol " + string(yytext) +" Already Exists");
}
{BITOP} {
	appendToken("BITOP",yytext);
	appendLog(lines,"BITOP",yytext);
	//if(!st.insert(SymbolInfo(yytext,"BITOP")))
	//	appendLog("Line:"+to_string(lines)+" Symbol " + string(yytext) +" Already Exists");
}

{IDENTIFIER} {
	appendLog(lines,"ID",yytext);
	appendToken("ID",yytext);
	if(!st.insert(SymbolInfo(yytext,"ID")))
		appendLog("Line:"+to_string(lines)+" Symbol " + string(yytext) +" Already Exists");
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

	st.printAllScopeTables();
	appendLog("\nTotal Lines: "+to_string(lines)+" Total Error: "+to_string(errors));

	fclose(yyin);
	return 0;
}

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
			else if(s[i+1]=='\\')
				result.push_back('\\');
			else if(s[i+1]=='\'')
				result.push_back('\'');
			else if(s[i+1]=='\"')
				result.push_back('\"');
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
