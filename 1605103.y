%{
#include<iostream>
#include "headers/1605103_SymbolTable.h"
#include "headers/1605103_AsmCodeGenerator.h"
//#define Util::appendLogError Util::appendLogError
//#define LOG Util::parserLog
#define TOKEN new SymbolInfo()
void optimization(string asmFile);


using namespace std;
int yyparse(void);
int yylex(void);

int lines=1,errors=0;
FILE *fp;
extern FILE *yyin;
string currentFile;
bool DEBUG = false;
bool isParsingSuccessful = true;

SymbolTable *symbolTable = new SymbolTable(100);
AsmCodeGenerator asmGen;

vector<pair<string,int>> possiblyUndefinedFunctions;
vector<SymbolInfo*>paramList,declarationList,argList;


void yyerror(const char *s){
	errors++;
	cerr<<errors<<":"<<s<<" at Line:"<<lines<<endl;
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
//@Revised
start: program {
	if(errors==0){
		$<Symbol>1->setAssemblyCode(
		asmGen.getIntro()
		+asmGen.getDeclarations()
		+".CODE\n"
		+$<Symbol>1->getAssemblyCode()+asmGen.getPrintlnAssembly());

		string asmFile = currentFile.substr(0,currentFile.size()-2)+".asm";
		asmGen.generateFinalAsmFile(asmFile,$<Symbol>1->getAssemblyCode());
		optimization(asmFile);

	}


}
	;
//@Revised
program: program unit {
		Util::parserLog(lines,"program : program-unit");
		Util::parserLog($<Symbol>1->getName()+" "+$<Symbol>2->getName());
		$<Symbol>$ = TOKEN;
		$<Symbol>$->setName($<Symbol>1->getName()+$<Symbol>2->getName());
		$<Symbol>$->setAssemblyCode($<Symbol>1->getAssemblyCode()+$<Symbol>2->getAssemblyCode());

	}
	| unit {
		Util::parserLog(lines,"program : unit");
		$<Symbol>$ = TOKEN;
		$<Symbol>$->setName($<Symbol>1->getName());

		Util::parserLog($<Symbol>1->getName()+'\n');
		$<Symbol>$->setAssemblyCode($<Symbol>1->getAssemblyCode());


	}

	;

//@Revised
unit: var_declaration {

		$<Symbol>$ = TOKEN;

		$<Symbol>$->setName($<Symbol>1->getName()+"\n");
		Util::parserLog(lines,"unit : var_declaration");
		Util::parserLog($<Symbol>1->getName());

		asmGen.funcLocalVars.clear();
		$<Symbol>$->setAssemblyCode($<Symbol>1->getAssemblyCode());

	}

	| func_declaration {

		Util::parserLog(lines,"unit : func_declaration");
		$<Symbol>$ = TOKEN;
		$<Symbol>$->setName($<Symbol>1->getName()+"\n");
		Util::parserLog($<Symbol>1->getName());

		$<Symbol>$->setAssemblyCode($<Symbol>1->getAssemblyCode());
	}
	| func_definition {

		$<Symbol>$ = TOKEN;
		$<Symbol>$->setName($<Symbol>1->getName()+"\n");
		Util::parserLog(lines,"unit : func_definition");
		Util::parserLog($<Symbol>1->getName());

		$<Symbol>$->setAssemblyCode($<Symbol>1->getAssemblyCode());

	}
	;
//@Revised
func_declaration: type_specifier ID LPAREN parameter_list RPAREN SEMICOLON {
		SymbolInfo *func = symbolTable->lookUp($<Symbol>2->getName());
		Util::parserLog(lines,"func_declaration : type_specifier-ID-LPAREN-parameter_list-RPAREN-SEMICOLON");
		$<Symbol>$ = TOKEN;
		Util::parserLog($<Symbol>1->getName()+" "+$<Symbol>2->getName()+"("+$<Symbol>4->getName()+")");

 		if(func != nullptr){
			int num = func->getFunction()->getParamCount();
			if(num == paramList.size()){

				vector<string>paramType = func->getFunction()->getAllParamTypes();

				int len = paramList.size();
				for( int i=0;i < len; i++){
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
			string name2 = $<Symbol>2->getName();
			symbolTable->insert(SymbolInfo(name2,"ID","Function"));
			func = symbolTable->lookUp(name2);
			func->setFunction(true);
			int len = paramList.size();
			for(int i=0 ;i < len ; i++){
				string name = paramList[i]->getName();
				string decType = paramList[i]->getDeclarationType();
				func->getFunction()->addParam(name,decType);
				if(DEBUG)cout<<paramList[i]->getDeclarationType()<<endl;
			}

			paramList.clear();

			func->getFunction()->setReturnType($<Symbol>1->getName());
		}

		string name1 = $<Symbol>1->getName();
		string name2 = $<Symbol>2->getName();
		string name4 = $<Symbol>4->getName();
		$<Symbol>$->setName(name1+" "+name2+"("+name4+");");

	}
	| type_specifier ID LPAREN parameter_list RPAREN error {
		string err = "Missing SEMICOLON";
		Util::appendLogError(lines,err,PARSER);
	}
	| type_specifier ID LPAREN RPAREN SEMICOLON {

			Util::parserLog(lines,"func_declaration : type_specifier-ID-LPAREN-RPAREN-SEMICOLON");
			$<Symbol>$ = TOKEN;
			Util::parserLog($<Symbol>1->getName()+" "+$<Symbol>2->getName()+"();");

			SymbolInfo *s=symbolTable->lookUp($<Symbol>2->getName());

			if(s != nullptr){
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
				SymbolInfo id($<Symbol>2->getName(),"ID","Function");
				symbolTable->insert(id);
				s = symbolTable->lookUp($<Symbol>2->getName());s->setFunction(true);
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
//@Revised
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
					int len = paramList.size();
					for(int i=0;i<len;i++){
						if(paramList[i]->getDeclarationType() != paramType[i]){
							string err = "Expected "+Util::trim(paramList[i]->getDeclarationType())
							+" Found "+Util::trim(paramType[i])+" for "+ to_string(i)+"th "+"Parameter";
							yyerror(err.c_str());
							Util::appendLogError(lines,err,PARSER);
							break;
						}
					}
					if(s->getFunction()->getReturnType() != $<Symbol>1->getName()){
						string err = "Invalid Return Types ! Expected "+s->getFunction()->getReturnType()+ " Found " + $<Symbol>1->getName();
						yyerror(err.c_str());
						Util::appendLogError(lines,err,PARSER);
					}
					s->getFunction()->clear();
					for(int i=0;i<paramList.size();i++){
							s->getFunction()->addParam(paramList[i]->getName()+to_string(symbolTable->getScopeCount()+1),paramList[i]->getDeclarationType());
					//	cout<<para_list[i]->get_dectype()<<para_list[i]->get_name()<<endl;
					}
				}
				s->getFunction()->setDefined();
			}
			else{
				string err = "Function "+$<Symbol>2->getName()+" defined Multiple times";
				yyerror(err.c_str());
				Util::appendLogError(lines,err,PARSER);
			}
		}
		else{
			SymbolInfo sym($<Symbol>2->getName(),"ID","Function");
			symbolTable->insert(sym);
			s = symbolTable->lookUp($<Symbol>2->getName());s->setFunction(true);s->getFunction()->setDefined();
			if(DEBUG)cout<<s->getFunction()->getParamCount()<<endl;
			int len = paramList.size();
			//cout<<$<Symbol>2->getName()<<endl;
			for(int i=0;i<len;i++){
				string name = paramList[i]->getName()+to_string(symbolTable->getScopeCount()+1);

				string decType = paramList[i]->getDeclarationType();
				s->getFunction()->addParam(name,decType);
			}
			Function * func = s->getFunction();
			func->setReturnType($<Symbol>1->getName());
		}
		asmGen.currentProcedure=$<Symbol>2->getName();
		asmGen.vars.push_back(asmGen.currentProcedure+"_return");
	}
	compound_statement {
		Util::parserLog(lines,"func_definition : type_specifier-ID-LPAREN-parameter_list-RPAREN-compound_statement ");
		Util::parserLog($<Symbol>1->getName()+" "+$<Symbol>2->getName()+"("+$<Symbol>4->getName()+") "+ $<Symbol>7->getName());
		$<Symbol>$->setName($<Symbol>1->getName()+" "+$<Symbol>2->getName()+"("+$<Symbol>4->getName()+")"+$<Symbol>7->getName());

		//@CODE-GEN
		$<Symbol>$->setAssemblyCode($<Symbol>2->getName()+" PROC\n");

		if($<Symbol>2->getName()=="main"){
			$<Symbol>$->setAssemblyCode($<Symbol>$->getAssemblyCode()
			+asmGen.getMainIntro()+$<Symbol>7->getAssemblyCode()
			+"LabelReturn"+asmGen.getMainOutro());
		}
		else {
			SymbolInfo *s=symbolTable->lookUp($<Symbol>2->getName());

			for(int i=0;i<asmGen.funcLocalVars.size();i++){
				s->getFunction()->addVar(asmGen.funcLocalVars[i]);
			}
			asmGen.funcLocalVars.clear();

			AssemblyCode asmCode;
			asmCode.append($<Symbol>$->getAssemblyCode()).append(asmGen.getPushAllRegs());
			vector<string>para_list=s->getFunction()->getAllParams(),var_list=s->getFunction()->getVars();

			for(int i=0;i<para_list.size();i++){
				//asmCode.append("\tpush "+para_list[i]+"\n";
				asmCode.append("\tpush "+para_list[i]+"\n");
			}

			for(int i=0;i<var_list.size();i++){
				asmCode.append("\tpush "+var_list[i]+"\n");
			}
			asmCode.append(	$<Symbol>7->getAssemblyCode()+
				"L_Return_"+asmGen.currentProcedure+":\n");
				for(int i=var_list.size()-1;i>=0;i--){
				asmCode.append("\tpop "+var_list[i]+"\n");
			}
			for(int i=para_list.size()-1;i>=0;i--){
				asmCode.append("\tpop "+para_list[i]+"\n");
			}


			asmCode.append("\tpop DX\n\tpop CX\n\tpop BX\n\tpop ax\n\tret\n");

			$<Symbol>$->setAssemblyCode(asmCode.getFinalCode() + $<Symbol>2->getName() + " ENDP\n");

		}
		//TODO : Has this caused Trouble ?
		$<Symbol>$->setName($<Symbol>1->getName()+" "+$<Symbol>2->getName()+"("+$<Symbol>4->getName()+")"+$<Symbol>7->getName());
	}
	| type_specifier ID LPAREN RPAREN {
		SymbolInfo *s = symbolTable->lookUp($<Symbol>2->getName());
		$<Symbol>$ = TOKEN;
		if(s == nullptr){
			SymbolInfo sym($<Symbol>2->getName(),"ID","Function");
			symbolTable->insert(sym);
			s = symbolTable->lookUp($<Symbol>2->getName());
			s -> setFunction(true);s -> getFunction()->setReturnType($<Symbol>1->getName());s -> getFunction()->setDefined();
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
		asmGen.currentProcedure=$<Symbol>2->getName();
		asmGen.vars.push_back(asmGen.currentProcedure+"_return");
		string name1 = $<Symbol>1->getName(),name2 = $<Symbol>2->getName();
		$<Symbol>1->setName($<Symbol>1->getName()+" "+$<Symbol>2->getName()+"()");
	} compound_statement {

		Util::parserLog(lines,"func_definition : type_specifier-ID-LPAREN-RPAREN-compound_statement");
		$<Symbol>$->setName($<Symbol>1->getName()+$<Symbol>6->getName());
		Util::parserLog($<Symbol>1->getName()+" "+$<Symbol>6->getName());

		$<Symbol>$->setAssemblyCode($<Symbol>2->getName()+" PROC\n");

		if($<Symbol>2->getName()=="main"){
			$<Symbol>$->setAssemblyCode($<Symbol>$->getAssemblyCode()
			+asmGen.getMainIntro()+$<Symbol>6->getAssemblyCode()+"L_Return_"
			+asmGen.getMainOutro());
		}
		else {
			SymbolInfo *s=symbolTable->lookUp($<Symbol>2->getName());

		for(int i=0;i<asmGen.funcLocalVars.size();i++){
			s->getFunction()->addVar(asmGen.funcLocalVars[i]);
		}
		asmGen.funcLocalVars.clear();

		AssemblyCode asmCode;asmCode.append($<Symbol>$->getAssemblyCode()+"\tpush ax\n\tpush BX \n\tpush CX \n\tpush DX\n");

		vector<string>para_list=s->getFunction()->getAllParams();
		vector<string>var_list=s->getFunction()->getVars();
		for(int i=0;i<para_list.size();i++){
			asmCode.append("\tpush "+para_list[i]+"\n");
		}
		for(int i=0;i<var_list.size();i++){
			asmCode.append("\tpush "+var_list[i]+"\n");
		}

		asmCode.append(	$<Symbol>6->getAssemblyCode()+"L_Return_"+asmGen.currentProcedure+":\n");

		for(int i=var_list.size()-1;i>=0;i--){
			asmCode.append("\tpop "+var_list[i]+"\n");
		}
		for(int i=para_list.size()-1;i>=0;i--){
			asmCode.append("\tpop "+para_list[i]+"\n");
		}


		asmCode.append("\tpop DX\n\tpop CX\n\tpop BX\n\tpop ax\n\tret\n");

		$<Symbol>$->setAssemblyCode(asmCode.getFinalCode()+$<Symbol>2->getName()+" ENDP\n");
		}
		$<Symbol>$->setName($<Symbol>1->getName()+$<Symbol>6->getName());
	}
	;
//@Revised
parameter_list: parameter_list COMMA type_specifier ID {

		Util::parserLog(lines,"parameter_list : parameter_list-COMMA-type_specifier-ID");
		$<Symbol>$ = TOKEN;

		Util::parserLog($<Symbol>1->getName()+","+$<Symbol>3->getName()+" "+$<Symbol>4->getName());
		SymbolInfo * pl = new SymbolInfo($<Symbol>4->getName(),"ID",$<Symbol>3->getName());
		paramList.push_back(pl);$<Symbol>$->setName($<Symbol>1->getName()+","+$<Symbol>3->getName()+" "+$<Symbol>4->getName());
	}
	| parameter_list COMMA type_specifier {
		Util::parserLog(lines,"parameter_list : parameter_list-COMMA-type_specifier");
		$<Symbol>$ = TOKEN;
		Util::parserLog($<Symbol>1->getName()+","+$<Symbol>3->getName());
		SymbolInfo * type = new SymbolInfo("","ID",$<Symbol>3->getName());
		$<Symbol>$->setName($<Symbol>1->getName()+","+$<Symbol>3->getName());
		paramList.push_back(type);
	}
	| type_specifier ID {
		Util::parserLog(lines,"parameter_list : type_specifier-ID");
		Util::parserLog($<Symbol>1->getName()+" "+$<Symbol>2->getName());
		$<Symbol>$ = TOKEN;
		string name1 = $<Symbol>1->getName(),name2 = $<Symbol>2->getName();
		SymbolInfo * si = new SymbolInfo(name2,"ID",name1);
		$<Symbol>$->setName(name1+" "+name2);
		paramList.push_back(si);
	}
	| type_specifier {
		Util::parserLog(lines,"parameter_list : type_specifier");
		$<Symbol>$ = TOKEN;
		Util::parserLog($<Symbol>1->getName());
		$<Symbol>$->setName($<Symbol>1->getName()+" ");
		paramList.push_back(new SymbolInfo("","ID",$<Symbol>1->getName()));
	}
	;
//@Revised
compound_statement: LCURL {

	symbolTable->enterScope();
	int len = paramList.size();
	for(int i=0;i<len;i++){
		string name = paramList[i]->getName();
		string type = paramList[i]->getDeclarationType();
		symbolTable->insert(SymbolInfo(name,"ID",type));
		asmGen.vars.push_back(paramList[i]->getName()+to_string(symbolTable->currentScopeId));
	}
	paramList.clear();

	} statements RCURL {

		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"compound_statement : LCURL-statements-RCURL");

		symbolTable->printAllScopeTables();
		$<Symbol>$->setName("{\n"+$<Symbol>3->getName()+"\n}");
		symbolTable->exitScope();
		Util::parserLog("{"+$<Symbol>3->getName()+"}");
		$<Symbol>$->setAssemblyCode($<Symbol>3->getAssemblyCode());

	}
	| LCURL RCURL {
		symbolTable->enterScope();
		int len = paramList.size();

		for(int i=0;i<len;i++){
			string name = paramList[i]->getName();
			string type = paramList[i]->getDeclarationType();
			symbolTable->insert(SymbolInfo(name,"ID",type));
			asmGen.vars.push_back(paramList[i]->getName()+to_string(symbolTable->currentScopeId));
		}

		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"compound_statement : LCURL-RCURL");
		paramList.clear();
		Util::parserLog("{}");;
		symbolTable->printAllScopeTables();
		$<Symbol>$->setName("{}");
		symbolTable->exitScope();
	}
	;
//@Revised
var_declaration: type_specifier declarationList SEMICOLON {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"var_declaration : type_specifier-declarationList-SEMICOLON");
		Util::parserLog($<Symbol>1->getName()+" "+$<Symbol>2->getName()+";");
		if($<Symbol>1->getName()=="void "){
			string err = "Cannot Declare void Type";
			yyerror(err.c_str());Util::appendLogError(lines,err,PARSER);
		}
		else{
			int len = declarationList.size();
			for(int i=0;i < len ; i++){
				if(symbolTable->lookUpLocal(declarationList[i]->getName()) != nullptr){
					string err = declarationList[i]->getName()+" defined multiple times";
					yyerror(err.c_str());Util::appendLogError(lines,err,PARSER);
					continue;
				}
				if(declarationList[i]->getType().size()<3){
					asmGen.funcLocalVars.push_back(declarationList[i]->getName()+to_string(symbolTable->currentScopeId));
					asmGen.vars.push_back(declarationList[i]->getName()+to_string(symbolTable->currentScopeId));
					symbolTable->insert(SymbolInfo(declarationList[i]->getName(),declarationList[i]->getType(),$<Symbol>1->getName()));
				} else{
					asmGen.arrays.push_back(make_pair(declarationList[i]->getName()+to_string(symbolTable->currentScopeId),
					declarationList[i]->getType().substr(2,declarationList[i]->getType().size () - 1)));

					string type = declarationList[i]->getType().substr(0,declarationList[i]->getType().size () - 1);
					declarationList[i]->setType(type);
					symbolTable->insert(SymbolInfo(declarationList[i]->getName(),declarationList[i]->getType(),$<Symbol>1->getName()+"array"));
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
//@Revised
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
//@Revised
declarationList: declarationList COMMA ID {
	Util::parserLog(lines,"declarationList : declarationList-COMMA-ID");
	$<Symbol>$ = TOKEN;
	string name1 = $<Symbol>1->getName();
	string name3 = $<Symbol>3->getName();
	Util::parserLog(name1+","+name3);

	SymbolInfo * id = new SymbolInfo(name3,"ID");

	declarationList.push_back(id);

	$<Symbol>$->setName(name1+","+name3);

	}
	| declarationList COMMA ID LTHIRD CONST_INT RTHIRD {
		Util::parserLog(lines,"declarationList : declarationList-COMMA-ID-LTHIRD-CONST_INT-RTHIRD");
		$<Symbol>$ = TOKEN;
		Util::parserLog($<Symbol>1->getName()+","+$<Symbol>3->getName()+"["+$<Symbol>5->getName()+"]");
		SymbolInfo * id = new SymbolInfo($<Symbol>3->getName(),"ID"+$<Symbol>5->getName());
		declarationList.push_back(id);
		$<Symbol>$->setName($<Symbol>1->getName()+","+$<Symbol>3->getName()+"["+$<Symbol>5->getName()+"]");
	}
	| ID {
		Util::parserLog(lines,"declarationList : ID");
		Util::parserLog($<Symbol>1->getName());
		declarationList.push_back(new SymbolInfo($<Symbol>1->getName(),"ID"));
		$<Symbol>$ = TOKEN;
		$<Symbol>$->setName($<Symbol>1->getName());
	}
	| ID LTHIRD CONST_INT RTHIRD {
		Util::parserLog(lines,"declarationList : ID-LTHIRD-CONST_INT-RTHIRD");
		$<Symbol>$ = TOKEN;
		Util::parserLog($<Symbol>1->getName()+"["+$<Symbol>3->getName()+"]");

		SymbolInfo * id = new SymbolInfo($<Symbol>1->getName(),"ID"+$<Symbol>3->getName());

		declarationList.push_back(id);
		$<Symbol>$->setName($<Symbol>1->getName()+"["+$<Symbol>3->getName()+"]");
	}
	;
//@Revised
statements: statement {
		Util::parserLog(lines,"statements : statement");
		Util::parserLog($<Symbol>1->getName());
		$<Symbol>$ = TOKEN;$<Symbol>$->setName($<Symbol>1->getName());
		$<Symbol>$->setAssemblyCode($<Symbol>1->getAssemblyCode());
	}
	| statements statement {
		Util::parserLog(lines,"statements : statements-statement");
		$<Symbol>$ = TOKEN;
		Util::parserLog($<Symbol>1->getName()+" "+$<Symbol>2->getName());
		$<Symbol>$->setName($<Symbol>1->getName()+"\n"+$<Symbol>2->getName());
		$<Symbol>$->setAssemblyCode($<Symbol>1->getAssemblyCode()+$<Symbol>2->getAssemblyCode());
	}
	;
//@Revised
statement: var_declaration {
		Util::parserLog(lines,"statement : var_declaration");
		Util::parserLog($<Symbol>1->getName());
		$<Symbol>$ = TOKEN;
		$<Symbol>$->setName($<Symbol>1->getName());
	}
	| expression_statement {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"statement : expression_statement");
		Util::parserLog($<Symbol>1->getName());
		$<Symbol>$->setName($<Symbol>1->getName());
		$<Symbol>$->setAssemblyCode($<Symbol>1->getAssemblyCode());

	}
	| compound_statement {

		$<Symbol>$ = TOKEN;

		$<Symbol>$->setName($<Symbol>1->getName());
		Util::parserLog(lines,"statement : compound_statement");
		Util::parserLog($<Symbol>1->getName());
		$<Symbol>$->setAssemblyCode($<Symbol>1->getAssemblyCode());

	}
	| FOR LPAREN expression_statement expression_statement expression RPAREN statement {
		$<Symbol>$ = TOKEN;

		Util::parserLog(lines,"statement : FOR-LPAREN-expression_statement-expression_statement-expression-RPAREN-statement");
		Util::parserLog("for("+$<Symbol>3->getName()+" "+$<Symbol>4->getName()+" "+

		$<Symbol>5->getName()+")\n"+$<Symbol>7->getName());

		if($<Symbol>3->getDeclarationType()=="void "){
			string err = "Variable Cannot Be Declared void ";Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());}

		else{
			char *label1=asmGen.newLabel();
			char *label2=asmGen.newLabel();
			AssemblyCode asmCode;asmCode.append($<Symbol>3->getAssemblyCode());
			asmCode.append(string(label1)+":\n");
			asmCode.append($<Symbol>4->getAssemblyCode());
			asmCode.append("\tmov ax,"+$<Symbol>4->getIdValue()+"\n");
			asmCode.append("\tcmp ax,0\n");
			asmCode.append("\tje "+string(label2)+"\n");
			asmCode.append($<Symbol>7->getAssemblyCode());
			asmCode.append($<Symbol>5->getAssemblyCode());
			asmCode.append("\tjmp "+string(label1)+"\n");
			asmCode.append(string(label2)+":\n");
			$<Symbol>$->setAssemblyCode(asmCode.getFinalCode());
		}
		string name3 = $<Symbol>3->getName();
		string name4 = $<Symbol>4->getName();
		string name5 = $<Symbol>5->getName();
		$<Symbol>$->setName("for("+name3+name4+name5+")\n"+name5);
	}
	| IF LPAREN expression RPAREN statement %prec LOWER_THAN_ELSE {
		Util::parserLog(lines,"statement : IF-LPAREN-expression-RPAREN-statement");
		$<Symbol>$ = TOKEN;
		Util::parserLog("if("+$<Symbol>3->getName()+")\n"+$<Symbol>5->getName());

		if($<Symbol>3->getDeclarationType()=="void "){
			string err = "Variable Cannot Be Declared void ";
			Util::appendLogError(lines,err,PARSER);
			yyerror(err.c_str());
		}
		else{
		//@CODE-GEN
			AssemblyCode asmCode;asmCode.append($<Symbol>3->getAssemblyCode());
			char *label1=asmGen.newLabel();
			asmCode.append("\tmov ax,"+$<Symbol>3->getIdValue()+"\n");
			asmCode.append("\tcmp ax,0\n");
			asmCode.append("\tje "+string(label1)+"\n");
			asmCode.append($<Symbol>5->getAssemblyCode());
			asmCode.append(string(label1)+":\n");
			$<Symbol>$->setAssemblyCode(asmCode.getFinalCode());

		}
		string name3 = $<Symbol>3->getName();
		string name5 = $<Symbol>5->getName();
		$<Symbol>$->setName("if("+name3+")\n"+name5);
	}
	| IF LPAREN expression RPAREN statement ELSE statement {
		Util::parserLog(lines,"statement : IF-LPAREN-expression-RPAREN-statement-ELSE-statement");
		$<Symbol>$ = TOKEN;
		Util::parserLog("if("+$<Symbol>3->getName()+")\n"+$<Symbol>5->getName()+"else\n"+$<Symbol>7->getName());
		if($<Symbol>3->getDeclarationType()=="void "){
			string err = "void expression cannot be used inside if";yyerror(err.c_str());Util::appendLogError(lines,err,PARSER);
		}
		else{
		//@CODE-GEN
			AssemblyCode asmCode;asmCode.append($<Symbol>3->getAssemblyCode());
			char *label1=asmGen.newLabel();
			char *label2=asmGen.newLabel();
			asmCode.append("\tmov ax,"+$<Symbol>3->getIdValue()+"\n");
			asmCode.append("\tcmp ax,0\n");
			asmCode.append("\tje "+string(label1)+"\n");
			asmCode.append($<Symbol>5->getAssemblyCode());
			asmCode.append("\tjmp "+string(label2)+"\n");
			asmCode.append(string(label1)+":\n");
			asmCode.append($<Symbol>7->getAssemblyCode());
			asmCode.append(string(label2)+":\n");
			$<Symbol>$->setAssemblyCode(asmCode.getFinalCode());
		}
		string name3 = $<Symbol>3->getName(), name5 = $<Symbol>5->getName(), name7 = $<Symbol>7->getName();
		$<Symbol>$->setName("if("+name3+")\n"+name5+" else \n"+name7);
	}
	| WHILE LPAREN expression RPAREN statement {
		Util::parserLog(lines,"statement : WHILE-LPAREN-expression-RPAREN-statement");
		$<Symbol>$ = TOKEN;
		Util::parserLog("while("+$<Symbol>3->getName()+")\n"+$<Symbol>5->getName());

		if($<Symbol>3->getDeclarationType()=="void "){
			string err = "void expression cannot be used inside while";
			yyerror(err.c_str());
			Util::appendLogError(lines,err,PARSER);
		}

		else{
			//@CODE-GEN
			AssemblyCode asmCode;asmCode.append("");
			char *label1=asmGen.newLabel();
			char *label2=asmGen.newLabel();
			asmCode.append(string(label1)+":\n");
			asmCode.append($<Symbol>3->getAssemblyCode());
			asmCode.append("\tmov ax,"+$<Symbol>3->getIdValue()+"\n");
			asmCode.append("\tcmp ax,0\n");
			asmCode.append("\tje "+string(label2)+"\n");
			asmCode.append($<Symbol>5->getAssemblyCode());
			asmCode.append("\tjmp "+string(label1)+"\n");
			asmCode.append(string(label2)+":\n");
			$<Symbol>$->setAssemblyCode(asmCode.getFinalCode());
		}
		$<Symbol>$->setName("while("+$<Symbol>3->getName()+")\n"+$<Symbol>5->getName());
	}
	| PRINTLN LPAREN ID RPAREN SEMICOLON {
		Util::parserLog(lines,"statement : PRINTLN-LPAREN-ID-RPAREN-SEMICOLON");
		$<Symbol>$ = TOKEN;
		Util::parserLog("\n ("+$<Symbol>3->getName()+")");

		//@CODE-GEN
		AssemblyCode asmCode;asmCode.append("");
		if(symbolTable->findValidIdName($<Symbol>3->getName())==-1){
			yyerror("Printing Undeclared Variable");
			Util::appendLogError(lines,"Printing Undeclared Variable",PARSER);
		}
		else{

			asmCode.append("\tmov ax,"+$<Symbol>3->getName()+to_string(symbolTable->findValidIdName($<Symbol>3->getName())));
			asmCode.append("\n\tcall OUTDEC\n");
		}
		$<Symbol>$->setAssemblyCode(asmCode.getFinalCode());
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
			string err = "function returning a void expression";
			yyerror(err.c_str());
			Util::appendLogError(lines,err,PARSER);
			$<Symbol>$->setDeclarationType("int ");
		}
		else{
			AssemblyCode asmCode;asmCode.append($<Symbol>2->getAssemblyCode());
			asmCode.append("\tmov ax,"+$<Symbol>2->getIdValue()+"\n");
			asmCode.append("\tmov "+asmGen.currentProcedure+"_return,ax\n");
			asmCode.append("\tjmp L_Return_"+asmGen.currentProcedure+"\n");
			$<Symbol>$->setAssemblyCode(asmCode.getFinalCode());
		}
		$<Symbol>$->setName("return "+$<Symbol>2->getName()+";");
	}
	| RETURN expression error {
		Util::appendLogError(lines,"Missing SEMICOLON",PARSER);
	}
	;
//@Revised
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
		$<Symbol>$->setAssemblyCode($<Symbol>1->getAssemblyCode());
		$<Symbol>$->setIdValue($<Symbol>1->getIdValue());

	}
	| error{
		Util::appendLogError(lines,"Missing SEMICOLON",PARSER);
	}
	| expression error {
		Util::appendLogError(lines,"Missing SEMICOLON",PARSER);
	}
	;
