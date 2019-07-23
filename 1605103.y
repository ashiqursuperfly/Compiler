%{
#include<iostream>
#include "headers/1605103_SymbolTable.h"

//#define Util::appendLogError Util::appendLogError
//#define LOG Util::parserLog
#define TOKEN new SymbolInfo()


using namespace std;
int yyparse(void);
int yylex(void);

int lines=1,errors=0;
FILE *fp;
extern FILE *yyin;

bool DEBUG = false;
bool isParsingSuccessful = true;

SymbolTable *symbolTable = new SymbolTable(100);
vector<pair<string,int>> possiblyUndefinedFunctions;
vector<SymbolInfo*>paramList,declarationList,argList;

void yyerror(const char *s){
	errors++;
	cerr<<errors<<":"<<s<<" at Line:"<<lines<<endl;
	
	//isParsingSuccessful = false;
}

%}

%define parse.error verbose
%define parse.lac full
%token IF ELSE FOR WHILE DO BREAK
%token INT FLOAT CHAR DOUBLE VOID CONST_INT CONST_FLOAT CONST_CHAR
%token RETURN SWITCH CASE DEFAULT CONTINUE STRING ID PRINTLN
%token LPAREN RPAREN LCURL RCURL LTHIRD RTHIRD COMMA SEMICOLON ADDOP MULOP INCOP RELOP ASSIGNOP LOGICOP BITOP NOT DECOP 

%left RELOP LOGICOP BITOP 
%left ADDOP 
%left MULOP

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%union{
	SymbolInfo* Symbol;
}

%type <s>start

%%
//@DONE
start: program {	}
	;

//@DONE2
program: program unit {
		
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"program : program-unit");
		Util::parserLog($<Symbol>1->getName()+" "+$<Symbol>2->getName()); 
		
		$<Symbol>$->setName($<Symbol>1->getName()+$<Symbol>2->getName());
	}

	| unit {

		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"program : unit");
		Util::parserLog($<Symbol>1->getName()+'\n');

		$<Symbol>$->setName($<Symbol>1->getName());
	}
	
	;


//@DONE2
unit: var_declaration {

		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"unit : var_declaration");
		Util::parserLog($<Symbol>1->getName()); 

		$<Symbol>$->setName($<Symbol>1->getName()+"\n");
	}
	
	| func_declaration {

		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"unit : func_declaration");
		Util::parserLog($<Symbol>1->getName()); 

		$<Symbol>$->setName($<Symbol>1->getName()+"\n");
	}
    
	| func_definition { 

		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"unit : func_definition");
		Util::parserLog($<Symbol>1->getName());

		$<Symbol>$->setName($<Symbol>1->getName()+"\n");
	}
	
	;

//@DONE2
func_declaration: type_specifier ID LPAREN parameter_list RPAREN SEMICOLON {

		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"func_declaration : type_specifier-ID-LPAREN-parameter_list-RPAREN-SEMICOLON");
		Util::parserLog($<Symbol>1->getName()+" "+$<Symbol>2->getName()+"("+$<Symbol>4->getName()+")");
		
		SymbolInfo *func = symbolTable->lookUp($<Symbol>2->getName());
		
		if(func != nullptr){
			int num = func->getFunction()->getParamCount();
			if(num == paramList.size()){
				vector<string>paramType = func->getFunction()->getAllParamTypes();
				for( int i=0;i < paramList.size(); i++){
					if(paramList[i]->getDeclarationType() != paramType[i]){
						
						string err = "Expected "+paramList[i]->getDeclarationType()+" Found "+ paramType[i] +"for "+to_string(i)+"th parameter";
						Util::appendLogError(lines,err,PARSER);
						yyerror(err.c_str());
						break;
					}
				}
				if(func->getFunction()->getReturnType()!=$<Symbol>1->getName()){
					string err = "Invalid Return Type.Expected "+func->getFunction()->getReturnType()+ " Found " + $<Symbol>1->getName();
					Util::appendLogError(lines,err,PARSER);
					yyerror(err.c_str());
					
				}
				paramList.clear();
			
			}else{
				string err = "Invalid number of parameters.Found:"+to_string(num)
				+" params, Expected:"+to_string(paramList.size())+" params";
				
				Util::appendLogError(lines,err,PARSER);
				yyerror(err.c_str());
			}	
		} 
		else{
			//TODO : Function
			symbolTable->insert($<Symbol>2->getName(),"ID","Function");
			func = symbolTable->lookUp($<Symbol>2->getName());
			func->setFunction();

			for(int i=0 ;i < paramList.size() ; i++){
				func->getFunction()->addParam(paramList[i]->getName(),paramList[i]->getDeclarationType());
				if(DEBUG)cout<<paramList[i]->getDeclarationType()<<endl;
			}
			paramList.clear();
			func->getFunction()->setReturnType($<Symbol>1->getName());			
		}

		$<Symbol>$->setName($<Symbol>1->getName()+" "+$<Symbol>2->getName()+"("+$<Symbol>4->getName()+");");

	}
	| type_specifier ID LPAREN parameter_list RPAREN error {
		string err = "Missing SEMICOLON";
		Util::appendLogError(lines,err,PARSER);
	}
	| type_specifier ID LPAREN RPAREN SEMICOLON {

			$<Symbol>$ = TOKEN;
			
			Util::parserLog(lines,"func_declaration : type_specifier-ID-LPAREN-RPAREN-SEMICOLON");
			Util::parserLog($<Symbol>1->getName()+" "+$<Symbol>2->getName()+"();");
			
			SymbolInfo *s=symbolTable->lookUp($<Symbol>2->getName());
			
			if(s != nullptr){
				//TODO : Function
				if(s->getFunction()->getParamCount()!=0){
					string err = "Invalid number of parameters! Expected 0 Found "+to_string(s->getFunction()->getParamCount());
					Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());

				}
				if(s->getFunction()->getReturnType()!=$<Symbol>1->getName()){
					string err = "Return Type Does not Match! Expected "+s->getFunction()->getReturnType()+ " Found " +$<Symbol>1->getName();
					Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());
				}

			}
			else{
				symbolTable->insert($<Symbol>2->getName(),"ID","Function");
				s=symbolTable->lookUp($<Symbol>2->getName());
				s->setFunction();
				s->getFunction()->setReturnType($<Symbol>1->getName());
			}
			$<Symbol>$->setName($<Symbol>1->getName()+" "+$<Symbol>2->getName()+"();");
	}
	|
	type_specifier ID LPAREN RPAREN error {
		string err = "Missing SEMICOLON";
		Util::appendLogError(lines,err,PARSER);
	}
	;

