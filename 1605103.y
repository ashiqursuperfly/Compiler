%{
#include<iostream>
#include<cstdio>
#include<cstdlib>
#include<cstring>
#include<cmath>

#include "1605103_SymbolTable.h"
//#define YYSTYPE SymbolInfo*

using namespace std;

int yyparse(void);
int yylex(void);
extern FILE *yyin;
FILE *fp;

int lines=1;
int errors=0;

SymbolTable *symbolTable=new SymbolTable(100);

vector<SymbolInfo*>param_list;
vector<SymbolInfo*>declaration_list;
vector<SymbolInfo*>arg_list;


void yyerror(char *s){
	fprintf(stderr,"Line no %d : %s\n",s);
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
	SymbolInfo* symbolinfo;
	vector<string>*s;
}

%type <s>start


%%
//@DONE
start: program {	}
	;




//@DONE
program: program unit {
		
		$<symbolinfo>$ = new SymbolInfo();
		parserLog(lines,"program->program unit");
		parserLog($<symbolinfo>1->getName()+" "+$<symbolinfo>2->getName()); 
		
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+$<symbolinfo>2->getName());
	}

	| unit {

		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"program->unit");
		parserLog($<symbolinfo>1->getName());

		$<symbolinfo>$->setName($<symbolinfo>1->getName());
	}
	
	;


//@DONE
unit: var_declaration {

		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"unit->var_declaration");
		parserLog($<symbolinfo>1->getName()); 

		$<symbolinfo>$->setName($<symbolinfo>1->getName()+"\n");
	}
	
	| func_declaration {

		$<symbolinfo>$ = new SymbolInfo();
		parserLog(lines,"unit->func_declaration");
		parserLog($<symbolinfo>1->getName()); 

		$<symbolinfo>$->setName($<symbolinfo>1->getName()+"\n");
	}
    
	| func_definition { 

		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"unit->func_definition");
		parserLog($<symbolinfo>1->getName());

		$<symbolinfo>$->setName($<symbolinfo>1->getName()+"\n");
	}
	
	;


func_declaration: type_specifier ID LPAREN parameter_list RPAREN SEMICOLON {

		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"func_declaration->type_specifier ID LPAREN parameter_list RPAREN SEMICOLON");
		parserLog($<symbolinfo>1->getName()+" "+$<symbolinfo>2->getName()+"("+$<symbolinfo>4->getName()+")");
		
		SymbolInfo *s = symbolTable->lookUp($<symbolinfo>2->getName());
		
		if(s == nullptr){
			
			//TODO : Function
			symbolTable->insert(SymbolInfo($<symbolinfo>2->getName(),"ID","Function"));

			s = symbolTable->lookUp($<symbolinfo>2->getName());

			s->set_isFunction();
			
			for(int i=0 ;i < param_list.size() ; i++){
			
				s->get_isFunction()->add_number_of_parameter(param_list[i]->getName(),param_list[i]->getDeclarationType());
				//cout<<param_list[i]->getDeclarationType()<<endl;
			}
			param_list.clear();
			s->get_isFunction()->set_return_type($<symbolinfo>1->getName());
		} 
		else{
			int num=s->get_isFunction()->get_number_of_parameter();
			
			if(num!=param_list.size()){
			
				errors++;
				appendLogError(lines,"Invalid number of parameters ");
			
			}else{
				vector<string>para_type=s->get_isFunction()->get_paratype();
				for( int i=0;i < param_list.size(); i++){
					if(param_list[i]->getDeclarationType()!=para_type[i]){
						errors++;
						appendLogError(lines,"Type Mismatch ! Expected "+param_list[i]->getDeclarationType()+" Found "+ para_type[i] +" for "+to_string(i)+"th parameter");
						break;
					}
				}
				if(s->get_isFunction()->get_return_type()!=$<symbolinfo>1->getName()){
					errors++;
					appendLogError(lines,"Return Type Mismatch ! Expected "+s->get_isFunction()->get_return_type()+ " Found " + $<symbolinfo>1->getName());
				}
				param_list.clear();
			}
		}

		$<symbolinfo>$->setName($<symbolinfo>1->getName()+" "+$<symbolinfo>2->getName()+"("+$<symbolinfo>4->getName()+");");

	}
	| type_specifier ID LPAREN RPAREN SEMICOLON {

			$<symbolinfo>$ = new SymbolInfo();
			
			parserLog(lines,"func_declaration->type_specifier ID LPAREN RPAREN SEMICOLON");
			parserLog($<symbolinfo>1->getName()+" "+$<symbolinfo>2->getName()+"();");
			
			SymbolInfo *s=symbolTable->lookUp($<symbolinfo>2->getName());
			
			if(s == nullptr){

				//TODO : Function
				symbolTable->insert(SymbolInfo($<symbolinfo>2->getName(),"ID","Function"));
				s=symbolTable->lookUp($<symbolinfo>2->getName());
				s->set_isFunction();
				s->get_isFunction()->set_return_type($<symbolinfo>1->getName());
			
			}
			else{

				if(s->get_isFunction()->get_number_of_parameter()!=0){
					errors++;
					appendLogError(lines,"Invalid number of parameters ");
		
				}
				if(s->get_isFunction()->get_return_type()!=$<symbolinfo>1->getName()){
					errors++;
					appendLogError(lines," Return Type Mismatch ! Expected "+s->get_isFunction()->get_return_type()+ " Found " +$<symbolinfo>1->getName());
				}

			}
			$<symbolinfo>$->setName($<symbolinfo>1->getName()+" "+$<symbolinfo>2->getName()+"();");
	}
	;