variable: ID {
		string name = $<Symbol>1->getName();
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"variable : ID");
		Util::parserLog($<Symbol>1->getName());
		SymbolInfo * sm = symbolTable->lookUp(name);
		if(sm==nullptr){
			string err = "Undeclared Variable: "+$<Symbol>1->getName();
			Util::appendLogError(lines,err,PARSER);
			yyerror(err.c_str());
		}
		else if(sm->getDeclarationType()=="int array" || sm->getDeclarationType()=="float array"){
			string err = "Found array: "+$<Symbol>1->getName()+" Expected Variable";
			Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());
		}
		if(sm!=nullptr){
			$<Symbol>$->setDeclarationType(sm->getDeclarationType());
			$<Symbol>$->setIdValue($<Symbol>1->getName()+to_string(symbolTable->findValidIdName($<Symbol>1->getName())));
		}
		$<Symbol>$->setName(name);
		$<Symbol>$->setType("notarray");

	}

	| ID LTHIRD expression RTHIRD  {

		Util::parserLog(lines,"variable : ID-LTHIRD-expression-RTHIRD");
		$<Symbol>$ = TOKEN;

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

			bool c1 = symbolTable->lookUp($<Symbol>1->getName())->getDeclarationType()!="int array";
			bool c2 = symbolTable->lookUp($<Symbol>1->getName())->getDeclarationType()!="float array";
			if(c1 && c2){
				string err = "Invalid Types.Expected array";
				Util::appendLogError(lines,err,PARSER);
				yyerror(err.c_str());
			}
			SymbolInfo * array = symbolTable->lookUp($<Symbol>1->getName());

			string decType = array->getDeclarationType();


			if(decType == "float array"){$<Symbol>1->setDeclarationType("float ");}


			if(decType == "int array"){	$<Symbol>1->setDeclarationType("int ");}
			$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType());
			AssemblyCode asmCode;asmCode.append("");
			asmCode.append($<Symbol>3->getAssemblyCode());
			asmCode.append("\tmov BX,"+$<Symbol>3->getIdValue()+"\n");
			asmCode.append("\tadd BX,BX\n");
			$<Symbol>$->setIdValue($<Symbol>1->getName()+to_string(symbolTable->findValidIdName($<Symbol>1->getName())));
			$<Symbol>$->setAssemblyCode(asmCode.getFinalCode());

		}
		string name3 = $<Symbol>3->getName(),name1 = $<Symbol>1->getName();
		$<Symbol>$->setName(name1+"["+name3+"]");
		$<Symbol>$->setType("array");

	}
	;