//@DONE2
func_definition: type_specifier ID LPAREN parameter_list RPAREN {
		
		$<Symbol>$ = TOKEN; 
		SymbolInfo *s = symbolTable->lookUp($<Symbol>2->getName()); 

		if(s != nullptr){ 
			if(s->getFunction()->isDefined()==0){
				int num = s->getFunction()->getParamCount();
				if(num != paramList.size()){
					string err = "Invalid number of parameters.";
					Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());
				} else {
					
					vector<string>paramType = s->getFunction()->getAllParamTypes();
					for(int i=0;i<paramList.size();i++){
						if(paramList[i]->getDeclarationType() != paramType[i]){
							string err = "Expected "+Util::trim(paramList[i]->getDeclarationType())
							+" Found "+Util::trim(paramType[i])+" for "+ to_string(i)+"th "+"Parameter";
							yyerror(err.c_str());
							Util::appendLogError(lines,err,PARSER);
							break;
						}
					}
					if(s->getFunction()->getReturnType() != $<Symbol>1->getName()){
						string err = "Return Invalid Types ! Expected "+s->getFunction()->getReturnType()+ " Found " + $<Symbol>1->getName();
						yyerror(err.c_str());
						Util::appendLogError(lines,err,PARSER);
					}	
				}
				s->getFunction()->setDefined();
			}
			else{
				string err = "Multiple definition of function "+$<Symbol>2->getName();
				yyerror(err.c_str());
				Util::appendLogError(lines,err,PARSER);
			}
		}
		else{ 
			
			if(DEBUG)cout<<paramList.size()<<" "<<lines<<endl;
			
			symbolTable->insert($<Symbol>2->getName(),"ID","Function");
			s = symbolTable->lookUp($<Symbol>2->getName());
			s->setFunction();
			s->getFunction()->setDefined();
			
			if(DEBUG)cout<<s->getFunction()->getParamCount()<<endl;
			
			for(int i=0;i<paramList.size();i++){
				s->getFunction()->addParam(paramList[i]->getName(),paramList[i]->getDeclarationType());
			}
			
			s->getFunction()->setReturnType($<Symbol>1->getName());
		}

	}
	compound_statement {
		Util::parserLog(lines,"func_definition : type_specifier-ID-LPAREN-parameter_list-RPAREN-compound_statement ");
		Util::parserLog($<Symbol>1->getName()+" "+$<Symbol>2->getName()+"("
		+$<Symbol>4->getName()+") "+ $<Symbol>7->getName());
		$<Symbol>$->setName($<Symbol>1->getName()+" "+$<Symbol>2->getName()+"("+$<Symbol>4->getName()+")"+$<Symbol>7->getName());
	}
	| type_specifier ID LPAREN RPAREN { 
		$<Symbol>$ = TOKEN;
		SymbolInfo *s = symbolTable->lookUp($<Symbol>2->getName());
		if(s == nullptr){
			symbolTable->insert($<Symbol>2->getName(),"ID","Function");
			s = symbolTable->lookUp($<Symbol>2->getName());
			s -> setFunction();
			s -> getFunction()->setReturnType($<Symbol>1->getName());
			s -> getFunction()->setDefined();
		}
		else if(s->getFunction()->isDefined()==0){

			if(s->getFunction()->getReturnType()!=$<Symbol>1->getName()){
				string err = "Invalid Return Type Expected :"+$<Symbol>1->getName()+" Found :"+s->getFunction()->getReturnType();
				yyerror(err.c_str());Util::appendLogError(lines,err,PARSER);
			}
			if(s->getFunction()->getParamCount()!=0){
				string err = "Invalid number of parameters ";
				Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());
			}
			
			s->getFunction()->setDefined();
		}
		else{
			string err = "Multiple Definition Of Function "+$<Symbol>2->getName();
			Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());
		}
											
		$<Symbol>1->setName($<Symbol>1->getName()+" "+$<Symbol>2->getName()+"()");
	} compound_statement {

		Util::parserLog(lines,"func_definition : type_specifier-ID-LPAREN-RPAREN-compound_statement");
		$<Symbol>$->setName($<Symbol>1->getName()+$<Symbol>6->getName());
		Util::parserLog($<Symbol>1->getName()+" "+$<Symbol>6->getName());
			
	}
	;