func_definition: type_specifier ID LPAREN parameter_list RPAREN {
		
		$<symbolinfo>$=new SymbolInfo(); 
		SymbolInfo *s=symbolTable->lookUp($<symbolinfo>2->getName()); 

		if(s!=0){ 
			if(s->get_isFunction()->get_isdefined()==0){
				int num = s->get_isFunction()->get_number_of_parameter();
				if(num != param_list.size()){
					errors++;
					appendLogError(lines," Invalid number of parameters ");
				} else{
					vector<string>para_type=s->get_isFunction()->get_paratype();
					for(int i=0;i<param_list.size();i++){
						if(param_list[i]->getDeclarationType()!=para_type[i]){
							errors++;
							appendLogError(lines,"Type Mismatch Expected! "+param_list[i]->getDeclarationType()+" Found "+para_type[i]+" for "+ to_string(i)+"th "+"Parameter");
							break;
						}
					}
					if(s->get_isFunction()->get_return_type() != $<symbolinfo>1->getName()){
						errors++;
						appendLogError(lines,"Return Type Mismatch ! Expected "+s->get_isFunction()->get_return_type()+ " Found " + $<symbolinfo>1->getName());
					}	
				}
				s->get_isFunction()->set_isdefined();
			}
			else{
				errors++;
				appendLogError(lines,"Multiple defination of function "+$<symbolinfo>2->getName());
			}
		}
		else{ 
			//cout<<param_list.size()<<" "<<lines<<endl;
			symbolTable->insert(SymbolInfo($<symbolinfo>2->getName(),"ID","Function"));
			s=symbolTable->lookUp($<symbolinfo>2->getName());
			s->set_isFunction();
			//cout<<s->get_isFunction()->get_number_of_parameter()<<endl;
			s->get_isFunction()->set_isdefined();
			
			for(int i=0;i<param_list.size();i++){
				s->get_isFunction()->add_number_of_parameter(param_list[i]->getName(),param_list[i]->getDeclarationType());
				//	cout<<param_list[i]->getDeclarationType()<<param_list[i]->getName()<<endl;
			}
			//	param_list.clear();
			s->get_isFunction()->set_return_type($<symbolinfo>1->getName());
			//cout<<lines<<" "<<s->get_isFunction()->get_return_type()<<endl;
		}

	}
	compound_statement {
		parserLog("func_definition->type_specifier ID LPAREN parameter_list RPAREN compound_statement ");
		parserLog($<symbolinfo>1->getName()+" "+$<symbolinfo>2->getName()+"("
		+$<symbolinfo>4->getName()+")"+ $<symbolinfo>7->getName());
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+" "+$<symbolinfo>2->getName()+"("+$<symbolinfo>4->getName()+")"+$<symbolinfo>7->getName());
	}
	| type_specifier ID LPAREN RPAREN { 
		$<symbolinfo>$=new SymbolInfo();
		SymbolInfo *s = symbolTable->lookUp($<symbolinfo>2->getName());
		if(s==0){
			symbolTable->insert(SymbolInfo($<symbolinfo>2->getName(),"ID","Function"));
			s = symbolTable->lookUp($<symbolinfo>2->getName());
			s -> set_isFunction();
			s -> get_isFunction()->set_isdefined();
			s -> get_isFunction()->set_return_type($<symbolinfo>1->getName());
			//	cout<<lines<<" "<<s->get_isFunction()->get_return_type()<<endl;
		}
		else if(s->get_isFunction()->get_isdefined()==0){
			if(s->get_isFunction()->get_number_of_parameter()!=0){
				errors++;
				appendLogError(lines," Invalid number of parameters ");
			}
			if(s->get_isFunction()->get_return_type()!=$<symbolinfo>1->getName()){
				errors++;
				appendLogError(lines,"Return Type Mismatch ");
			}

			s->get_isFunction()->set_isdefined();
		}
		else{
			errors++;
			appendLogError(lines,"Multiple defination of function "+$<symbolinfo>2->getName());
		}
											
		$<symbolinfo>1->setName($<symbolinfo>1->getName()+" "+$<symbolinfo>2->getName()+"()");
	} compound_statement {
		parserLog("func_definition->type_specifier ID LPAREN RPAREN compound_statement");
		parserLog($<symbolinfo>1->getName()+" "+$<symbolinfo>6->getName());
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+$<symbolinfo>6->getName());
			
	}
	;