expression: logic_expression {
		$<Symbol>$ = TOKEN;

		Util::parserLog(lines,"expression : logic_expression");

		$<Symbol>$->setName($<Symbol>1->getName());
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType());
		Util::parserLog($<Symbol>1->getName());
		$<Symbol>$->setAssemblyCode($<Symbol>1->getAssemblyCode());
		$<Symbol>$->setIdValue($<Symbol>1->getIdValue());

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
				string err = "Invalid Assignment! Assigning "+$<Symbol>3->getDeclarationType()+"to "+decType;
				Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());
			}
		}
		AssemblyCode asmCode;asmCode.append($<Symbol>1->getAssemblyCode());
		asmCode.append($<Symbol>3->getAssemblyCode());
		asmCode.append("\tmov ax,"+$<Symbol>3->getIdValue()+"\n");
		if($<Symbol>1->getType()=="notarray"){


		asmCode.append("\tmov "+$<Symbol>1->getIdValue()+",ax\n");}
		else{

			asmCode.append("\tmov "+$<Symbol>1->getIdValue()+"[BX],ax\n");
		}
		$<Symbol>$->setAssemblyCode(asmCode.getFinalCode());

		$<Symbol>$->setIdValue($<Symbol>1->getIdValue());

		$<Symbol>$->setName($<Symbol>1->getName()+"="+$<Symbol>3->getName());
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType());

	}
	;
