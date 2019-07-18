%{
#include<iostream>
#include "headers/1605103_SymbolTable.h"

#define ERROR Util::appendLogError
#define LOG Util::parserLog

using namespace std;
int yyparse(void);
int yylex(void);

int lines=1,errors=0;
FILE *fp;
extern FILE *yyin;

bool DEBUG = false;

SymbolTable *symbolTable = new SymbolTable(100);
vector<pair<string,int>> possiblyUndefinedFunctions;
vector<SymbolInfo*>paramList,declarationList,argList;

void yyerror(char *s){
	cerr<<s<<" at Line:"<<lines<<endl;
}

%}

%token IF ELSE FOR WHILE DO BREAK
%token INT FLOAT CHAR DOUBLE VOID
%token RETURN SWITCH CASE DEFAULT CONTINUE
%token CONST_INT CONST_FLOAT CONST_CHAR
%token ADDOP MULOP INCOP RELOP ASSIGNOP LOGICOP BITOP NOT DECOP
%token LPAREN RPAREN LCURL RCURL LTHIRD RTHIRD COMMA SEMICOLON
%token STRING ID PRINTLN

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




//@DONE
program: program unit {
		
		$<Symbol>$ = new SymbolInfo();
		LOG(lines,"program -> program unit");
		LOG($<Symbol>1->getName()+" "+$<Symbol>2->getName()); 
		
		$<Symbol>$->setName($<Symbol>1->getName()+$<Symbol>2->getName());
	}

	| unit {

		$<Symbol>$ = new SymbolInfo();
		LOG(lines,"program -> unit");
		LOG($<Symbol>1->getName()+'\n');

		$<Symbol>$->setName($<Symbol>1->getName());
	}
	
	;


//@DONE
unit: var_declaration {

		$<Symbol>$=new SymbolInfo();
		LOG(lines,"unit -> var_declaration");
		LOG($<Symbol>1->getName()); 

		$<Symbol>$->setName($<Symbol>1->getName()+"\n");
	}
	
	| func_declaration {

		$<Symbol>$ = new SymbolInfo();
		LOG(lines,"unit -> func_declaration");
		LOG($<Symbol>1->getName()); 

		$<Symbol>$->setName($<Symbol>1->getName()+"\n");
	}
    
	| func_definition { 

		$<Symbol>$=new SymbolInfo();
		LOG(lines,"unit -> func_definition");
		LOG($<Symbol>1->getName());

		$<Symbol>$->setName($<Symbol>1->getName()+"\n");
	}
	
	;

//@DONE
func_declaration: type_specifier ID LPAREN parameter_list RPAREN SEMICOLON {

		$<Symbol>$=new SymbolInfo();
		LOG(lines,"func_declaration -> type_specifier ID LPAREN parameter_list RPAREN SEMICOLON");
		LOG($<Symbol>1->getName()+" "+$<Symbol>2->getName()+"("+$<Symbol>4->getName()+")");
		
		SymbolInfo *func = symbolTable->lookUp($<Symbol>2->getName());
		
		if(func != nullptr){
			int num=func->getFunction()->getParamCount();
			if(num == paramList.size()){
				vector<string>para_type = func->getFunction()->getAllParamTypes();
				for( int i=0;i < paramList.size(); i++){
					if(paramList[i]->getDeclarationType() != para_type[i]){
						errors++;
						ERROR(lines,"Type Mismatch ! Expected "+paramList[i]->getDeclarationType()+" Found "+ para_type[i] +" for "+to_string(i)+"th parameter",PARSER);
						break;
					}
				}
				if(func->getFunction()->getReturnType()!=$<Symbol>1->getName()){
					errors++;
					ERROR(lines,"Return Type Mismatch ! Expected "+func->getFunction()->getReturnType()+ " Found " + $<Symbol>1->getName(),PARSER);
				}
				paramList.clear();
			
			}else{
				errors++;
				ERROR(lines,"Invalid number of parameters ",PARSER);
			}	
		} 
		else{
			//TODO : Function
			symbolTable->insert($<Symbol>2->getName(),"ID","Function");
			func = symbolTable->lookUp($<Symbol>2->getName());
			func->set_isFunction();

			for(int i=0 ;i < paramList.size() ; i++){
				func->getFunction()->addParam(paramList[i]->getName(),paramList[i]->getDeclarationType());
				if(DEBUG)cout<<paramList[i]->getDeclarationType()<<endl;
			}
			paramList.clear();
			func->getFunction()->setReturnType($<Symbol>1->getName());			
		}

		$<Symbol>$->setName($<Symbol>1->getName()+" "+$<Symbol>2->getName()+"("+$<Symbol>4->getName()+");");

	}
	| type_specifier ID LPAREN RPAREN SEMICOLON {

			$<Symbol>$ = new SymbolInfo();
			
			LOG(lines,"func_declaration -> type_specifier ID LPAREN RPAREN SEMICOLON");
			LOG($<Symbol>1->getName()+" "+$<Symbol>2->getName()+"();");
			
			SymbolInfo *s=symbolTable->lookUp($<Symbol>2->getName());
			
			if(s == nullptr){

				//TODO : Function
				symbolTable->insert($<Symbol>2->getName(),"ID","Function");
				s=symbolTable->lookUp($<Symbol>2->getName());
				s->set_isFunction();
				s->getFunction()->setReturnType($<Symbol>1->getName());
			
			}
			else{

				if(s->getFunction()->getParamCount()!=0){
					errors++;
					ERROR(lines,"Invalid number of parameters! Expected 0 Found "+to_string(s->getFunction()->getParamCount()),PARSER);
		
				}
				if(s->getFunction()->getReturnType()!=$<Symbol>1->getName()){
					errors++;
					ERROR(lines," Return Type Does not Match! Expected "+s->getFunction()->getReturnType()+ " Found " +$<Symbol>1->getName(),PARSER);
				}

			}
			$<Symbol>$->setName($<Symbol>1->getName()+" "+$<Symbol>2->getName()+"();");
	}
	;