//@DONE
parameter_list: parameter_list COMMA type_specifier ID {
		
		$<symbolinfo>$ = new SymbolInfo();
		parserLog(lines,"parameter_list -> parameter_list COMMA type_specifier ID");
		parserLog($<symbolinfo>1->getName()+","+$<symbolinfo>3->getName()+" "+$<symbolinfo>4->getName());
		
		param_list.push_back(new SymbolInfo($<symbolinfo>4->getName(),"ID",$<symbolinfo>3->getName()));
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+","+$<symbolinfo>3->getName()+" "+$<symbolinfo>4->getName());
	}
	| parameter_list COMMA type_specifier {
		
		$<symbolinfo>$ = new SymbolInfo();
		parserLog(lines,"parameter_list->parameter_list COMMA type_specifier");
		parserLog($<symbolinfo>1->getName()+","+$<symbolinfo>3->getName());
		
		param_list.push_back(new SymbolInfo("","ID",$<symbolinfo>3->getName()));
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+","+$<symbolinfo>3->getName());

	}
	| type_specifier ID {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"parameter_list -> type_specifier ID");
		parserLog($<symbolinfo>1->getName()+" "+$<symbolinfo>2->getName());
		param_list.push_back(new SymbolInfo($<symbolinfo>2->getName(),"ID",$<symbolinfo>1->getName()));
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+" "+$<symbolinfo>2->getName());
	}
	| type_specifier {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"parameter_list -> type_specifier");
		parserLog($<symbolinfo>1->getName());
		param_list.push_back(new SymbolInfo("","ID",$<symbolinfo>1->getName()));
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+" ");
	}
	;


//@DONE
compound_statement: LCURL {
	symbolTable->enterScope();
	//	cout<<lines<<" "<<param_list.size()<<endl;
	for(int i=0;i<param_list.size();i++)
		symbolTable->insert(SymbolInfo(param_list[i]->getName(),"ID",param_list[i]->getDeclarationType()));
		//symbolTable->printcurrent();
	param_list.clear();
	} statements RCURL {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"compound_statement -> LCURL statements RCURL");
		parserLog("{$<symbolinfo>3->getName()}");
		$<symbolinfo>$->setName("{\n"+$<symbolinfo>3->getName()+"\n}");
		symbolTable->printAllScopeTables();
		symbolTable->exitScope();
	}
	| LCURL RCURL {
		symbolTable->enterScope();
		for(int i=0;i<param_list.size();i++)
			symbolTable->insert(SymbolInfo(param_list[i]->getName(),"ID",param_list[i]->getDeclarationType()));
		//symbolTable->printcurrent();
		param_list.clear();
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"compound_statement->LCURL RCURL");
		parserLog("{}");
		$<symbolinfo>$->setName("{}");
		symbolTable->printAllScopeTables();
		symbolTable->exitScope();
	}
	;

//@DONE
var_declaration: type_specifier declaration_list SEMICOLON {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"var_declaration -> type_specifier declaration_list SEMICOLON");
		parserLog($<symbolinfo>1->getName()+" "+$<symbolinfo>2->getName()+";");
		if($<symbolinfo>1->getName()=="void "){
			errors++;
			appendLogError(lines,"Cannot Declare void Type");																
		}
		else{
			for(int i=0;i < declaration_list.size() ; i++){
				if(symbolTable->lookUpLocal(declaration_list[i]->getName())){
					errors++;
					appendLogError(lines," Multiple Declaration of " + declaration_list[i]->getName());
					continue;
				}
				if(declaration_list[i]->getType().size()==3){
					declaration_list[i]->setType(declaration_list[i]->getType().substr(0,declaration_list[i]->getType().size () - 1));
					symbolTable->insert(SymbolInfo(declaration_list[i]->getName(),declaration_list[i]->getType(),$<symbolinfo>1->getName()+"array"));
				} else symbolTable->insert(SymbolInfo(declaration_list[i]->getName(),declaration_list[i]->getType(),$<symbolinfo>1->getName()));
			}
		}
		declaration_list.clear();
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+" "+$<symbolinfo>2->getName()+";");
	}
	;