logic_expression: rel_expression {
		Util::parserLog(lines,"logic_expression : rel_expression");
		$<Symbol>$ = TOKEN;$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType());
		$<Symbol>$->setAssemblyCode($<Symbol>1->getAssemblyCode());
		$<Symbol>$->setIdValue($<Symbol>1->getIdValue());
		string name1 = $<Symbol>1->getName();Util::parserLog(name1);$<Symbol>$->setName(name1);

	}
	| rel_expression LOGICOP rel_expression {
		Util::parserLog(lines,"logic_expression : rel_expression-LOGICOP-rel_expression");
		$<Symbol>$ = TOKEN;
		if($<Symbol>1->getDeclarationType()=="void "||$<Symbol>3->getDeclarationType()=="void "){
			$<Symbol>$->setDeclarationType("int ");
			string err = "Expected Relational Expression found void";Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());
		}
		AssemblyCode asmCode;
		asmCode.append($<Symbol>1->getAssemblyCode()).append($<Symbol>3->getAssemblyCode());
		char *label1=asmGen.newLabel(),*label2=asmGen.newLabel(),*label3=asmGen.newLabel(),*temp=asmGen.newTemp();

		if($<Symbol>2->getName()=="||"){
			asmCode.append("\tmov ax,"+$<Symbol>1->getIdValue()+"\n").append("\tcmp ax,0\n").append("\tjne "+string(label2)+"\n")
			.append("\tmov ax,"+$<Symbol>3->getIdValue()+"\n").append("\tcmp ax,0\n").append("\tjne "+string(label2)+"\n")
			.append(string(label1)+":\n").append("\tmov "+string(temp)+",0\n").append("\tjmp "+string(label3)+"\n")
			.append(string(label2)+":\n").append("\tmov "+string(temp)+",1\n").append(string(label3)+":\n");
		}
		else{
			asmCode.append("\tmov ax,"+$<Symbol>1->getIdValue()+"\n")
			.append("\tcmp ax,0\n").append("\tje "+string(label2)+"\n").append("\tmov ax,"+$<Symbol>3->getIdValue()+"\n")
			.append("\tcmp ax,0\n").append("\tje "+string(label2)+"\n").append(string(label1)+":\n")
			.append("\tmov "+string(temp)+",1\n").append("\tjmp "+string(label3)+"\n").append(string(label2)+":\n")
			.append("\tmov "+string(temp)+",0\n").append(string(label3)+":\n");
		}
		$<Symbol>$->setAssemblyCode(asmCode.getFinalCode());
		$<Symbol>$->setIdValue(temp);
		asmGen.vars.push_back(temp);

		Util::parserLog($<Symbol>1->getName()+$<Symbol>2->getName()+$<Symbol>3->getName());
		$<Symbol>$->setName($<Symbol>1->getName()+$<Symbol>2->getName()+$<Symbol>3->getName());
		$<Symbol>$->setDeclarationType("int ");
	}
	;