//@DONE2
parameter_list: parameter_list COMMA type_specifier ID {
		
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"parameter_list : parameter_list-COMMA-type_specifier-ID");
		Util::parserLog($<Symbol>1->getName()+","+$<Symbol>3->getName()+" "+$<Symbol>4->getName());
		
		paramList.push_back(new SymbolInfo($<Symbol>4->getName(),"ID",$<Symbol>3->getName()));
		$<Symbol>$->setName($<Symbol>1->getName()+","+$<Symbol>3->getName()+" "+$<Symbol>4->getName());
	}
	| parameter_list COMMA type_specifier {
		
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"parameter_list : parameter_list-COMMA-type_specifier");
		Util::parserLog($<Symbol>1->getName()+","+$<Symbol>3->getName());
		
		paramList.push_back(new SymbolInfo("","ID",$<Symbol>3->getName()));
		$<Symbol>$->setName($<Symbol>1->getName()+","+$<Symbol>3->getName());

	}
	| type_specifier ID {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"parameter_list : type_specifier-ID");
		Util::parserLog($<Symbol>1->getName()+" "+$<Symbol>2->getName());
		paramList.push_back(new SymbolInfo($<Symbol>2->getName(),"ID",$<Symbol>1->getName()));
		$<Symbol>$->setName($<Symbol>1->getName()+" "+$<Symbol>2->getName());
	}
	| type_specifier {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"parameter_list : type_specifier");
		Util::parserLog($<Symbol>1->getName());

		paramList.push_back(new SymbolInfo("","ID",$<Symbol>1->getName()));
		$<Symbol>$->setName($<Symbol>1->getName()+" ");
	}
	;


//@DONE2
compound_statement: LCURL {
	
	symbolTable->enterScope();
	for(int i=0;i<paramList.size();i++){
		symbolTable->insert(paramList[i]->getName(),"ID",paramList[i]->getDeclarationType());
	}
	
	paramList.clear();
	
	} statements RCURL {

		$<Symbol>$ = TOKEN;
		
		Util::parserLog(lines,"compound_statement : LCURL-statements-RCURL");
		Util::parserLog("{"+$<Symbol>3->getName()+"}");
		
		$<Symbol>$->setName("{\n"+$<Symbol>3->getName()+"\n}");
		
		symbolTable->printAllScopeTables();
		symbolTable->exitScope();
	
	}
	| LCURL RCURL {
		symbolTable->enterScope();
		for(int i=0;i<paramList.size();i++){
			symbolTable->insert(paramList[i]->getName(),"ID",paramList[i]->getDeclarationType());
		}	
		paramList.clear();
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"compound_statement : LCURL-RCURL");
		Util::parserLog("{}");
		$<Symbol>$->setName("{}");
		symbolTable->printAllScopeTables();
		symbolTable->exitScope();
	}
	;

//@DONE
var_declaration: type_specifier declarationList SEMICOLON {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"var_declaration : type_specifier-declarationList-SEMICOLON");
		Util::parserLog($<Symbol>1->getName()+" "+$<Symbol>2->getName()+";");
		if($<Symbol>1->getName()=="void "){ 
			string err = "Cannot Declare void Type";
			yyerror(err.c_str());Util::appendLogError(lines,err,PARSER);																
		}
		else{
			for(int i=0;i < declarationList.size() ; i++){
				if(symbolTable->lookUpLocal(declarationList[i]->getName()) != nullptr){
					string err = declarationList[i]->getName()+" defined multiple times";
					yyerror(err.c_str());Util::appendLogError(lines,err,PARSER);
					continue;
				}
				if(declarationList[i]->getType().size()!=3){
					symbolTable->insert(declarationList[i]->getName(),declarationList[i]->getType(),$<Symbol>1->getName());			
				} else{
					 // array type-specifier
					declarationList[i]->setType(declarationList[i]->getType().substr(0,declarationList[i]->getType().size () - 1));
					symbolTable->insert(declarationList[i]->getName(),declarationList[i]->getType(),$<Symbol>1->getName()+"array");		
				}
			}
		}
		declarationList.clear();
		$<Symbol>$->setName($<Symbol>1->getName()+" "+$<Symbol>2->getName()+";");
	}
	|
	type_specifier declarationList error {
		string err = "Missing SEMICOLON";
		Util::appendLogError(lines,err,PARSER);
	}
	;

//@DONE
type_specifier: INT {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"type_specifier : INT");
		Util::parserLog("int ");
		$<Symbol>$->setName("int ");
	}
	| FLOAT  {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"type_specifier : FLOAT");
		Util::parserLog("float ");
		$<Symbol>$->setName("float ");
	}
	| VOID  {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"type_specifier : VOID");
		Util::parserLog("void ");
		$<Symbol>$->setName("void ");
	}
	;