//@DONE
type_specifier: INT {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"type_specifier -> INT");
		parserLog("int ");
		$<symbolinfo>$->setName("int ");
	}
	| FLOAT  {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"type_specifier -> FLOAT");
		parserLog("float ");
		$<symbolinfo>$->setName("float ");
	}
	| VOID  {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"type_specifier -> VOID");
		parserLog("void ");
		$<symbolinfo>$->setName("void ");
	}
	;


//@DONE
declaration_list: declaration_list COMMA ID {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"declaration_list -> declaration_list COMMA ID");
		parserLog($<symbolinfo>1->getName()+","+$<symbolinfo>3->getName());
		declaration_list.push_back(new SymbolInfo($<symbolinfo>3->getName(),"ID"));
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+","+$<symbolinfo>3->getName());
	}
	| declaration_list COMMA ID LTHIRD CONST_INT RTHIRD {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"declaration_list -> declaration_list COMMA ID LTHIRD CONST_INT RTHIRD");
		parserLog($<symbolinfo>1->getName()+","+$<symbolinfo>3->getName()+"["+$<symbolinfo>5->getName()+"]");
		
		declaration_list.push_back(new SymbolInfo($<symbolinfo>3->getName(),"IDa")); //TODO : why IDa ?
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+","+$<symbolinfo>3->getName()+"["+$<symbolinfo>5->getName()+"]");
	}
	| ID {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"declaration_list -> ID");
		parserLog($<symbolinfo>1->getName());
		declaration_list.push_back(new SymbolInfo($<symbolinfo>1->getName(),"ID"));
		$<symbolinfo>$->setName($<symbolinfo>1->getName());
	}
	| ID LTHIRD CONST_INT RTHIRD {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"declaration_list -> ID LTHIRD CONST_INT RTHIRD");
		parserLog($<symbolinfo>1->getName()+"["+$<symbolinfo>3->getName()+"]");
		declaration_list.push_back(new SymbolInfo($<symbolinfo>1->getName(),"IDa"));
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+"["+$<symbolinfo>3->getName()+"]");
	}
	;

//@DONE
statements: statement {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"statements -> statement");
		parserLog($<symbolinfo>1->getName()); 
		$<symbolinfo>$->setName($<symbolinfo>1->getName());
	}
	| statements statement {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"statements -> statements statement");
		parserLog($<symbolinfo>1->getName()+" "+$<symbolinfo>2->getName()); 
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+"\n"+$<symbolinfo>2->getName()); 
	}
	;

statement: var_declaration {
		$<symbolinfo>$ = new SymbolInfo();
		parserLog(lines,"statement -> var_declaration");
		parserLog($<symbolinfo>1->getName());
		$<symbolinfo>$->setName($<symbolinfo>1->getName()); 
	}
	| expression_statement {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"statement -> expression_statement");
		parserLog($<symbolinfo>1->getName()); 
		$<symbolinfo>$->setName($<symbolinfo>1->getName()); 
	}
	| compound_statement {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"statement -> compound_statement");
		parserLog($<symbolinfo>1->getName()); 
		$<symbolinfo>$->setName($<symbolinfo>1->getName()); 
	}
	| FOR LPAREN expression_statement expression_statement expression RPAREN statement {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"statement -> FOR LPAREN expression_statement expression_statement expression RPAREN statement");
		parserLog("for("+$<symbolinfo>3->getName()+" "+$<symbolinfo>4->getName()+" "+
		$<symbolinfo>5->getName()+")\n"+$<symbolinfo>7->getName());
		
		if($<symbolinfo>3->getDeclarationType()=="void "){
			errors++;
			appendLogError(lines,"Type Mismatch! Variable Cannot Be Declared void ");
			//$<symbolinfo>$->setDeclarationType("int "); 
		}
		$<symbolinfo>$->setName("for("+$<symbolinfo>3->getName()+$<symbolinfo>4->getName()+$<symbolinfo>5->getName()+")\n"+$<symbolinfo>5->getName()); 
	}
	| IF LPAREN expression RPAREN statement %prec LOWER_THAN_ELSE {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"statement->IF LPAREN expression RPAREN statement");
		parserLog("if("+$<symbolinfo>3->getName()+")\n"+$<symbolinfo>5->getName());
		
		if($<symbolinfo>3->getDeclarationType()=="void "){
			errors++;
			appendLogError(lines,"Type Mismatch! Variable Cannot Be Declared void ");
			//$<symbolinfo>$->setDeclarationType("int "); 
		}
		$<symbolinfo>$->setName("if("+$<symbolinfo>3->getName()+")\n"+$<symbolinfo>5->getName()); 

	}
	| IF LPAREN expression RPAREN statement ELSE statement {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"statement->IF LPAREN expression RPAREN statement ELSE statement");
		parserLog("if("+$<symbolinfo>3->getName()+")\n"+$<symbolinfo>5->getName()+"else\n"+$<symbolinfo>7->getName());
		if($<symbolinfo>3->getDeclarationType()=="void "){
			errors++;
			appendLogError(lines," Type Mismatch ");
			//$<symbolinfo>$->setDeclarationType("int "); 
		}
		$<symbolinfo>$->setName("if("+$<symbolinfo>3->getName()+")\n"+$<symbolinfo>5->getName()+" else \n"+$<symbolinfo>7->getName()); 
	}

	| WHILE LPAREN expression RPAREN statement {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"statement->WHILE LPAREN expression RPAREN statement");
		parserLog("while("+$<symbolinfo>3->getName()+")\n"+$<symbolinfo>5->getName());

		if($<symbolinfo>3->getDeclarationType()=="void "){
			errors++;
			appendLogError(lines," Type Mismatch ");
			//	$<symbolinfo>$->setDeclarationType("int "); 
		}
		$<symbolinfo>$->setName("while("+$<symbolinfo>3->getName()+")\n"+$<symbolinfo>5->getName()); 
	}
	| PRINTLN LPAREN ID RPAREN SEMICOLON {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"statement->PRINTLN LPAREN ID RPAREN SEMICOLON");
		parserLog("\n ("+$<symbolinfo>3->getName()+")");
		$<symbolinfo>$->setName("\n("+$<symbolinfo>3->getName()+")"); 
	}
	| RETURN expression SEMICOLON {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"statement->RETURN expression SEMICOLON");
		parserLog("return "+$<symbolinfo>2->getName());
		if($<symbolinfo>2->getDeclarationType()=="void "){
			errors++;
			appendLogError(lines," Type Mismatch ");
			$<symbolinfo>$->setDeclarationType("int "); 
		}
		$<symbolinfo>$->setName("return "+$<symbolinfo>2->getName()+";"); 
	}
	;