rel_expression: simple_expression {
		Util::parserLog(lines,"rel_expression : simple_expression");
		$<Symbol>$ = TOKEN;
		$<Symbol>$->setName($<Symbol>1->getName());
		Util::parserLog($<Symbol>1->getName());
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType());
		$<Symbol>$->setAssemblyCode($<Symbol>1->getAssemblyCode());
		$<Symbol>$->setIdValue($<Symbol>1->getIdValue());
	}
	| simple_expression RELOP simple_expression	 {

		Util::parserLog(lines,"rel_expression : simple_expression-RELOP-simple_expression");

		$<Symbol>$ = TOKEN;

		Util::parserLog($<Symbol>1->getName()+$<Symbol>2->getName()+$<Symbol>3->getName());

		if($<Symbol>1->getDeclarationType()=="void "||$<Symbol>3->getDeclarationType()=="void "){
			string err = "void expressions cannot be relationally compared";
			yyerror(err.c_str());Util::appendLogError(lines,err,PARSER);$<Symbol>$->setDeclarationType("int ");
		}
		$<Symbol>$->setDeclarationType("int ");

		string name1 = $<Symbol>1->getName();

		string name2 = $<Symbol>2->getName();

		string name3 = $<Symbol>3->getName();

		$<Symbol>$->setName(name1+name2+name3);

		AssemblyCode asmCode;asmCode.append($<Symbol>1->getAssemblyCode());
		asmCode.append($<Symbol>3->getAssemblyCode());
		char *temp=asmGen.newTemp();
		char *label1=asmGen.newLabel();
		char *label2=asmGen.newLabel();
		asmCode.append("\tmov ax,"+$<Symbol>1->getIdValue()+"\n");
		asmCode.append("\tcmp ax,"+$<Symbol>3->getIdValue()+"\n");
		if($<Symbol>2->getName()=="<"){
			asmCode.append("\tjl "+string(label1)+"\n");

		}
		else if($<Symbol>2->getName()==">"){
			asmCode.append("\tjg "+string(label1)+"\n");

		}
		else if($<Symbol>2->getName()=="<="){
			asmCode.append("\tjle "+string(label1)+"\n");

		}
		else if($<Symbol>2->getName()==">="){
			asmCode.append("\tjge "+string(label1)+"\n");

		}
		else if($<Symbol>2->getName()=="=="){
			asmCode.append("\tje "+string(label1)+"\n");

		}
		else if($<Symbol>2->getName()=="!="){
			asmCode.append("\tjne "+string(label1)+"\n");

		}
		asmCode.append("\tmov "+string(temp)+",0\n");
		asmCode.append("\tjmp "+string(label2)+"\n");
		asmCode.append(string(label1)+":\n");
		asmCode.append("\tmov "+string(temp)+",1\n");
		asmCode.append(string(label2)+":\n");
		asmGen.vars.push_back(temp);
		$<Symbol>$->setAssemblyCode(asmCode.getFinalCode());
		$<Symbol>$->setIdValue(temp);

	}
	;