func_definition: type_specifier ID LPAREN parameter_list RPAREN {
		
		$<Symbol>$ = new SymbolInfo(); 
		SymbolInfo *s = symbolTable->lookUp($<Symbol>2->getName()); 

		if(s != nullptr){ 
			if(s->getFunction()->isDefined()==0){
				int num = s->getFunction()->getParamCount();
				if(num != paramList.size()){
					errors++;
					ERROR(lines,"Invalid number of parameters ",PARSER);
				} else{
					vector<string>para_type = s->getFunction()->getAllParamTypes();
					for(int i=0;i<paramList.size();i++){
						if(paramList[i]->getDeclarationType() != para_type[i]){
							errors++;
							ERROR(lines,"Type Mismatch ! Expected "+paramList[i]->getDeclarationType()+" Found "+para_type[i]+" for "+ to_string(i)+"th "+"Parameter",PARSER);
							break;
						}
					}
					if(s->getFunction()->getReturnType() != $<Symbol>1->getName()){
						errors++;
						ERROR(lines,"Return Type Mismatch ! Expected "+s->getFunction()->getReturnType()+ " Found " + $<Symbol>1->getName(),PARSER);
					}	
				}
				s->getFunction()->setDefined();
			}
			else{
				errors++;
				ERROR(lines,"Multiple definition of function "+$<Symbol>2->getName(),PARSER);
			}
		}
		else{ 
			if(DEBUG)cout<<paramList.size()<<" "<<lines<<endl;
			symbolTable->insert($<Symbol>2->getName(),"ID","Function");
			s = symbolTable->lookUp($<Symbol>2->getName());
			s->set_isFunction();
			if(DEBUG)cout<<s->getFunction()->getParamCount()<<endl;
			s->getFunction()->setDefined();
			
			for(int i=0;i<paramList.size();i++){
				s->getFunction()->addParam(paramList[i]->getName(),paramList[i]->getDeclarationType());
			}
			s->getFunction()->setReturnType($<Symbol>1->getName());
		}

	}
	compound_statement {
		LOG(lines,"func_definition -> type_specifier ID LPAREN parameter_list RPAREN compound_statement ");
		LOG($<Symbol>1->getName()+" "+$<Symbol>2->getName()+"("
		+$<Symbol>4->getName()+") "+ $<Symbol>7->getName());
		$<Symbol>$->setName($<Symbol>1->getName()+" "+$<Symbol>2->getName()+"("+$<Symbol>4->getName()+")"+$<Symbol>7->getName());
	}
	| type_specifier ID LPAREN RPAREN { 
		$<Symbol>$ = new SymbolInfo();
		SymbolInfo *s = symbolTable->lookUp($<Symbol>2->getName());
		if(s == nullptr){
			symbolTable->insert($<Symbol>2->getName(),"ID","Function");
			s = symbolTable->lookUp($<Symbol>2->getName());
			s -> set_isFunction();
			s -> getFunction()->setDefined();
			s -> getFunction()->setReturnType($<Symbol>1->getName());
			//	cout<<lines<<" "<<s->getFunction()->getReturnType()<<endl;
		}
		else if(s->getFunction()->isDefined()==0){
			if(s->getFunction()->getParamCount()!=0){
				errors++;
				ERROR(lines," Invalid number of parameters ",PARSER);
			}
			if(s->getFunction()->getReturnType()!=$<Symbol>1->getName()){
				errors++;
				ERROR(lines,"Return Type Mismatch ",PARSER);
			}

			s->getFunction()->setDefined();
		}
		else{
			errors++;
			ERROR(lines,"Multiple defination of function "+$<Symbol>2->getName(),PARSER);
		}
											
		$<Symbol>1->setName($<Symbol>1->getName()+" "+$<Symbol>2->getName()+"()");
	} compound_statement {
		LOG(lines,"func_definition->type_specifier ID LPAREN RPAREN compound_statement");
		LOG($<Symbol>1->getName()+" "+$<Symbol>6->getName());
		$<Symbol>$->setName($<Symbol>1->getName()+$<Symbol>6->getName());
			
	}
	;