expression_statement: SEMICOLON	{
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"expression_statement->SEMICOLON");
		parserLog(";"); 
		$<symbolinfo>$->setName(";"); 
	}
	| expression SEMICOLON {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"expression_statement->expression SEMICOLON");
		//TODO :Uncomment? parserLog($<symbolinfo>1->getName()+";")
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+";"); 
	}
	;

variable: ID {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"variable->ID");
		parserLog($<symbolinfo>1->getName());
		if(symbolTable->lookUp($<symbolinfo>1->getName())==0){
			errors++;
			appendLogError(lines," Undeclared Variable: "+$<symbolinfo>1->getName());
		}
		else if(symbolTable->lookUp($<symbolinfo>1->getName())->getDeclarationType()=="int array" || symbolTable->lookUp($<symbolinfo>1->getName())->getDeclarationType()=="float array"){
			errors++;
			appendLogError(lines," Not an array: "+$<symbolinfo>1->getName());
		}
		if(symbolTable->lookUp($<symbolinfo>1->getName())!=0){
			//cout<<lines<<" "<<$<symbolinfo>1->getName()<<" "<<symbolTable->lookUp($<symbolinfo>1->getName())->getDeclarationType()<<endl;
			$<symbolinfo>$->setDeclarationType(symbolTable->lookUp($<symbolinfo>1->getName())->getDeclarationType()); 
		}
		$<symbolinfo>$->setName($<symbolinfo>1->getName()); 
												
	}
	| ID LTHIRD expression RTHIRD  {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"variable->ID LTHIRD expression RTHIRD");
		parserLog($<symbolinfo>1->getName()+"["+$<symbolinfo>3->getName()+"]");
		if(symbolTable->lookUp($<symbolinfo>1->getName())==0){
			errors++;
			appendLogError(lines,"Undeclared Variable :"+ $<symbolinfo>1->getName());
		}
		//cout<<lines<<" "<<$<symbolinfo>3->getDeclarationType()<<endl;
		if($<symbolinfo>3->getDeclarationType()=="float "||$<symbolinfo>3->getDeclarationType()=="void "){
			errors++;
			appendLogError(lines," Non-integer Array Index  ");
		}
		if(symbolTable->lookUp($<symbolinfo>1->getName())!=0){
			//cout<<lines<<" "<<symbolTable->lookUp($<symbolinfo>1->getName())->getDeclarationType()<<endl;
			if(symbolTable->lookUp($<symbolinfo>1->getName())->getDeclarationType()!="int array" && symbolTable->lookUp($<symbolinfo>1->getName())->getDeclarationType()!="float array"){
				errors++;
				appendLogError(lines," Type Mismatch ");	
			}
			if(symbolTable->lookUp($<symbolinfo>1->getName())->getDeclarationType()=="int array"){
				$<symbolinfo>1->setDeclarationType("int ");
			}
			if(symbolTable->lookUp($<symbolinfo>1->getName())->getDeclarationType()=="float array"){
				$<symbolinfo>1->setDeclarationType("float ");
			}
			$<symbolinfo>$->setDeclarationType($<symbolinfo>1->getDeclarationType()); 
			
		}
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+"["+$<symbolinfo>3->getName()+"]");  
		
	}
	;