simple_expression: term {
		Util::parserLog(lines,"simple_expression : term");
		$<Symbol>$ = TOKEN;
		Util::parserLog($<Symbol>1->getName());
		if(DEBUG)cout<<$<Symbol>1->toString()<<endl;
		$<Symbol>$->setName($<Symbol>1->getName());
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType());
		$<Symbol>$->setAssemblyCode($<Symbol>1->getAssemblyCode());
		$<Symbol>$->setIdValue($<Symbol>1->getIdValue());
	}
	| simple_expression ADDOP term {
		if(DEBUG)cout<<$<Symbol>3->getDeclarationType()<<endl;

		Util::parserLog(lines,"simple_expression : simple_expression-ADDOP-term");

		$<Symbol>$ = TOKEN;

		Util::parserLog($<Symbol>1->getName()+$<Symbol>2->getName()+$<Symbol>3->getName());

		if($<Symbol>1->getDeclarationType()=="float " || $<Symbol>3->getDeclarationType()=="float "){
			$<Symbol>$->setDeclarationType("float ");
		}
		else if($<Symbol>1->getDeclarationType()=="void "||$<Symbol>3->getDeclarationType()=="void "){
			string err = "void expression cannot be used as operands of +/-";$<Symbol>$->setDeclarationType("int ");
			yyerror(err.c_str());Util::appendLogError(lines,err,PARSER);
		}
		else {$<Symbol>$->setDeclarationType("int ");}

		AssemblyCode asmCode;asmCode.append($<Symbol>1->getAssemblyCode()+$<Symbol>3->getAssemblyCode());

		asmCode.append("\tmov ax,"+$<Symbol>1->getIdValue()+"\n");
		char *temp=asmGen.newTemp();
		if($<Symbol>2->getName()=="+"){
			asmCode.append("\tadd ax,"+$<Symbol>3->getIdValue()+"\n");
		}
		else{
			asmCode.append("\tsub ax,"+$<Symbol>3->getIdValue()+"\n");

		}
		asmCode.append("\tmov "+string(temp)+",ax\n");
		$<Symbol>$->setAssemblyCode(asmCode.getFinalCode());
		$<Symbol>$->setIdValue(temp);
		asmGen.vars.push_back(temp);
		$<Symbol>$->setName($<Symbol>1->getName()+$<Symbol>2->getName()+$<Symbol>3->getName());
	}
	;
term: unary_expression {
		Util::parserLog(lines,"term : unary_expression");
		$<Symbol>$ = TOKEN;
		if(DEBUG)cout<<$<Symbol>1->toString()<<endl;

		Util::parserLog($<Symbol>1->getName());
		string name  = $<Symbol>1->getName();
		string decType = $<Symbol>1->getDeclarationType();
		$<Symbol>$->setDeclarationType(decType);
		$<Symbol>$->setName(name);

		$<Symbol>$->setAssemblyCode($<Symbol>1->getAssemblyCode());
		$<Symbol>$->setIdValue($<Symbol>1->getIdValue());

	}
    | term MULOP unary_expression {
		Util::parserLog(lines,"term : term-MULOP-unary_expression");
		$<Symbol>$ = TOKEN;
		Util::parserLog($<Symbol>1->getName()+$<Symbol>2->getName()+$<Symbol>3->getName());
		if($<Symbol>1->getDeclarationType()=="void "|| $<Symbol>3->getDeclarationType()=="void "){
			string err = "void expressions cannot be used as operands of *,/";
			yyerror(err.c_str());
			Util::appendLogError(lines,err,PARSER);$<Symbol>$->setDeclarationType("int ");

		}else if($<Symbol>2->getName()=="%"){
			if($<Symbol>1->getDeclarationType()!="int " ||$<Symbol>3->getDeclarationType()!="int "){
				string err = "Modulus(%) operator cannot have non-integer operands";
				Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());
			}
			$<Symbol>$->setDeclarationType("int ");
			AssemblyCode asmCode;asmCode.append($<Symbol>1->getAssemblyCode()+$<Symbol>3->getAssemblyCode());
			char *temp=asmGen.newTemp();
			asmCode.append("\tmov ax,"+$<Symbol>1->getIdValue()+"\n");
			asmCode.append("\tmov BX,"+$<Symbol>3->getIdValue()+"\n");
			asmCode.append("\tmov DX,0\n");
			asmCode.append("\tdiv BX\n");
			asmCode.append("\tmov "+string(temp)+", DX\n");
			$<Symbol>$->setAssemblyCode(asmCode.getFinalCode());
			$<Symbol>$->setIdValue(temp);
			asmGen.vars.push_back(temp);
		}
		else if($<Symbol>2->getName()=="/"){
			if($<Symbol>1->getDeclarationType()=="int " && $<Symbol>3->getDeclarationType()=="int "){
				$<Symbol>$->setDeclarationType("int ");
			}
			else if($<Symbol>1->getDeclarationType()=="void "||$<Symbol>3->getDeclarationType()=="void "){
				string err = "void expressions cannot be used as operands of *,/";Util::appendLogError(lines,err,PARSER);
				yyerror(err.c_str());$<Symbol>$->setDeclarationType("int ");
			}
			else {
				$<Symbol>$->setDeclarationType("float ");
			}
			AssemblyCode asmCode;asmCode.append($<Symbol>1->getAssemblyCode()+$<Symbol>3->getAssemblyCode());
			char *temp=asmGen.newTemp();
			asmCode.append("\tmov ax,"+$<Symbol>1->getIdValue()+"\n");
			asmCode.append("\tmov BX,"+$<Symbol>3->getIdValue()+"\n");
			asmCode.append("\tdiv BX\n");
			asmCode.append("\tmov "+string(temp)+", ax\n");
			$<Symbol>$->setAssemblyCode(asmCode.getFinalCode());
			$<Symbol>$->setIdValue(temp);
			asmGen.vars.push_back(temp);

		}
		else{
			if($<Symbol>1->getDeclarationType()=="float " || $<Symbol>3->getDeclarationType()=="float "){
				$<Symbol>$->setDeclarationType("float ");
			}
			else if($<Symbol>1->getDeclarationType()=="void "||$<Symbol>3->getDeclarationType()=="void "){
				string err = "void expressions cannot be used as operands of *,/";
				Util::appendLogError(lines,err,PARSER);$<Symbol>$->setDeclarationType("int "); yyerror(err.c_str());
			}
			else $<Symbol>$->setDeclarationType("int ");

			AssemblyCode asmCode;asmCode.append($<Symbol>1->getAssemblyCode()+$<Symbol>3->getAssemblyCode());
			char *temp=asmGen.newTemp();
			asmCode.append("\tmov ax,"+$<Symbol>1->getIdValue()+"\n");
			asmCode.append("\tmov BX,"+$<Symbol>3->getIdValue()+"\n");
			asmCode.append("\tmul BX\n");
			asmCode.append("\tmov "+string(temp)+", ax\n");
			$<Symbol>$->setAssemblyCode(asmCode.getFinalCode());
			$<Symbol>$->setIdValue(temp);
			asmGen.vars.push_back(temp);

			}

		string name1 = $<Symbol>1->getName();

		string name2 = $<Symbol>2->getName();

		string name3 = $<Symbol>3->getName();

		$<Symbol>$->setName(name1+name2+name3);
	}
    ;