//@DONE
declarationList: declarationList COMMA ID {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"declarationList : declarationList-COMMA-ID");
		Util::parserLog($<Symbol>1->getName()+","+$<Symbol>3->getName());
		declarationList.push_back(new SymbolInfo($<Symbol>3->getName(),"ID"));
		$<Symbol>$->setName($<Symbol>1->getName()+","+$<Symbol>3->getName());
	}
	| declarationList COMMA ID LTHIRD CONST_INT RTHIRD {
		$<Symbol>$ = TOKEN;
		Util::parserLog($<Symbol>1->getName()+","+$<Symbol>3->getName()+"["+$<Symbol>5->getName()+"]");
		Util::parserLog(lines,"declarationList : declarationList-COMMA-ID-LTHIRD-CONST_INT-RTHIRD");
		
		declarationList.push_back(new SymbolInfo($<Symbol>3->getName(),"IDa")); //TODO : why IDa ?
		$<Symbol>$->setName($<Symbol>1->getName()+","+$<Symbol>3->getName()+"["+$<Symbol>5->getName()+"]");
	}
	| ID {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"declarationList : ID");
		Util::parserLog($<Symbol>1->getName());
		declarationList.push_back(new SymbolInfo($<Symbol>1->getName(),"ID"));
		$<Symbol>$->setName($<Symbol>1->getName());
	}
	| ID LTHIRD CONST_INT RTHIRD {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"declarationList : ID-LTHIRD-CONST_INT-RTHIRD");
		Util::parserLog($<Symbol>1->getName()+"["+$<Symbol>3->getName()+"]");
		declarationList.push_back(new SymbolInfo($<Symbol>1->getName(),"IDa"));
		$<Symbol>$->setName($<Symbol>1->getName()+"["+$<Symbol>3->getName()+"]");
	}
	
	;

//@DONE
statements: statement {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"statements : statement");
		Util::parserLog($<Symbol>1->getName()); 
		$<Symbol>$->setName($<Symbol>1->getName());
	}
	| statements statement {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"statements : statements-statement");
		Util::parserLog($<Symbol>1->getName()+" "+$<Symbol>2->getName()); 
		$<Symbol>$->setName($<Symbol>1->getName()+"\n"+$<Symbol>2->getName()); 
	}
	;

statement: var_declaration {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"statement : var_declaration");
		Util::parserLog($<Symbol>1->getName());
		$<Symbol>$->setName($<Symbol>1->getName()); 
	}
	| expression_statement {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"statement : expression_statement");
		Util::parserLog($<Symbol>1->getName()); 
		$<Symbol>$->setName($<Symbol>1->getName()); 
	}
	| compound_statement {
		$<Symbol>$ = TOKEN;
	
		Util::parserLog(lines,"statement : compound_statement");
		Util::parserLog($<Symbol>1->getName()); 
	
		$<Symbol>$->setName($<Symbol>1->getName()); 
	}
	| FOR LPAREN expression_statement expression_statement expression RPAREN statement {
		$<Symbol>$ = TOKEN;
	
		Util::parserLog(lines,"statement : FOR-LPAREN-expression_statement-expression_statement-expression-RPAREN-statement");
		Util::parserLog("for("+$<Symbol>3->getName()+" "+$<Symbol>4->getName()+" "+
	
		$<Symbol>5->getName()+")\n"+$<Symbol>7->getName());
		
		if($<Symbol>3->getDeclarationType()=="void "){
			string err = "Invalid Types! Variable Cannot Be Declared void ";
			Util::appendLogError(lines,err,PARSER);
			yyerror(err.c_str());
		}
		$<Symbol>$->setName("for("+$<Symbol>3->getName()+$<Symbol>4->getName()+$<Symbol>5->getName()+")\n"+$<Symbol>5->getName()); 
	}
	| IF LPAREN expression RPAREN statement %prec LOWER_THAN_ELSE {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"statement : IF-LPAREN-expression-RPAREN-statement");
		Util::parserLog("if("+$<Symbol>3->getName()+")\n"+$<Symbol>5->getName());
		
		if($<Symbol>3->getDeclarationType()=="void "){
			string err = "Invalid Types! Variable Cannot Be Declared void ";
			Util::appendLogError(lines,err,PARSER);
			yyerror(err.c_str());
		}
		$<Symbol>$->setName("if("+$<Symbol>3->getName()+")\n"+$<Symbol>5->getName()); 

	}
	| IF LPAREN expression RPAREN statement ELSE statement {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"statement : IF-LPAREN-expression-RPAREN-statement-ELSE-statement");
		Util::parserLog("if("+$<Symbol>3->getName()+")\n"+$<Symbol>5->getName()+"else\n"+$<Symbol>7->getName());
		if($<Symbol>3->getDeclarationType()=="void "){
			string err = "Invalid Types 1";
			yyerror(err.c_str());
			Util::appendLogError(lines,err,PARSER);
		}
		$<Symbol>$->setName("if("+$<Symbol>3->getName()+")\n"+$<Symbol>5->getName()+" else \n"+$<Symbol>7->getName()); 
	}

	| WHILE LPAREN expression RPAREN statement {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"statement : WHILE-LPAREN-expression-RPAREN-statement");
		Util::parserLog("while("+$<Symbol>3->getName()+")\n"+$<Symbol>5->getName());

		if($<Symbol>3->getDeclarationType()=="void "){
			string err = "Invalid Types 2";
			yyerror(err.c_str());
			Util::appendLogError(lines,err,PARSER);
		}
		$<Symbol>$->setName("while("+$<Symbol>3->getName()+")\n"+$<Symbol>5->getName()); 
	}
	| PRINTLN LPAREN ID RPAREN SEMICOLON {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"statement : PRINTLN-LPAREN-ID-RPAREN-SEMICOLON");
		Util::parserLog("\n ("+$<Symbol>3->getName()+")");
		$<Symbol>$->setName("\n("+$<Symbol>3->getName()+")"); 
	}
	| PRINTLN LPAREN ID RPAREN error {
		string err = "Missing SEMICOLON";
		yyerror(err.c_str());
		Util::appendLogError(lines,err,PARSER);
	}
	| RETURN expression SEMICOLON {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"statement : RETURN-expression-SEMICOLON");
		Util::parserLog("return "+$<Symbol>2->getName());
		if($<Symbol>2->getDeclarationType()=="void "){
			string err = "Invalid Types 3";
			yyerror(err.c_str());
			Util::appendLogError(lines,err,PARSER);
			$<Symbol>$->setDeclarationType("int "); 
		}
		$<Symbol>$->setName("return "+$<Symbol>2->getName()+";"); 
	}
	| RETURN expression error {
		Util::appendLogError(lines,"Missing SEMICOLON",PARSER);
	}
	;