expression: logic_expression {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"expression->logic_expression");
		parserLog($<symbolinfo>1->getName());
		$<symbolinfo>$->setName($<symbolinfo>1->getName()); 
		$<symbolinfo>$->setDeclarationType($<symbolinfo>1->getDeclarationType()); 
	}
	| variable ASSIGNOP logic_expression {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"expression->variable ASSIGNOP logic_expression");
	   	parserLog($<symbolinfo>1->getName()+"="+$<symbolinfo>3->getName());
		
		if($<symbolinfo>3->getDeclarationType()=="void "){
			errors++;
			appendLogError(lines," Type Mismatch ");
			$<symbolinfo>$->setDeclarationType("int "); 
		}else if(symbolTable->lookUp($<symbolinfo>1->getName())!=0) {
			//cout<<lines<<" "<<symbolTable->lookUp($<symbolinfo>1->getName())->getDeclarationType()<<""<<$<symbolinfo>3->getDeclarationType()<<endl;
			if(symbolTable->lookUp($<symbolinfo>1->getName())->getDeclarationType()!=$<symbolinfo>3->getDeclarationType()){
				errors++;
				appendLogError(lines,"Type Mismatch ");
			}
		}
		$<symbolinfo>$->setDeclarationType($<symbolinfo>1->getDeclarationType()); 
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+"="+$<symbolinfo>3->getName());  

	}
	;
logic_expression: rel_expression {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"logic_expression->rel_expression");
		parserLog($<symbolinfo>1->getName());
		$<symbolinfo>$->setName($<symbolinfo>1->getName()); 
		$<symbolinfo>$->setDeclarationType($<symbolinfo>1->getDeclarationType()); 
	}
	| rel_expression LOGICOP rel_expression {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"logic_expression->rel_expression LOGICOP rel_expression");
		parserLog($<symbolinfo>1->getName()+$<symbolinfo>2->getName()+$<symbolinfo>3->getName());
		
		if($<symbolinfo>1->getDeclarationType()=="void "||$<symbolinfo>3->getDeclarationType()=="void "){
			errors++;
			appendLogError(lines," Type Mismatch ");
			$<symbolinfo>$->setDeclarationType("int "); 
		}
		$<symbolinfo>$->setDeclarationType("int "); 
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+$<symbolinfo>2->getName()+$<symbolinfo>3->getName());  

	}
	;

rel_expression: simple_expression {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"rel_expression->simple_expression");
		parserLog($<symbolinfo>1->getName());
		$<symbolinfo>$->setName($<symbolinfo>1->getName()); 
		$<symbolinfo>$->setDeclarationType($<symbolinfo>1->getDeclarationType()); 
	}
	| simple_expression RELOP simple_expression	 {
		$<symbolinfo>$=new SymbolInfo();
			parserLog(lines,"rel_expression->simple_expression RELOP simple_expression");
			parserLog($<symbolinfo>1->getName()+$<symbolinfo>2->getName()+$<symbolinfo>3->getName());
			if($<symbolinfo>1->getDeclarationType()=="void "||$<symbolinfo>3->getDeclarationType()=="void "){
				errors++;
				appendLogError(lines," Type Mismatch! ");
				$<symbolinfo>$->setDeclarationType("int "); 
			}
			$<symbolinfo>$->setDeclarationType("int "); 
			
			$<symbolinfo>$->setName($<symbolinfo>1->getName()+$<symbolinfo>2->getName()+$<symbolinfo>3->getName());  
		}
	;

simple_expression: term {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"simple_expression->term");
		parserLog($<symbolinfo>1->getName());
		$<symbolinfo>$->setDeclarationType($<symbolinfo>1->getDeclarationType());
		$<symbolinfo>$->setName($<symbolinfo>1->getName());  
	}
	| simple_expression ADDOP term {
		$<symbolinfo>$=new SymbolInfo(); 
		parserLog(lines,"simple_expression->simple_expression ADDOP term");
		parserLog($<symbolinfo>1->getName()+$<symbolinfo>2->getName()+$<symbolinfo>3->getName());
		//cout<<$<symbolinfo>3->getDeclarationType()<<endl;
		if($<symbolinfo>1->getDeclarationType()=="void "||$<symbolinfo>3->getDeclarationType()=="void "){
			errors++;
			appendLogError(lines," Type Mismatch ");
			$<symbolinfo>$->setDeclarationType("int "); 
		}else if($<symbolinfo>1->getDeclarationType()=="float " ||$<symbolinfo>3->getDeclarationType()=="float ")
			$<symbolinfo>$->setDeclarationType("float ");
			else  $<symbolinfo>$->setDeclarationType("int ");
			$<symbolinfo>$->setName($<symbolinfo>1->getName()+$<symbolinfo>2->getName()+$<symbolinfo>3->getName());  
	}
	;