unary_expression: ADDOP unary_expression {
	$<Symbol>$ = TOKEN;
	if($<Symbol>2->getDeclarationType()=="void "){
		string err = "void Unary Expression";Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());
		$<Symbol>$->setDeclarationType("int ");
	}else {
		$<Symbol>$->setDeclarationType($<Symbol>2->getDeclarationType());
		AssemblyCode asmCode;asmCode.append($<Symbol>2->getAssemblyCode());
		//Since Unary Expression and we dont allow +val
		if($<Symbol>1->getName()=="-"){
			asmCode.append("\tmov ax,"+$<Symbol>2->getIdValue()+"\n");
			asmCode.append("\tNEG ax\n");
			asmCode.append("\tmov "+$<Symbol>2->getIdValue()+",ax\n");
		}
	}
	Util::parserLog(lines,"unary_expression : ADDOP-unary_expression");
	$<Symbol>$->setName($<Symbol>1->getName()+$<Symbol>2->getName());
	Util::parserLog($<Symbol>1->getName()+$<Symbol>2->getName());

	}
	| NOT unary_expression {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"unary_expression : NOT-unary_expression");
		Util::parserLog("!"+$<Symbol>2->getName());
		if($<Symbol>2->getDeclarationType()=="void "){
			string err = "void Unary Expression";
			yyerror(err.c_str());
			$<Symbol>$->setDeclarationType("int ");
			Util::appendLogError(lines,err,PARSER);
		}else
		{
			$<Symbol>$->setDeclarationType($<Symbol>2->getDeclarationType());
			AssemblyCode asmCode;asmCode.append($<Symbol>2->getAssemblyCode());
			asmCode.append("\tmov ax,"+$<Symbol>2->getIdValue()+"\n");
			asmCode.append("\tNOT ax\n");
			asmCode.append("\tmov "+$<Symbol>2->getIdValue()+",ax\n");

			$<Symbol>$->setAssemblyCode(asmCode.getFinalCode());
			$<Symbol>$->setIdValue($<Symbol>2->getIdValue());

		}
		$<Symbol>$->setName("!"+$<Symbol>2->getName());}
	| factor {
		if(DEBUG)cout<<$<Symbol>1->toString()<<endl;

		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"unary_expression : factor");
		$<Symbol>$->setName($<Symbol>1->getName());

		Util::parserLog($<Symbol>1->getName());
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType());
		$<Symbol>$->setAssemblyCode($<Symbol>1->getAssemblyCode());
		$<Symbol>$->setIdValue($<Symbol>1->getIdValue());

	}
	;