expression_statement: SEMICOLON	{
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"expression_statement : SEMICOLON");
		Util::parserLog(";"); 
		$<Symbol>$->setName(";"); 
	}
	| expression SEMICOLON {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"expression_statement : expression-SEMICOLON");
		Util::parserLog($<Symbol>1->getName()+";");
		$<Symbol>$->setName($<Symbol>1->getName()+";"); 
	}
	| error{
		Util::appendLogError(lines,"Missing SEMICOLON",PARSER);
	}
	| expression error {
		Util::appendLogError(lines,"Missing SEMICOLON",PARSER);
	}
	;

variable: ID {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"variable : ID");
		Util::parserLog($<Symbol>1->getName());
		if(symbolTable->lookUp($<Symbol>1->getName())==nullptr){
			string err = "Undeclared Variable: "+$<Symbol>1->getName();
			Util::appendLogError(lines,err,PARSER);
			yyerror(err.c_str());
		}
		else if(symbolTable->lookUp($<Symbol>1->getName())->getDeclarationType()=="int array" || symbolTable->lookUp($<Symbol>1->getName())->getDeclarationType()=="float array"){
			string err = "Found array: "+$<Symbol>1->getName()+" Expected Variable";
			Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());
		}
		if(symbolTable->lookUp($<Symbol>1->getName())!=nullptr){
			if(DEBUG)cout<<lines<<" "<<$<Symbol>1->toString()<<" "<<symbolTable->lookUp($<Symbol>1->getName())->getDeclarationType()<<endl;
			$<Symbol>$->setDeclarationType(symbolTable->lookUp($<Symbol>1->getName())->getDeclarationType()); 
		}
		$<Symbol>$->setName($<Symbol>1->getName()); 
												
	}
	| ID LTHIRD expression RTHIRD  {
		$<Symbol>$ = TOKEN;
		
		Util::parserLog(lines,"variable : ID-LTHIRD-expression-RTHIRD");
		Util::parserLog($<Symbol>1->getName()+"["+$<Symbol>3->getName()+"]");
		
		if(symbolTable->lookUp($<Symbol>1->getName())==nullptr){
			string err = "Undeclared Variable :"+ $<Symbol>1->getName();
			yyerror(err.c_str());Util::appendLogError(lines,err,PARSER);
		}
		
		if(DEBUG)cout<<lines<<" "<<$<Symbol>3->getDeclarationType()<<endl;
		
		if($<Symbol>3->getDeclarationType()=="float "||$<Symbol>3->getDeclarationType()=="void "){
			string err = "Non-integer Array Index";
			Util::appendLogError(lines,err,PARSER);
			yyerror(err.c_str());
		}
		if(symbolTable->lookUp($<Symbol>1->getName()) != nullptr){
		
			if(DEBUG)cout<<lines<<" "<<symbolTable->lookUp($<Symbol>1->getName())->toString()<<endl;
			
			if(symbolTable->lookUp($<Symbol>1->getName())->getDeclarationType()!="int array" && symbolTable->lookUp($<Symbol>1->getName())->getDeclarationType()!="float array"){
				string err = "Invalid Types 4";
				Util::appendLogError(lines,err,PARSER);	
				yyerror(err.c_str());
			}
			SymbolInfo * array = symbolTable->lookUp($<Symbol>1->getName());
			
			string decType = array->getDeclarationType();
			
			
			if(decType == "float array"){$<Symbol>1->setDeclarationType("float ");}
			
			
			if(decType == "int array"){	$<Symbol>1->setDeclarationType("int ");}
			
			
			$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType()); 
		}
		$<Symbol>$->setName($<Symbol>1->getName()+"["+$<Symbol>3->getName()+"]");  
		
	}
	;