term: unary_expression {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"term->unary_expression");
		parserLog($<symbolinfo>1->getName()); 
		$<symbolinfo>$->setDeclarationType($<symbolinfo>1->getDeclarationType()); 
		$<symbolinfo>$->setName($<symbolinfo>1->getName()); 
	}
    | term MULOP unary_expression {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"term->term MULOP unary_expression");
		parserLog($<symbolinfo>1->getName()+$<symbolinfo>2->getName()+$<symbolinfo>3->getName());
		if($<symbolinfo>1->getDeclarationType()=="void "||$<symbolinfo>3->getDeclarationType()=="void "){
			errors++;
			appendLogError(lines," Type Mismatch ");
			$<symbolinfo>$->setDeclarationType("int "); 
		}else if($<symbolinfo>2->getName()=="%"){
			if($<symbolinfo>1->getDeclarationType()!="int " ||$<symbolinfo>3->getDeclarationType()!="int "){
			errors++;
			appendLogError(lines," Integer operand on modulus operator  ");

			} 
			$<symbolinfo>$->setDeclarationType("int "); 
		}
		else if($<symbolinfo>2->getName()=="/"){
			if($<symbolinfo>1->getDeclarationType()=="void "||$<symbolinfo>3->getDeclarationType()=="void "){
				errors++;
				appendLogError(lines," Type Mismatch ");
				$<symbolinfo>$->setDeclarationType("int "); 
			}
			else  if($<symbolinfo>1->getDeclarationType()=="int " && $<symbolinfo>3->getDeclarationType()=="int ")$<symbolinfo>$->setDeclarationType("int "); 
			else $<symbolinfo>$->setDeclarationType("float "); 
			
		}
		else{
			if($<symbolinfo>1->getDeclarationType()=="void "||$<symbolinfo>3->getDeclarationType()=="void "){
				errors++;
				appendLogError(lines," Type Mismatch!");
				$<symbolinfo>$->setDeclarationType("int "); 
			}
			else  if($<symbolinfo>1->getDeclarationType()=="float " || $<symbolinfo>3->getDeclarationType()=="float ") $<symbolinfo>$->setDeclarationType("float "); 
			else $<symbolinfo>$->setDeclarationType("int "); 
		}
	
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+$<symbolinfo>2->getName()+$<symbolinfo>3->getName()); 
								
	}
    ;

unary_expression: ADDOP unary_expression {
	$<symbolinfo>$=new SymbolInfo();
	parserLog(lines,"unary_expression->ADDOP unary_expression");
	parserLog($<symbolinfo>1->getName()+$<symbolinfo>2->getName());
	if($<symbolinfo>2->getDeclarationType()=="void "){
		errors++;
		appendLogError(lines," Type Mismatch ");
		$<symbolinfo>$->setDeclarationType("int "); 
	}else 
		$<symbolinfo>$->setDeclarationType($<symbolinfo>2->getDeclarationType()); 	
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+$<symbolinfo>2->getName()); 

	}
	| NOT unary_expression {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"unary_expression->NOT unary_expression");
		parserLog("!"+$<symbolinfo>2->getName()); 
		if($<symbolinfo>2->getDeclarationType()=="void "){
			errors++;
			appendLogError(lines," Type Mismatch ");
			$<symbolinfo>$->setDeclarationType("int "); 
		}else 
			$<symbolinfo>$->setDeclarationType($<symbolinfo>2->getDeclarationType());  
			$<symbolinfo>$->setName("!"+$<symbolinfo>2->getName()); 
	}
	| factor {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"unary_expression->factor");
		parserLog($<symbolinfo>1->getName()); 
		// cout<<$<symbolinfo>1->getDeclarationType()<<endl;
		$<symbolinfo>$->setDeclarationType($<symbolinfo>1->getDeclarationType()); 
		$<symbolinfo>$->setName($<symbolinfo>1->getName()); 
				
	}
	;