//@DONE
parameter_list: parameter_list COMMA type_specifier ID {
		
		$<Symbol>$ = new SymbolInfo();
		LOG(lines,"parameter_list -> parameter_list COMMA type_specifier ID");
		LOG($<Symbol>1->getName()+","+$<Symbol>3->getName()+" "+$<Symbol>4->getName());
		
		paramList.push_back(new SymbolInfo($<Symbol>4->getName(),"ID",$<Symbol>3->getName()));
		$<Symbol>$->setName($<Symbol>1->getName()+","+$<Symbol>3->getName()+" "+$<Symbol>4->getName());
	}
	| parameter_list COMMA type_specifier {
		
		$<Symbol>$ = new SymbolInfo();
		LOG(lines,"parameter_list->parameter_list COMMA type_specifier");
		LOG($<Symbol>1->getName()+","+$<Symbol>3->getName());
		
		paramList.push_back(new SymbolInfo("","ID",$<Symbol>3->getName()));
		$<Symbol>$->setName($<Symbol>1->getName()+","+$<Symbol>3->getName());

	}
	| type_specifier ID {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"parameter_list -> type_specifier ID");
		LOG($<Symbol>1->getName()+" "+$<Symbol>2->getName());
		paramList.push_back(new SymbolInfo($<Symbol>2->getName(),"ID",$<Symbol>1->getName()));
		$<Symbol>$->setName($<Symbol>1->getName()+" "+$<Symbol>2->getName());
	}
	| type_specifier {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"parameter_list -> type_specifier");
		LOG($<Symbol>1->getName());
		paramList.push_back(new SymbolInfo("","ID",$<Symbol>1->getName()));
		$<Symbol>$->setName($<Symbol>1->getName()+" ");
	}
	;


//@DONE
compound_statement: LCURL {
	symbolTable->enterScope();
	//	cout<<lines<<" "<<paramList.size()<<endl;
	for(int i=0;i<paramList.size();i++)
		symbolTable->insert(paramList[i]->getName(),"ID",paramList[i]->getDeclarationType());
		//symbolTable->printcurrent();
	paramList.clear();
	} statements RCURL {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"compound_statement -> LCURL statements RCURL");
		LOG("{"+$<Symbol>3->getName()+"}");
		$<Symbol>$->setName("{\n"+$<Symbol>3->getName()+"\n}");
		symbolTable->printAllScopeTables();
		symbolTable->exitScope();
	}
	| LCURL RCURL {
		symbolTable->enterScope();
		for(int i=0;i<paramList.size();i++)
			symbolTable->insert(paramList[i]->getName(),"ID",paramList[i]->getDeclarationType());
		//symbolTable->printcurrent();
		paramList.clear();
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"compound_statement->LCURL RCURL");
		LOG("{}");
		$<Symbol>$->setName("{}");
		symbolTable->printAllScopeTables();
		symbolTable->exitScope();
	}
	;

//@DONE
var_declaration: type_specifier declarationList SEMICOLON {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"var_declaration -> type_specifier declarationList SEMICOLON");
		LOG($<Symbol>1->getName()+" "+$<Symbol>2->getName()+";");
		if($<Symbol>1->getName()=="void "){ 
			errors++;
			ERROR(lines,"Cannot Declare void Type",PARSER);																
		}
		else{
			for(int i=0;i < declarationList.size() ; i++){
				if(symbolTable->lookUpLocal(declarationList[i]->getName()) != nullptr){
					errors++;
					ERROR(lines,"Multiple Declaration of " + declarationList[i]->getName(),PARSER);
					continue;
				}
				if(declarationList[i]->getType().size()==3){ //"IDa"
					declarationList[i]->setType(declarationList[i]->getType().substr(0,declarationList[i]->getType().size () - 1));
					symbolTable->insert(declarationList[i]->getName(),declarationList[i]->getType(),$<Symbol>1->getName()+"array");
				} else symbolTable->insert(declarationList[i]->getName(),declarationList[i]->getType(),$<Symbol>1->getName());
			}
		}
		declarationList.clear();
		$<Symbol>$->setName($<Symbol>1->getName()+" "+$<Symbol>2->getName()+";");
	}
	;