expression: logic_expression {
		$<Symbol>$ = TOKEN;
		
		Util::parserLog(lines,"expression : logic_expression");
		
		$<Symbol>$->setName($<Symbol>1->getName()); 
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType()); 
		Util::parserLog($<Symbol>1->getName());
		
	}
	| variable ASSIGNOP logic_expression {
		$<Symbol>$ = TOKEN;
		
		Util::parserLog(lines,"expression : variable-ASSIGNOP-logic_expression");
	   	Util::parserLog($<Symbol>1->getName()+"="+$<Symbol>3->getName());
		
		if($<Symbol>3->getDeclarationType()=="void "){
			
			string err = "Expression Cannnot Be of Type void";
			Util::appendLogError(lines,err,PARSER);
			$<Symbol>$->setDeclarationType("int ");yyerror(err.c_str()); 
		
		}else if(symbolTable->lookUp($<Symbol>1->getName()) != nullptr) {
			
			if(DEBUG)cout<<lines<<" "<<symbolTable->lookUp($<Symbol>1->getName())->toString()<<""<<$<Symbol>3->toString()<<endl;
			
			string decType = symbolTable->lookUp($<Symbol>1->getName())->getDeclarationType();
			
			if(decType != $<Symbol>3->getDeclarationType()){
				string err = "Invalid Assingment! Assigning "+$<Symbol>3->getDeclarationType()+"to "+decType;
				Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());
			}
		}
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType()); 
		$<Symbol>$->setName($<Symbol>1->getName()+"="+$<Symbol>3->getName());  

	}
	;
logic_expression: rel_expression {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"logic_expression : rel_expression");
		Util::parserLog($<Symbol>1->getName());
		$<Symbol>$->setName($<Symbol>1->getName()); 
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType()); 
	}
	| rel_expression LOGICOP rel_expression {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"logic_expression : rel_expression-LOGICOP-rel_expression");
		
		if($<Symbol>1->getDeclarationType()=="void "||$<Symbol>3->getDeclarationType()=="void "){
			string err = "Invalid Types 7";
			Util::appendLogError(lines,err,PARSER);
			$<Symbol>$->setDeclarationType("int "); yyerror(err.c_str());
		}
		Util::parserLog($<Symbol>1->getName()+$<Symbol>2->getName()+$<Symbol>3->getName());
		
		$<Symbol>$->setDeclarationType("int "); 
		$<Symbol>$->setName($<Symbol>1->getName()+$<Symbol>2->getName()+$<Symbol>3->getName());  

	}
	;

rel_expression: simple_expression {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"rel_expression : simple_expression");
		$<Symbol>$->setName($<Symbol>1->getName()); 
		Util::parserLog($<Symbol>1->getName());
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType()); 
	}
	| simple_expression RELOP simple_expression	 {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"rel_expression : simple_expression-RELOP-simple_expression");
		Util::parserLog($<Symbol>1->getName()+$<Symbol>2->getName()+$<Symbol>3->getName());
		
		if($<Symbol>1->getDeclarationType()=="void "||$<Symbol>3->getDeclarationType()=="void "){
			string err = "Invalid Types! 8";
			yyerror(err.c_str());
			Util::appendLogError(lines,err,PARSER);
			$<Symbol>$->setDeclarationType("int "); 
		}
		$<Symbol>$->setDeclarationType("int "); 	
		$<Symbol>$->setName($<Symbol>1->getName()+$<Symbol>2->getName()+$<Symbol>3->getName());  
	}
	;

simple_expression: term {
		$<Symbol>$ = TOKEN;
		Util::parserLog($<Symbol>1->getName());
		if(DEBUG)cout<<$<Symbol>1->toString()<<endl;
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType());
		$<Symbol>$->setName($<Symbol>1->getName());  
	}
	| simple_expression ADDOP term {
		$<Symbol>$ = TOKEN; 
		
		Util::parserLog(lines,"simple_expression : simple_expression-ADDOP-term");
		
		if(DEBUG)cout<<$<Symbol>3->getDeclarationType()<<endl;
		
		Util::parserLog($<Symbol>1->getName()+$<Symbol>2->getName()+$<Symbol>3->getName());
		
		if($<Symbol>1->getDeclarationType()=="float " || $<Symbol>3->getDeclarationType()=="float "){
			$<Symbol>$->setDeclarationType("float ");
		}
		else if($<Symbol>1->getDeclarationType()=="void "||$<Symbol>3->getDeclarationType()=="void "){
			string err = "Invalid Types 9";
			$<Symbol>$->setDeclarationType("int "); 
			yyerror(err.c_str());Util::appendLogError(lines,err,PARSER);
		}
		else {
			$<Symbol>$->setDeclarationType("int ");
		}
		$<Symbol>$->setName($<Symbol>1->getName()+$<Symbol>2->getName()+$<Symbol>3->getName());  
	}
	;

