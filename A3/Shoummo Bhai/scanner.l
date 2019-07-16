%{
#include<stdio.h>
#include<stdlib.h>
#include "1505069_SymbolTable.h"
#include "y.tab.h"

extern YYSTYPE yylval;
extern SymbolTable *table;
extern FILE *error;
extern string currentid;
void yyerror(char *);

extern int line_count;
extern int error_count;
extern vector<SymbolInfo*>para_list;

pair<string,int> ModifyString(string s,int line);
char ModifyChar(string s);

%}

WHITESPACE [ \t\f\r\v]+ 

LETTER [a-zA-Z]

DIGIT [0-9]

CHAR [ -~]{-}['\\]

NEWLINE [\n]

%%
{WHITESPACE}    {}

{NEWLINE}       { 
			line_count++;
		}

"if"		{
			 return IF;
		}
"else"		{
			return ELSE;
		}
"for"		{
			return FOR;
		}
"while"		{
			return WHILE;
		}
"do"		{
			return DO;
		}
"break"		{
			return BREAK;
		}
"int"		{ SymbolInfo *s= new  SymbolInfo(yytext, "INT");
				yylval.symbolinfo= s;
			return INT;
		}
"char"		{
			return CHAR;
		}
"float"		{ SymbolInfo *s= new  SymbolInfo(yytext, "FLOAT");
				yylval.symbolinfo= s;
			return FLOAT;
		}
"double"		{
			return DOUBLE;
		}
"void"		{ SymbolInfo *s= new  SymbolInfo(yytext, "VOID");
				yylval.symbolinfo= s;
			return VOID;
		}
"return"		{
			return RETURN;
		}
"switch"		{
			return SWITCH;
		}
"case"		{
			return CASE;
		}
"default"		{
			return DEFAULT;
		}
"continue"	{
			return CONTINUE;
		}

"println"	{
			return PRINTLN;
		}


{DIGIT}+ 	{
				SymbolInfo *s= new  SymbolInfo(yytext, "CONST_INT");
				yylval.symbolinfo= s;
				return CONST_INT;

		}

{DIGIT}*\.{DIGIT}+([E][-+]?{DIGIT}+)? |
{DIGIT}+([E][-+]?{DIGIT}+)? 		{
						SymbolInfo *s= new  SymbolInfo(yytext, "CONST_FLOAT");
						yylval.symbolinfo = s;
						return CONST_FLOAT;
					}

{DIGIT}*([\.]+{DIGIT}*)+(E[\.]*[+-]?[\.]*{DIGIT}*)?[\.]*{DIGIT}*	{
										fprintf(error,"Error at Line No.%d:  Too many decimal point %s \n",line_count,yytext);
										error_count++;

									}
({DIGIT}+|{DIGIT}*\.{DIGIT}+([E][-+]?{DIGIT}+)?|{DIGIT}+([E][-+]?{DIGIT}+)?)[E]*({DIGIT}+|{DIGIT}*\.{DIGIT}+([E][-+]?{DIGIT}+)?|{DIGIT}+([E][-+]?{DIGIT}+)?)*							{						
								fprintf(error,"Error at Line No.%d:  Ill formed number %s \n",line_count,yytext);
								error_count++;

							}

\'({CHAR}|\\['"?\\abfnrtv])\'			{
						//char x=ModifyChar(yytext);
						SymbolInfo *s= new  SymbolInfo(yytext, "CONST_CHAR");
						yylval.symbolinfo = s;
						return CONST_CHAR;
						
						}
\'({CHAR}|[\\])*[^'\n]?				{
						
							fprintf(error,"Error at Line No.%d: Unfinished Character Sequence found %s \n",line_count,yytext);
							error_count++;
						}

\'({CHAR}|[\\])*\'			{
						
						fprintf(error,"Error at Line No.%d: Invalid Character Sequence found %s \n",line_count,yytext);
						error_count++;
						

					}	





"+"|"-"		{
			SymbolInfo *s= new SymbolInfo(yytext,"ADDOP");
			yylval.symbolinfo =s;
			return ADDOP;

			
		}
"*"|"/"|"%"	{
			SymbolInfo *s= new SymbolInfo(yytext,"MUOLP");
			yylval.symbolinfo =s;
			return MULOP;
			
		}

"++"	{
			
			return INCOP;
		}
"--"	{
			
			return DECOP;
		}
"<"|"<="|">"|">="|"=="|"!="	{
			SymbolInfo *s= new SymbolInfo(yytext,"REOP");
			yylval.symbolinfo =s;
			return RELOP;
				}
"="		{
			
			return ASSIGNOP;
		}
"&&"|"||"	{
			SymbolInfo *s= new SymbolInfo(yytext,"LOGICOP");
			yylval.symbolinfo =s;
			return LOGICOP;
		}
"&"|"|"|"^"|"<<"|">>"		{
			SymbolInfo *s= new SymbolInfo(yytext,"BITOP");
			yylval.symbolinfo =s;
			return BITOP;
				}