//@DONE
type_specifier: INT {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"type_specifier -> INT");
		LOG("int ");
		$<Symbol>$->setName("int ");
	}
	| FLOAT  {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"type_specifier -> FLOAT");
		LOG("float ");
		$<Symbol>$->setName("float ");
	}
	| VOID  {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"type_specifier -> VOID");
		LOG("void ");
		$<Symbol>$->setName("void ");
	}
	;


//@DONE
declarationList: declarationList COMMA ID {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"declarationList -> declarationList COMMA ID");
		LOG($<Symbol>1->getName()+","+$<Symbol>3->getName());
		declarationList.push_back(new SymbolInfo($<Symbol>3->getName(),"ID"));
		$<Symbol>$->setName($<Symbol>1->getName()+","+$<Symbol>3->getName());
	}
	| declarationList COMMA ID LTHIRD CONST_INT RTHIRD {
		$<Symbol>$=new SymbolInfo();
		LOG($<Symbol>1->getName()+","+$<Symbol>3->getName()+"["+$<Symbol>5->getName()+"]");
		LOG(lines,"declarationList -> declarationList COMMA ID LTHIRD CONST_INT RTHIRD");
		
		declarationList.push_back(new SymbolInfo($<Symbol>3->getName(),"IDa")); //TODO : why IDa ?
		$<Symbol>$->setName($<Symbol>1->getName()+","+$<Symbol>3->getName()+"["+$<Symbol>5->getName()+"]");
	}
	| ID {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"declarationList -> ID");
		LOG($<Symbol>1->getName());
		declarationList.push_back(new SymbolInfo($<Symbol>1->getName(),"ID"));
		$<Symbol>$->setName($<Symbol>1->getName());
	}
	| ID LTHIRD CONST_INT RTHIRD {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"declarationList -> ID LTHIRD CONST_INT RTHIRD");
		LOG($<Symbol>1->getName()+"["+$<Symbol>3->getName()+"]");
		declarationList.push_back(new SymbolInfo($<Symbol>1->getName(),"IDa"));
		$<Symbol>$->setName($<Symbol>1->getName()+"["+$<Symbol>3->getName()+"]");
	}
	
	;

//@DONE
statements: statement {
		$<Symbol>$ = new SymbolInfo();
		LOG(lines,"statements -> statement");
		LOG($<Symbol>1->getName()); 
		$<Symbol>$->setName($<Symbol>1->getName());
	}
	| statements statement {
		$<Symbol>$ = new SymbolInfo();
		LOG(lines,"statements -> statements statement");
		LOG($<Symbol>1->getName()+" "+$<Symbol>2->getName()); 
		$<Symbol>$->setName($<Symbol>1->getName()+"\n"+$<Symbol>2->getName()); 
	}
	;