factor: variable {
		Util::parserLog(lines,"factor : variable");
		$<Symbol>$ = TOKEN;
		Util::parserLog($<Symbol>1->getName());
		$<Symbol>$->setName($<Symbol>1->getName());
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType());
		AssemblyCode asmCode;asmCode.append($<Symbol>1->getAssemblyCode());

		if($<Symbol>1->getType()=="array"){
			char *temp=asmGen.newTemp();
			asmCode.append("\tmov ax,"+$<Symbol>1->getIdValue()+"[BX]\n");
			asmCode.append("\tmov "+string(temp)+",ax\n");
			asmGen.vars.push_back(temp);
			$<Symbol>$->setIdValue(temp);

		}
		else{
			$<Symbol>$->setIdValue($<Symbol>1->getIdValue());
		}

		$<Symbol>$->setAssemblyCode(asmCode.getFinalCode());

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

			$<Symbol>$->setDeclarationType(s->getFunction()->getReturnType());

			if(DEBUG)cout<<lines<<" "<<argList.size()<<endl;

			int num = s->getFunction()->getParamCount();

			if(num!=argList.size()){
				string err = "Invalid number of arguments.Found :"+to_string(num)+" args Expected :"+to_string(argList.size())+" args";
				Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());

			}
			else{
				if(DEBUG)cout<<s->getFunction()->getReturnType()<<endl;

				vector<string>paramType = s->getFunction()->getAllParamTypes();
				vector<string>paramList = s->getFunction()->getAllParams();

				AssemblyCode asmCode;asmCode.append($<Symbol>3->getAssemblyCode());
				int len = argList.size();
				for(int i=0;i<len;i++){
					if(argList[i]->getDeclarationType()!=paramType[i]){
						string err = "Expected "+Util::trim(paramType[i])+" but passed "
						+ Util::trim(argList[i]->getDeclarationType())+" as "+to_string(i)+"th parameter";
						Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());
						break;
					}
					asmCode.append("\tmov ax,"+argList[i]->getIdValue()+"\n");
					asmCode.append("\tmov "+paramList[i]+",ax\n");
				}
				asmCode.append("\tcall "+$<Symbol>1->getName()+"\n");
				asmCode.append("\tmov ax,"+$<Symbol>1->getName()+"_return\n");
				char *temp=asmGen.newTemp();
				asmCode.append("\tmov "+string(temp)+",ax\n");
				$<Symbol>$->setAssemblyCode(asmCode.getFinalCode());
				$<Symbol>$->setIdValue(temp);
				asmGen.vars.push_back(temp);

			}
		}
		argList.clear();
		if(DEBUG)cout<<lines<<" "<<$<Symbol>$->getDeclarationType()<<endl;
		string name1 = $<Symbol>1->getName(),name3 = $<Symbol>3->getName();
		$<Symbol>$->setName(name1+"("+name3+")");
	}
	| LPAREN expression RPAREN {
		$<Symbol>$ = TOKEN;
		$<Symbol>$->setDeclarationType($<Symbol>2->getDeclarationType());

		Util::parserLog(lines,"factor : LPAREN-expression-RPAREN");
		$<Symbol>$->setName("("+$<Symbol>2->getName()+")");
		Util::parserLog("("+$<Symbol>2->getName()+")");
		$<Symbol>$->setAssemblyCode($<Symbol>2->getAssemblyCode());
		$<Symbol>$->setIdValue($<Symbol>2->getIdValue());

	}
	| CONST_INT {
		$<Symbol>$ = TOKEN;
		if(DEBUG)cout<<$<Symbol>1->toString()<<endl;
		Util::parserLog(lines,"factor : CONST_INT");
		$<Symbol>$->setDeclarationType("int ");
		Util::parserLog($<Symbol>1->getName());

		char *temp=asmGen.newTemp();
		AssemblyCode asmCode;asmCode.append("\tmov "+string(temp)+","+$<Symbol>1->getName()+"\n");
		$<Symbol>$->setAssemblyCode(asmCode.getFinalCode());
		$<Symbol>$->setIdValue(string(temp));

		$<Symbol>$->setName($<Symbol>1->getName());
		asmGen.vars.push_back(temp);

	}
	| CONST_FLOAT {
		Util::parserLog(lines,"factor : CONST_FLOAT");
		$<Symbol>$ = TOKEN;
		$<Symbol>$->setDeclarationType("float ");
		Util::parserLog($<Symbol>1->getName());
		$<Symbol>$->setName($<Symbol>1->getName());
		char *temp=asmGen.newTemp();
		AssemblyCode asmCode;asmCode.append("\tmov "+string(temp)+","+$<Symbol>1->getName()+"\n");
		$<Symbol>$->setAssemblyCode(asmCode.getFinalCode());
		$<Symbol>$->setIdValue(string(temp));
		asmGen.vars.push_back(temp);

	}
	| variable INCOP {
		Util::parserLog(lines,"factor : variable INCOP");

		$<Symbol>$ = TOKEN;
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType());

		Util::parserLog($<Symbol>1->getName()+"++");

		char *temp=asmGen.newTemp();
		AssemblyCode asmCode;asmCode.append("");
		if($<Symbol>1->getType()=="array"){
			asmCode.append("\tmov ax,"+$<Symbol>1->getIdValue()+"[BX]\n");
		}
		else
		asmCode.append("\tmov ax,"+$<Symbol>1->getIdValue()+"\n");
		asmCode.append("\tmov "+string(temp)+",ax\n");
		if($<Symbol>1->getType()=="array"){
			asmCode.append("\tmov ax,"+$<Symbol>1->getIdValue()+"[BX]\n");
			asmCode.append("\tinc ax\n");
			asmCode.append("\tmov "+$<Symbol>1->getIdValue()+"[BX],ax\n");
		}
		else
		asmCode.append("\tinc "+$<Symbol>1->getIdValue()+"\n");
		asmGen.vars.push_back(temp);

		$<Symbol>$->setName($<Symbol>1->getName()+"++");
		$<Symbol>$->setAssemblyCode(asmCode.getFinalCode());
		$<Symbol>$->setIdValue(temp);


	}
	| variable DECOP {
		Util::parserLog(lines,"factor : variable DECOP");
		$<Symbol>$ = TOKEN;
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType());
		Util::parserLog($<Symbol>1->getName()+"--");


		char *temp=asmGen.newTemp();
		AssemblyCode asmCode;asmCode.append("");
		if($<Symbol>1->getType()=="array"){
			asmCode.append("\tmov ax,"+$<Symbol>1->getIdValue()+"[BX]\n");
		}
		else asmCode.append("\tmov ax,"+$<Symbol>1->getIdValue()+"\n");
		asmCode.append("\tmov "+string(temp)+",ax\n");
		if($<Symbol>1->getType()=="array"){
			asmCode.append("\tmov ax,"+$<Symbol>1->getIdValue()+"[BX]\n");
			asmCode.append("\tdec ax\n");
			asmCode.append("\tmov "+$<Symbol>1->getIdValue()+"[BX],ax\n");
		}
		else asmCode.append("\tdec "+$<Symbol>1->getIdValue()+"\n");
		asmGen.vars.push_back(temp);

		$<Symbol>$->setName($<Symbol>1->getName()+"--");
		$<Symbol>$->setAssemblyCode(asmCode.getFinalCode());
		$<Symbol>$->setIdValue(temp);

	}
	;
//@Revised
argument_list: arguments {
		Util::parserLog(lines,"argument_list : arguments");
		$<Symbol>$ = TOKEN;
		Util::parserLog($<Symbol>1->getName());
		$<Symbol>$->setName($<Symbol>1->getName());
		$<Symbol>$->setAssemblyCode($<Symbol>1->getAssemblyCode());


	}
	| %empty {
		$<Symbol>$ = TOKEN;
		Util::parserLog(lines,"argument_list : %empty");
		Util::parserLog(lines,"");
		$<Symbol>$->setName("");}
	;
//@Revised
arguments: arguments COMMA logic_expression {

		$<Symbol>$ = TOKEN;
		$<Symbol>$->setName($<Symbol>1->getName()+","+$<Symbol>3->getName());

		Util::parserLog(lines,"arguments : arguments-COMMA-logic_expression ");
		argList.push_back($<Symbol>3);
		Util::parserLog($<Symbol>1->getName()+","+$<Symbol>3->getName());

		$<Symbol>$->setAssemblyCode($<Symbol>1->getAssemblyCode()+$<Symbol>3->getAssemblyCode());

	}
	| logic_expression {
		Util::parserLog(lines,"arguments : logic_expression");
		$<Symbol>$ = TOKEN;
		argList.push_back($<Symbol>1);
		Util::parserLog($<Symbol>1->getName());
		$<Symbol>$->setName($<Symbol>1->getName());

		$<Symbol>$->setAssemblyCode($<Symbol>1->getAssemblyCode());

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
	asmGen = AsmCodeGenerator();
	lines = 1;
	errors = 0;
	if((fp=fopen(fileName.c_str(),"r"))==NULL)
	{
		printf("Cannot Open Input File.\n");
	}
	yyin=fp;
	cout<<fileName<<endl;
	currentFile = fileName;
	symbolTable = new SymbolTable(100);
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
bool isRedundant(string s1,string s2){
	s1 = Util::trim(s1);
	s2 = Util::trim(s2);

	if(s1.size()!=s2.size()) return false;

	if(s1 == s2)return true;

	size_t isMov1 = s1.find("mov"),isMov2 = s2.find("mov");
	if(isMov1 == string::npos || isMov2 == string::npos) return false;

	vector<string> srcDest1,srcDest2;
	Util::split(s1.substr(3,s1.size()),srcDest1,',');
	Util::split(s2.substr(3,s2.size()),srcDest2,',');

	//cout<<srcDest1[0]<<srcDest1[1]<<endl;
	//cout<<srcDest2[0]<<srcDest2[1]<<endl;
	bool c1 = Util::trim(srcDest1[0]) == Util::trim(srcDest2[1]);
	bool c2 = Util::trim(srcDest1[1]) == Util::trim(srcDest2[0]);

	if(c1 && c2) return true;

	return false;
}
void optimization(string asmFile){
	vector<string> lines;
	Util::readAllFromFile(lines,asmFile);
	int len = lines.size();

	AssemblyCode optimized;
	bool isNotRequired[len]={false};

	cout<<"Need to Optimize"<<endl;

	for(int i=0;i<len-1;i++){
		if(isRedundant(lines[i],lines[i+1])){
			cout<<i+1<<":"<<lines[i+1]<<endl;
			isNotRequired[i+1] = true;
		}

	}
	cout<<"Skipping"<<endl;
	for(int i=0;i<len;i++){
		if(isNotRequired[i]){
			cout<<i<<":"<<lines[i]<<endl;
			continue;
		}
		optimized.append(lines[i]).append("\n");

	}
	asmGen.generateFinalAsmFile(asmFile.substr(0,asmFile.size()-4)+"_opt.asm",optimized.getFinalCode());

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