term: unary_expression {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"term : unary_expression");
		if(DEBUG)cout<<$<Symbol>1->toString()<<endl;
		Util::parserLog($<Symbol>1->getName()); 
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType()); 
		$<Symbol>$->setName($<Symbol>1->getName()); 
	}
    | term MULOP unary_expression {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"term : term-MULOP-unary_expression");
		Util::parserLog($<Symbol>1->getName()+$<Symbol>2->getName()+$<Symbol>3->getName());
		if($<Symbol>1->getDeclarationType()=="void "|| $<Symbol>3->getDeclarationType()=="void "){
			string err = "Invalid Types 10"; 
			yyerror(err.c_str());
			Util::appendLogError(lines,err,PARSER);$<Symbol>$->setDeclarationType("int "); 
		
		}else if($<Symbol>2->getName()=="%"){
			if($<Symbol>1->getDeclarationType()!="int " ||$<Symbol>3->getDeclarationType()!="int "){
				string err = "Non Integer operand on modulus(%) operator";
				Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());
			} 
			$<Symbol>$->setDeclarationType("int "); 
		}
		else if($<Symbol>2->getName()=="/"){
			if($<Symbol>1->getDeclarationType()=="int " && $<Symbol>3->getDeclarationType()=="int "){
				$<Symbol>$->setDeclarationType("int "); 
			}
			else if($<Symbol>1->getDeclarationType()=="void "||$<Symbol>3->getDeclarationType()=="void "){
				string err = "Invalid Types 11";Util::appendLogError(lines,err,PARSER);
				yyerror(err.c_str());$<Symbol>$->setDeclarationType("int "); 
			}
			else {
				$<Symbol>$->setDeclarationType("float "); 
			}
		}
		else{
			if($<Symbol>1->getDeclarationType()=="float " || $<Symbol>3->getDeclarationType()=="float "){
				$<Symbol>$->setDeclarationType("float ");
			}
			else if($<Symbol>1->getDeclarationType()=="void "||$<Symbol>3->getDeclarationType()=="void "){
				string err = "Invalid Types ";
				Util::appendLogError(lines,err,PARSER);$<Symbol>$->setDeclarationType("int "); yyerror(err.c_str());
			}
			 
			else $<Symbol>$->setDeclarationType("int "); 
		}
	
		$<Symbol>$->setName($<Symbol>1->getName()+$<Symbol>2->getName()+$<Symbol>3->getName()); 
								
	}
    ;

unary_expression: ADDOP unary_expression {
	
	$<Symbol>$ = TOKEN;
	
	if($<Symbol>2->getDeclarationType()=="void "){
		string err = "Invalid Types 12";
		Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());
		$<Symbol>$->setDeclarationType("int "); 
	}else {
		$<Symbol>$->setDeclarationType($<Symbol>2->getDeclarationType()); 	
	}
	Util::parserLog($<Symbol>1->getName()+$<Symbol>2->getName());

	$<Symbol>$->setName($<Symbol>1->getName()+$<Symbol>2->getName()); 
	Util::parserLog(lines,"unary_expression : ADDOP-unary_expression");
	
	}
	| NOT unary_expression {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"unary_expression : NOT-unary_expression");
		Util::parserLog("!"+$<Symbol>2->getName()); 
		if($<Symbol>2->getDeclarationType()=="void "){
			string err = "Invalid Types 13";
			yyerror(err.c_str());
			Util::appendLogError(lines,err,PARSER);
			$<Symbol>$->setDeclarationType("int "); 
		}else $<Symbol>$->setDeclarationType($<Symbol>2->getDeclarationType());  
		$<Symbol>$->setName("!"+$<Symbol>2->getName()); 
	}
	| factor {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"unary_expression : factor");
		Util::parserLog($<Symbol>1->getName()); 
		if(DEBUG)cout<<$<Symbol>1->toString()<<endl;
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType()); 
		$<Symbol>$->setName($<Symbol>1->getName()); 
				
	}
	;