statement: var_declaration {
		$<Symbol>$ = new SymbolInfo();
		LOG(lines,"statement -> var_declaration");
		LOG($<Symbol>1->getName());
		$<Symbol>$->setName($<Symbol>1->getName()); 
	}
	| expression_statement {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"statement -> expression_statement");
		LOG($<Symbol>1->getName()); 
		$<Symbol>$->setName($<Symbol>1->getName()); 
	}
	| compound_statement {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"statement -> compound_statement");
		LOG($<Symbol>1->getName()); 
		$<Symbol>$->setName($<Symbol>1->getName()); 
	}
	| FOR LPAREN expression_statement expression_statement expression RPAREN statement {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"statement -> FOR LPAREN expression_statement expression_statement expression RPAREN statement");
		LOG("for("+$<Symbol>3->getName()+" "+$<Symbol>4->getName()+" "+
		$<Symbol>5->getName()+")\n"+$<Symbol>7->getName());
		
		if($<Symbol>3->getDeclarationType()=="void "){
			errors++;
			ERROR(lines,"Type Mismatch! Variable Cannot Be Declared void ",PARSER);
		}
		$<Symbol>$->setName("for("+$<Symbol>3->getName()+$<Symbol>4->getName()+$<Symbol>5->getName()+")\n"+$<Symbol>5->getName()); 
	}
	| IF LPAREN expression RPAREN statement %prec LOWER_THAN_ELSE {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"statement -> IF LPAREN expression RPAREN statement");
		LOG("if("+$<Symbol>3->getName()+")\n"+$<Symbol>5->getName());
		
		if($<Symbol>3->getDeclarationType()=="void "){
			errors++;
			ERROR(lines,"Type Mismatch! Variable Cannot Be Declared void ",PARSER);
		}
		$<Symbol>$->setName("if("+$<Symbol>3->getName()+")\n"+$<Symbol>5->getName()); 

	}
	| IF LPAREN expression RPAREN statement ELSE statement {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"statement->IF LPAREN expression RPAREN statement ELSE statement");
		LOG("if("+$<Symbol>3->getName()+")\n"+$<Symbol>5->getName()+"else\n"+$<Symbol>7->getName());
		if($<Symbol>3->getDeclarationType()=="void "){
			errors++;
			ERROR(lines," Type Mismatch 1",PARSER);
		}
		$<Symbol>$->setName("if("+$<Symbol>3->getName()+")\n"+$<Symbol>5->getName()+" else \n"+$<Symbol>7->getName()); 
	}

	| WHILE LPAREN expression RPAREN statement {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"statement->WHILE LPAREN expression RPAREN statement");
		LOG("while("+$<Symbol>3->getName()+")\n"+$<Symbol>5->getName());

		if($<Symbol>3->getDeclarationType()=="void "){
			errors++;
			ERROR(lines," Type Mismatch 2",PARSER);
		}
		$<Symbol>$->setName("while("+$<Symbol>3->getName()+")\n"+$<Symbol>5->getName()); 
	}
	| PRINTLN LPAREN ID RPAREN SEMICOLON {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"statement->PRINTLN LPAREN ID RPAREN SEMICOLON");
		LOG("\n ("+$<Symbol>3->getName()+")");
		$<Symbol>$->setName("\n("+$<Symbol>3->getName()+")"); 
	}
	| RETURN expression SEMICOLON {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"statement->RETURN expression SEMICOLON");
		LOG("return "+$<Symbol>2->getName());
		if($<Symbol>2->getDeclarationType()=="void "){
			errors++;
			ERROR(lines," Type Mismatch 3",PARSER);
			$<Symbol>$->setDeclarationType("int "); 
		}
		$<Symbol>$->setName("return "+$<Symbol>2->getName()+";"); 
	}
	;

expression_statement: SEMICOLON	{
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"expression_statement->SEMICOLON");
		LOG(";"); 
		$<Symbol>$->setName(";"); 
	}
	| expression SEMICOLON {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"expression_statement->expression SEMICOLON");
		LOG($<Symbol>1->getName()+";");
		$<Symbol>$->setName($<Symbol>1->getName()+";"); 
	}
	;

variable: ID {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"variable->ID");
		LOG($<Symbol>1->getName());
		if(symbolTable->lookUp($<Symbol>1->getName())==nullptr){
			errors++;
			ERROR(lines," Undeclared Variable: "+$<Symbol>1->getName(),PARSER);
		}
		else if(symbolTable->lookUp($<Symbol>1->getName())->getDeclarationType()=="int array" || symbolTable->lookUp($<Symbol>1->getName())->getDeclarationType()=="float array"){
			errors++;
			ERROR(lines," Found array: "+$<Symbol>1->getName()+" Expected Variable",PARSER);
		}
		if(symbolTable->lookUp($<Symbol>1->getName())!=nullptr){
			if(DEBUG)cout<<lines<<" "<<$<Symbol>1->toString()<<" "<<symbolTable->lookUp($<Symbol>1->getName())->getDeclarationType()<<endl;
			$<Symbol>$->setDeclarationType(symbolTable->lookUp($<Symbol>1->getName())->getDeclarationType()); 
		}
		$<Symbol>$->setName($<Symbol>1->getName()); 
												
	}
	| ID LTHIRD expression RTHIRD  {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"variable->ID LTHIRD expression RTHIRD");
		LOG($<Symbol>1->getName()+"["+$<Symbol>3->getName()+"]");
		if(symbolTable->lookUp($<Symbol>1->getName())==nullptr){
			errors++;
			ERROR(lines,"Undeclared Variable :"+ $<Symbol>1->getName(),PARSER);
		}
		if(DEBUG)cout<<lines<<" "<<$<Symbol>3->getDeclarationType()<<endl;
		if($<Symbol>3->getDeclarationType()=="float "||$<Symbol>3->getDeclarationType()=="void "){
			errors++;
			ERROR(lines," Non-integer Array Index  ",PARSER);
		}
		if(symbolTable->lookUp($<Symbol>1->getName())!=nullptr){
			if(DEBUG)cout<<lines<<" "<<symbolTable->lookUp($<Symbol>1->getName())->toString()<<endl;
			if(symbolTable->lookUp($<Symbol>1->getName())->getDeclarationType()!="int array" && symbolTable->lookUp($<Symbol>1->getName())->getDeclarationType()!="float array"){
				errors++;
				ERROR(lines," Type Mismatch 4",PARSER);	
			}
			if(symbolTable->lookUp($<Symbol>1->getName())->getDeclarationType()=="int array"){
				$<Symbol>1->setDeclarationType("int ");
			}
			if(symbolTable->lookUp($<Symbol>1->getName())->getDeclarationType()=="float array"){
				$<Symbol>1->setDeclarationType("float ");
			}
			$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType()); 
			
		}
		$<Symbol>$->setName($<Symbol>1->getName()+"["+$<Symbol>3->getName()+"]");  
		
	}
	;