"!"		{
			
			return NOT;
		}
"("		{
		
			return LPAREN;
		}
")"		{
			
			return RPAREN;
		}
"{"		{
			
			
			return LCURL;
		}
"}"		{

			return RCURL;
		}
"["		{
			
			return LTHIRD;
		}
"]"		{
			
			return RTHIRD;
		}
","		{
		
			return COMMA;
		}
";"		{
		
			return SEMICOLON;
		}

\"([^\"\n]|(\\[\n])|(\"))*\" 			{	
							
							pair<string,int> modify=ModifyString(yytext,line_count);
							line_count=modify.second;
							SymbolInfo *s= new  SymbolInfo(modify.first, "STRING");
							yylval.symbolinfo =s;
							return STRING;
							
						
			}
\"([^\"\n]|(\\[\n]))* 				{
							pair<string,int> modify=ModifyString(yytext,line_count);
							fprintf(error,"Error at Line No.%d:  Unfinished String found %s \n",line_count,yytext);
							error_count++;
							line_count=modify.second;

						}



({LETTER}|_)({LETTER}|{DIGIT}|_)*		        {
								/*SymbolInfo *s= table->lookup(yytext);
								if(s==NULL)
								{					
									s= new SymbolInfo(yytext,"ID");
									yylval.symbolinfo =s;
								}*/
								SymbolInfo *s= new SymbolInfo(yytext,"ID");
								yylval.symbolinfo =s;
								return ID;
							}

{DIGIT}({LETTER}|{DIGIT}|_)*				{
								fprintf(error,"Error at Line No.%d:  Invalid Identifier %s \n",line_count,yytext);
								error_count++;

							}

"//"((.*\\\n.*)|(.*))* 	{	 pair<string,int> modify=ModifyString(yytext,line_count);
					
						/// fprintf(error,"Line no %d: TOKEN <COMMENT> Lexeme %s found\n",line_count,yytext);
						 line_count=modify.second;
						

					}
"/*"([^*]|("*"[^/]))*"*/"		{
						pair<string,int> modify=ModifyString(yytext,line_count);
						//fprintf(error,"Line no %d: TOKEN <COMMENT> Lexeme %s found\n",line_count,yytext);
						line_count=modify.second;
						
						
					}
"/*"([^*]|("*"[^/]))*[^"*/"]		{
								pair<string,int> modify=ModifyString(yytext,line_count);
								fprintf(error,"Error at Line No.%d:  Unfinished Comment %s \n",line_count,yytext);
								line_count=modify.second;
								error_count++;

					}
.					{
								fprintf(error,"Error at Line No.%d:  Unrecognized character %s \n",line_count,yytext);
								error_count++;

					}

%%

int yywrap(void)
{
	return 1;
}

char ModifyChar(string s){
char x=s[1];

	if(s[1]=='\\'){
		if (s[2]=='n'){
			return '\n';
		}
if (s[2]=='\''){
			return '\'';
		}
if (s[2]=='\"'){
			return '\"';
		}
if (s[2]=='\\'){
			return '\\';
		}
if (s[2]=='a'){
			return 'a';
		}
if (s[2]=='b'){
			return 'b';
		}
if (s[2]=='f'){
			return '\f';
		}
if (s[2]=='r'){
			return '\r';
		}
if (s[2]=='t'){
			return '\t';
		}
if (s[2]=='v'){
			return '\v';
		}

	}
return x;

}

pair<string,int> ModifyString(string s,int line){
	string x;
	//cout<<line<<endl;
	for(int i=0;i<s.size();i++){
		if(s[i]=='\n')line++;
		if(s[i]=='\\' and s[i+1]=='\n') 
		continue;
		int ok=0;
		if(s[i]=='\\' and s[i+1]=='n') 
			x.push_back('\n');
		else if(s[i]=='\\' and s[i+1]=='t') 
			x.push_back('\t');
		else if(s[i]=='\\' and s[i+1]=='\\') 
			x.push_back('\\');
		else if(s[i]=='\\' and s[i+1]=='\'') 
			x.push_back('\'');
		else if(s[i]=='\\' and s[i+1]=='\"') 
			x.push_back('\"');
		else if(s[i]=='\\' and s[i+1]=='a') 
			x.push_back('\a');
		else if(s[i]=='\\' and s[i+1]=='f') 
			x.push_back('\f');
		else if(s[i]=='\\' and s[i+1]=='r') 
			x.push_back('\r');
		else if(s[i]=='\\' and s[i+1]=='v') 
			x.push_back('\v');
		else if(s[i]=='\\' and s[i+1]=='b') 
			x.push_back('\b');
		else if(s[i]=='\\' and s[i+1]=='\0') 
			x.push_back('\0');
		else if(s[i]=='\n' ) 
			continue;
		else{
			ok=1;
			x.push_back(s[i]);
		}
		if(ok==0) i++;
	}
	//cout<<x<<endl;

	//cout<<line<<endl;


	return make_pair(x,line);
}