factor: variable {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"factor : variable");
		Util::parserLog($<Symbol>1->getName());
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType()); 
		$<Symbol>$->setName($<Symbol>1->getName()); 
	}
	| ID LPAREN argument_list RPAREN {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"factor : ID-LPAREN-argument_list-RPAREN");
		Util::parserLog($<Symbol>1->getName()+"("+$<Symbol>3->getName()+")");
		SymbolInfo* s = symbolTable->lookUp($<Symbol>1->getName());
		if(s==nullptr){
			string err = "Undeclared Function";
			Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());
			$<Symbol>$->setDeclarationType("int "); 
		}
		else if(s->getFunction()==nullptr){
			string err = "Not a Function";yyerror(err.c_str());
			Util::appendLogError(lines,err,PARSER);
			$<Symbol>$->setDeclarationType("int "); 
		}
		else {
			if(s->getFunction()->isDefined()==0){
				pair<string,int> p;
				p.first = s->getName();
				p.second = lines;
				possiblyUndefinedFunctions.push_back(p);
			}
			int num = s->getFunction()->getParamCount();
			
			if(DEBUG)cout<<lines<<" "<<argList.size()<<endl;
			
			$<Symbol>$->setDeclarationType(s->getFunction()->getReturnType());
			if(num!=argList.size()){
				string err = "Invalid number of arguments.Found:"+to_string(num)+" args Expected:"+to_string(argList.size())+" args";
				Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());
			
			}
			else{
				if(DEBUG)cout<<s->getFunction()->getReturnType()<<endl;

				vector<string>paramType = s->getFunction()->getAllParamTypes();
				vector<string>paramList = s->getFunction()->getAllParams();
				
				for(int i=0;i<argList.size();i++){
					if(argList[i]->getDeclarationType()!=paramType[i]){
						string err = "Expected "+Util::trim(paramType[i])+" but passed " 
						+ Util::trim(argList[i]->getDeclarationType())+" as "+to_string(i)+"th parameter";
						Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());
						break;
					}
				}

			}
		}
		argList.clear();
		if(DEBUG)cout<<lines<<" "<<$<Symbol>$->getDeclarationType()<<endl;
		$<Symbol>$->setName($<Symbol>1->getName()+"("+$<Symbol>3->getName()+")"); 
	}
	| LPAREN expression RPAREN {
		$<Symbol>$ = TOKEN;
		$<Symbol>$->setDeclarationType($<Symbol>2->getDeclarationType()); 
		Util::parserLog("("+$<Symbol>2->getName()+")"); 
	
		$<Symbol>$->setName("("+$<Symbol>2->getName()+")"); 
		Util::parserLog(lines,"factor : LPAREN-expression-RPAREN");
	
	}
	| CONST_INT { 
		$<Symbol>$ = TOKEN;
		if(DEBUG)cout<<$<Symbol>1->toString()<<endl;
	
		$<Symbol>$->setDeclarationType("int "); 	
		Util::parserLog($<Symbol>1->getName());
	
		$<Symbol>$->setName($<Symbol>1->getName()); 
		Util::parserLog(lines,"factor : CONST_INT");
			
	}
	| CONST_FLOAT {
		$<Symbol>$ = TOKEN;
		$<Symbol>$->setDeclarationType("float "); 	
		Util::parserLog($<Symbol>1->getName()); 
		$<Symbol>$->setName($<Symbol>1->getName()); 
		Util::parserLog(lines,"factor : CONST_FLOAT");
				
	}
	| variable INCOP {
		$<Symbol>$ = TOKEN;
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType());
		Util::parserLog($<Symbol>1->getName()+"++"); 
		$<Symbol>$->setName($<Symbol>1->getName()+"++"); 
		Util::parserLog(lines,"factor : variable INCOP");
					 
	}
	| variable DECOP {
		$<Symbol>$ = TOKEN;
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType()); 
		Util::parserLog($<Symbol>1->getName()+"--");
		$<Symbol>$->setName($<Symbol>1->getName()+"--"); 
		Util::parserLog(lines,"factor : variable DECOP");
					 
	}
	;

argument_list: arguments {
		$<Symbol>$ = TOKEN;
		Util::parserLog($<Symbol>1->getName());
		$<Symbol>$->setName($<Symbol>1->getName());
		Util::parserLog(lines,"argument_list : arguments");
		
	}
	| %empty {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"argument_list : %empty");
		$<Symbol>$->setName("");}
	;

arguments: arguments COMMA logic_expression {
		$<Symbol>$ = TOKEN;
		argList.push_back($<Symbol>3);
		Util::parserLog($<Symbol>1->getName()+","+$<Symbol>3->getName());
		$<Symbol>$->setName($<Symbol>1->getName()+","+$<Symbol>3->getName());
		Util::parserLog(lines,"arguments : arguments-COMMA-logic_expression ");
		
	}
	| logic_expression {
		
		$<Symbol>$ = TOKEN;
		argList.push_back(new SymbolInfo($<Symbol>1->getName(),$<Symbol>1->getType(),$<Symbol>1->getDeclarationType()));
		Util::parserLog($<Symbol>1->getName()); 
		$<Symbol>$->setName($<Symbol>1->getName());	
		Util::parserLog(lines,"arguments : logic_expression");
						
	}
	;
 %%

void endingRoutine(){
	for(int i=0;i < possiblyUndefinedFunctions.size();i++){
		if(!symbolTable->lookUp(possiblyUndefinedFunctions[i].first)->getFunction()->isDefined()){
			string err = "Calling Undefined Function "+possiblyUndefinedFunctions[i].first; 
			Util::appendLogError(possiblyUndefinedFunctions[i].second,err,PARSER);yyerror(err.c_str());
			
		}	
	}
	possiblyUndefinedFunctions.clear();
}
void test(string fileName){
	lines = 1;
	errors = 0;
	symbolTable = new SymbolTable(100);
	if((fp=fopen(fileName.c_str(),"r"))==NULL)
	{
		printf("Cannot Open Input File.\n");
	}
	yyin=fp;
	cout<<fileName<<endl;
	Util::parserLog("\n\n^^^^^^^^^^^Parsing "+fileName+"^^^^^^^^^^^\n\n");
	Util::appendLogError("\n\n^^^^^^^^^^^Parsing "+fileName+"^^^^^^^^^^^\n\n",PARSER);
	yyparse();
	endingRoutine();
	Util::parserLog("Final SymbolTable : ");
	symbolTable->printAllScopeTables();
	if(isParsingSuccessful){
		Util::parserLog("Total Lines :"+to_string(lines));
		Util::parserLog("Total Errors :"+to_string(errors));
		cout<<"Total Lines :"<<lines<<endl;
		cout<<"Total Errors :"<<errors<<endl;
		Util::appendLogError("\nTotal Errors :"+to_string(errors)+'\n',PARSER);
	}
	else isParsingSuccessful = true;
	fclose(fp);
	Util::parserLog("\n\n^^^^^^^^^^^Finished Parsing "+fileName+"^^^^^^^^^^^\n\n");
	
	
}

int main(int argc,char *argv[])
{
	Util::clearFiles();
	
	int i = 1;
	while(*(argv + i)!=nullptr){
		test(argv[i]);
		i++;
	}

	
	return 0;
}