expression: logic_expression {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"expression->logic_expression");
		LOG($<Symbol>1->getName());
		$<Symbol>$->setName($<Symbol>1->getName()); 
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType()); 
	}
	| variable ASSIGNOP logic_expression {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"expression->variable ASSIGNOP logic_expression");
	   	LOG($<Symbol>1->getName()+"="+$<Symbol>3->getName());
		
		if($<Symbol>3->getDeclarationType()=="void "){
			errors++;
			ERROR(lines," Type Mismatch 5",PARSER);
			$<Symbol>$->setDeclarationType("int "); 
		}else if(symbolTable->lookUp($<Symbol>1->getName()) != nullptr) {
			if(DEBUG)cout<<lines<<" "<<symbolTable->lookUp($<Symbol>1->getName())->toString()<<""<<$<Symbol>3->toString()<<endl;
			if(symbolTable->lookUp($<Symbol>1->getName())->getDeclarationType()!=$<Symbol>3->getDeclarationType()){
				errors++;
				ERROR(lines,"Type Mismatch 6",PARSER);

				LOG(lines,"Type Mismatch 6");
			}
		}
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType()); 
		$<Symbol>$->setName($<Symbol>1->getName()+"="+$<Symbol>3->getName());  

	}
	;
logic_expression: rel_expression {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"logic_expression->rel_expression");
		LOG($<Symbol>1->getName());
		$<Symbol>$->setName($<Symbol>1->getName()); 
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType()); 
	}
	| rel_expression LOGICOP rel_expression {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"logic_expression->rel_expression LOGICOP rel_expression");
		LOG($<Symbol>1->getName()+$<Symbol>2->getName()+$<Symbol>3->getName());
		
		if($<Symbol>1->getDeclarationType()=="void "||$<Symbol>3->getDeclarationType()=="void "){
			errors++;
			ERROR(lines," Type Mismatch 7",PARSER);
			$<Symbol>$->setDeclarationType("int "); 
		}
		$<Symbol>$->setDeclarationType("int "); 
		$<Symbol>$->setName($<Symbol>1->getName()+$<Symbol>2->getName()+$<Symbol>3->getName());  

	}
	;

rel_expression: simple_expression {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"rel_expression->simple_expression");
		LOG($<Symbol>1->getName());
		$<Symbol>$->setName($<Symbol>1->getName()); 
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType()); 
	}
	| simple_expression RELOP simple_expression	 {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"rel_expression->simple_expression RELOP simple_expression");
		LOG($<Symbol>1->getName()+$<Symbol>2->getName()+$<Symbol>3->getName());
		if($<Symbol>1->getDeclarationType()=="void "||$<Symbol>3->getDeclarationType()=="void "){
			errors++;
			ERROR(lines," Type Mismatch! 8",PARSER);
			$<Symbol>$->setDeclarationType("int "); 
		}
		$<Symbol>$->setDeclarationType("int "); 	
		$<Symbol>$->setName($<Symbol>1->getName()+$<Symbol>2->getName()+$<Symbol>3->getName());  
		}
	;

simple_expression: term {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"simple_expression -> term");
		LOG($<Symbol>1->getName());
		if(DEBUG)cout<<$<Symbol>1->toString()<<endl;
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType());
		$<Symbol>$->setName($<Symbol>1->getName());  
	}
	| simple_expression ADDOP term {
		$<Symbol>$=new SymbolInfo(); 
		LOG(lines,"simple_expression -> simple_expression ADDOP term");
		LOG($<Symbol>1->getName()+$<Symbol>2->getName()+$<Symbol>3->getName());
		if(DEBUG)cout<<$<Symbol>3->getDeclarationType()<<endl;
		if($<Symbol>1->getDeclarationType()=="void "||$<Symbol>3->getDeclarationType()=="void "){
			errors++;
			ERROR(lines,"Type Mismatch 9",PARSER);
			$<Symbol>$->setDeclarationType("int "); 
		}else if($<Symbol>1->getDeclarationType()=="float " || $<Symbol>3->getDeclarationType()=="float ")
			$<Symbol>$->setDeclarationType("float ");
		else $<Symbol>$->setDeclarationType("int ");
		
		$<Symbol>$->setName($<Symbol>1->getName()+$<Symbol>2->getName()+$<Symbol>3->getName());  
	}
	;