factor: variable {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"factor->variable");
		parserLog($<symbolinfo>1->getName());
		$<symbolinfo>$->setDeclarationType($<symbolinfo>1->getDeclarationType()); 
		$<symbolinfo>$->setName($<symbolinfo>1->getName()); 
	}
	| ID LPAREN argument_list RPAREN {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"factor->ID LPAREN argument_list RPAREN");
		parserLog($<symbolinfo>1->getName()+"("+$<symbolinfo>3->getName()+")");
		SymbolInfo* s=symbolTable->lookUp($<symbolinfo>1->getName());
		if(s==0){
			errors++;
			appendLogError(lines," Undefined Function ");
			$<symbolinfo>$->setDeclarationType("int "); 
		}
		else if(s->get_isFunction()==0){
			errors++;
			appendLogError(lines," Not A Function ");
			$<symbolinfo>$->setDeclarationType("int "); 
		}
		else {
			if(s->get_isFunction()->get_isdefined()==0){
				errors++;
				appendLogError(lines," Undeclared Function ");
			}
			int num=s->get_isFunction()->get_number_of_parameter();
			//cout<<lines<<" "<<arg_list.size()<<endl;
			$<symbolinfo>$->setDeclarationType(s->get_isFunction()->get_return_type());
			if(num!=arg_list.size()){
				errors++;
				appendLogError(lines," Invalid number of arguments ");
			}
			else{
				//cout<<s->get_isFunction()->get_return_type()<<endl;
				vector<string>param_list=s->get_isFunction()->get_paralist();
				vector<string>para_type=s->get_isFunction()->get_paratype();
				for(int i=0;i<arg_list.size();i++){
					if(arg_list[i]->getDeclarationType()!=para_type[i]){
						errors++;
						appendLogError(lines,"Type Mismatch ");
						break;
					}
				}

			}
		}
		arg_list.clear();
		//cout<<lines<<" "<<$<symbolinfo>$->getDeclarationType()<<endl;
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+"("+$<symbolinfo>3->getName()+")"); 
	}
	| LPAREN expression RPAREN {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"factor->LPAREN expression RPAREN");
		parserLog("("+$<symbolinfo>2->getName()+")"); 
		$<symbolinfo>$->setDeclarationType($<symbolinfo>2->getDeclarationType()); 
		$<symbolinfo>$->setName("("+$<symbolinfo>2->getName()+")"); 
	}
	| CONST_INT { 
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"factor->CONST_INT");
		parserLog($<symbolinfo>1->getName());
		$<symbolinfo>$->setDeclarationType("int "); 	
		$<symbolinfo>$->setName($<symbolinfo>1->getName()); 
			
	}
	| CONST_FLOAT {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"factor->CONST_FLOAT");
		parserLog($<symbolinfo>1->getName()); 
		$<symbolinfo>$->setDeclarationType("float "); 	
		$<symbolinfo>$->setName($<symbolinfo>1->getName()); 
				
	}
	| variable INCOP {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"factor->variable INCOP");
		parserLog($<symbolinfo>1->getName()+"++"); 
		$<symbolinfo>$->setDeclarationType($<symbolinfo>1->getDeclarationType());
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+"++"); 
					 
	}
	| variable DECOP {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"factor->variable DECOP");
		parserLog($<symbolinfo>1->getName()+"--");
		$<symbolinfo>$->setDeclarationType($<symbolinfo>1->getDeclarationType()); 
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+"--"); 
					 
	}
	;

argument_list: arguments {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"argument_list->arguments");
		parserLog($<symbolinfo>1->getName());
		$<symbolinfo>$->setName($<symbolinfo>1->getName());
	}
	| %empty {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"argument_list-> ");
		$<symbolinfo>$->setName("");}
	;

arguments: arguments COMMA logic_expression {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"arguments->arguments COMMA logic_expression ");
		parserLog($<symbolinfo>1->getName()+","+$<symbolinfo>3->getName());
		arg_list.push_back($<symbolinfo>3);
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+","+$<symbolinfo>3->getName());
	}
	| logic_expression {
		$<symbolinfo>$=new SymbolInfo();
		parserLog(lines,"arguments->logic_expression");
		parserLog($<symbolinfo>1->getName()); 
		arg_list.push_back(new SymbolInfo($<symbolinfo>1->getName(),$<symbolinfo>1->getType(),$<symbolinfo>1->getDeclarationType()));
		// cout<<$<symbolinfo>1->getDeclarationType()<<endl;
		$<symbolinfo>$->setName($<symbolinfo>1->getName());					
	}
	;
 %%



int main(int argc,char *argv[])
{

	if((fp=fopen(argv[1],"r"))==NULL)
	{
		printf("Cannot Open Input File.\n");
		return 0;
	}
	yyin=fp;
	symbolTable->enterScope();
	yyparse();
	parserLog(" Symbol symbolTable : ");
	symbolTable->printAllScopeTables();
	parserLog("Total Lines :"+lines);
	parserLog("Total Errors :"+errors);
	// appendLogError("Total Errors : %d,errors);

	fclose(fp);
	
	return 0;
}