term: unary_expression {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"term->unary_expression");
		LOG($<Symbol>1->getName()); 
		if(DEBUG)cout<<$<Symbol>1->toString()<<endl;
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType()); 
		$<Symbol>$->setName($<Symbol>1->getName()); 
	}
    | term MULOP unary_expression {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"term->term MULOP unary_expression");
		LOG($<Symbol>1->getName()+$<Symbol>2->getName()+$<Symbol>3->getName());
		if($<Symbol>1->getDeclarationType()=="void "||$<Symbol>3->getDeclarationType()=="void "){
			errors++;
			ERROR(lines," Type Mismatch 10",PARSER);
			$<Symbol>$->setDeclarationType("int "); 
		}else if($<Symbol>2->getName()=="%"){
			if($<Symbol>1->getDeclarationType()!="int " ||$<Symbol>3->getDeclarationType()!="int "){
			errors++;
			ERROR(lines," Integer operand on modulus(%) operator  ",PARSER);

			} 
			$<Symbol>$->setDeclarationType("int "); 
		}
		else if($<Symbol>2->getName()=="/"){
			if($<Symbol>1->getDeclarationType()=="void "||$<Symbol>3->getDeclarationType()=="void "){
				errors++;
				ERROR(lines," Type Mismatch 11",PARSER);
				$<Symbol>$->setDeclarationType("int "); 
			}
			else  if($<Symbol>1->getDeclarationType()=="int " && $<Symbol>3->getDeclarationType()=="int ")
				$<Symbol>$->setDeclarationType("int "); 
			else $<Symbol>$->setDeclarationType("float "); 
			
		}
		else{
			if($<Symbol>1->getDeclarationType()=="void "||$<Symbol>3->getDeclarationType()=="void "){
				errors++;
				ERROR(lines," Type Mismatch!",PARSER);
				$<Symbol>$->setDeclarationType("int "); 
			}
			else  if($<Symbol>1->getDeclarationType()=="float " || $<Symbol>3->getDeclarationType()=="float ") $<Symbol>$->setDeclarationType("float "); 
			else $<Symbol>$->setDeclarationType("int "); 
		}
	
		$<Symbol>$->setName($<Symbol>1->getName()+$<Symbol>2->getName()+$<Symbol>3->getName()); 
								
	}
    ;

unary_expression: ADDOP unary_expression {
	$<Symbol>$ = new SymbolInfo();
	LOG(lines,"unary_expression->ADDOP unary_expression");
	LOG($<Symbol>1->getName()+$<Symbol>2->getName());
	if($<Symbol>2->getDeclarationType()=="void "){
		errors++;
		ERROR(lines," Type Mismatch 12",PARSER);
		$<Symbol>$->setDeclarationType("int "); 
	}else $<Symbol>$->setDeclarationType($<Symbol>2->getDeclarationType()); 	
	$<Symbol>$->setName($<Symbol>1->getName()+$<Symbol>2->getName()); 
	}
	| NOT unary_expression {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"unary_expression->NOT unary_expression");
		LOG("!"+$<Symbol>2->getName()); 
		if($<Symbol>2->getDeclarationType()=="void "){
			errors++;
			ERROR(lines," Type Mismatch 13",PARSER);
			$<Symbol>$->setDeclarationType("int "); 
		}else $<Symbol>$->setDeclarationType($<Symbol>2->getDeclarationType());  
		$<Symbol>$->setName("!"+$<Symbol>2->getName()); 
	}
	| factor {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"unary_expression->factor");
		LOG($<Symbol>1->getName()); 
		if(DEBUG)cout<<$<Symbol>1->toString()<<endl;
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType()); 
		$<Symbol>$->setName($<Symbol>1->getName()); 
				
	}
	;

factor: variable {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"factor->variable");
		LOG($<Symbol>1->getName());
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType()); 
		$<Symbol>$->setName($<Symbol>1->getName()); 
	}
	| ID LPAREN argument_list RPAREN {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"factor->ID LPAREN argument_list RPAREN");
		LOG($<Symbol>1->getName()+"("+$<Symbol>3->getName()+")");
		SymbolInfo* s=symbolTable->lookUp($<Symbol>1->getName());
		if(s==nullptr){
			errors++;
			ERROR(lines,"Undeclared Function",PARSER);
			$<Symbol>$->setDeclarationType("int "); 
		}
		else if(s->getFunction()==nullptr){
			errors++;
			ERROR(lines," Not A Function ",PARSER);
			$<Symbol>$->setDeclarationType("int "); 
		}
		else {
			if(s->getFunction()->isDefined()==0){
				pair<string,int> p;
				p.first = s->getName();
				p.second = lines;
				possiblyUndefinedFunctions.push_back(p);
			}
			int num=s->getFunction()->getParamCount();
			
			if(DEBUG)cout<<lines<<" "<<argList.size()<<endl;
			
			$<Symbol>$->setDeclarationType(s->getFunction()->getReturnType());
			if(num!=argList.size()){
				errors++;
				ERROR(lines,"Invalid number of arguments",PARSER);
			}
			else{
				if(DEBUG)cout<<s->getFunction()->getReturnType()<<endl;
				vector<string>paramList=s->getFunction()->getAllParams();
				vector<string>para_type=s->getFunction()->getAllParamTypes();
				
				for(int i=0;i<argList.size();i++){
					if(argList[i]->getDeclarationType()!=para_type[i]){
						errors++;
						ERROR(lines,"Type Mismatch 14",PARSER);
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
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"factor->LPAREN expression RPAREN");
		LOG("("+$<Symbol>2->getName()+")"); 
		$<Symbol>$->setDeclarationType($<Symbol>2->getDeclarationType()); 
		$<Symbol>$->setName("("+$<Symbol>2->getName()+")"); 
	}
	| CONST_INT { 
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"factor -> CONST_INT");
		LOG($<Symbol>1->getName());
		if(DEBUG)cout<<$<Symbol>1->toString()<<endl;
		$<Symbol>$->setDeclarationType("int "); 	
		$<Symbol>$->setName($<Symbol>1->getName()); 
			
	}
	| CONST_FLOAT {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"factor->CONST_FLOAT");
		LOG($<Symbol>1->getName()); 
		$<Symbol>$->setDeclarationType("float "); 	
		$<Symbol>$->setName($<Symbol>1->getName()); 
				
	}
	| variable INCOP {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"factor->variable INCOP");
		LOG($<Symbol>1->getName()+"++"); 
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType());
		$<Symbol>$->setName($<Symbol>1->getName()+"++"); 
					 
	}
	| variable DECOP {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"factor->variable DECOP");
		LOG($<Symbol>1->getName()+"--");
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType()); 
		$<Symbol>$->setName($<Symbol>1->getName()+"--"); 
					 
	}
	;

argument_list: arguments {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"argument_list->arguments");
		LOG($<Symbol>1->getName());
		$<Symbol>$->setName($<Symbol>1->getName());
	}
	| %empty {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"argument_list-> ");
		$<Symbol>$->setName("");}
	;

arguments: arguments COMMA logic_expression {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"arguments->arguments COMMA logic_expression ");
		LOG($<Symbol>1->getName()+","+$<Symbol>3->getName());
		argList.push_back($<Symbol>3);
		$<Symbol>$->setName($<Symbol>1->getName()+","+$<Symbol>3->getName());
	}
	| logic_expression {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"arguments->logic_expression");
		LOG($<Symbol>1->getName()); 
		argList.push_back(new SymbolInfo($<Symbol>1->getName(),$<Symbol>1->getType(),$<Symbol>1->getDeclarationType()));
		// cout<<$<Symbol>1->getDeclarationType()<<endl;
		$<Symbol>$->setName($<Symbol>1->getName());					
	}
	;
 %%

void endingRoutine(){
	for(int i=0;i < possiblyUndefinedFunctions.size();i++){
		if(!symbolTable->lookUp(possiblyUndefinedFunctions[i].first)->getFunction()->isDefined()){
			ERROR(possiblyUndefinedFunctions[i].second,"Calling Undefined Function "+possiblyUndefinedFunctions[i].first,PARSER);
			errors++;
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
	LOG("\n\n^^^^^^^^^^^Parsing "+fileName+"^^^^^^^^^^^\n\n");
	ERROR("\n\n^^^^^^^^^^^Parsing "+fileName+"^^^^^^^^^^^\n\n",PARSER);
	yyparse();
	endingRoutine();
	LOG("Final SymbolTable : ");
	symbolTable->printAllScopeTables();
	LOG("Total Lines :"+to_string(lines));
	LOG("Total Errors :"+to_string(errors));
	cout<<"Total Lines :"<<lines<<endl;
	cout<<"Total Errors :"<<errors<<endl;
	ERROR("\nTotal Errors :"+to_string(errors)+'\n',PARSER);
	fclose(fp);
	LOG("\n\n^^^^^^^^^^^Finished Parsing "+fileName+"^^^^^^^^^^^\n\n");
	
	
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


