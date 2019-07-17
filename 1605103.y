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


SymbolTable *symbolTable = new SymbolTable(100);
vector<SymbolInfo*>param_list,declaration_list,arg_list;

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
		LOG(lines,"program->program unit");
		LOG($<Symbol>1->getName()+" "+$<Symbol>2->getName()); 
		
		$<Symbol>$->setName($<Symbol>1->getName()+$<Symbol>2->getName());
	}

	| unit {

		$<Symbol>$ = new SymbolInfo();
		LOG(lines,"program->unit");
		LOG($<Symbol>1->getName()+'\n');

		$<Symbol>$->setName($<Symbol>1->getName());
	}
	
	;


//@DONE
unit: var_declaration {

		$<Symbol>$=new SymbolInfo();
		LOG(lines,"unit->var_declaration");
		LOG($<Symbol>1->getName()); 

		$<Symbol>$->setName($<Symbol>1->getName()+"\n");
	}
	
	| func_declaration {

		$<Symbol>$ = new SymbolInfo();
		LOG(lines,"unit->func_declaration");
		LOG($<Symbol>1->getName()); 

		$<Symbol>$->setName($<Symbol>1->getName()+"\n");
	}
    
	| func_definition { 

		$<Symbol>$=new SymbolInfo();
		LOG(lines,"unit->func_definition");
		LOG($<Symbol>1->getName());

		$<Symbol>$->setName($<Symbol>1->getName()+"\n");
	}
	
	;

//@DONE
func_declaration: type_specifier ID LPAREN parameter_list RPAREN SEMICOLON {

		$<Symbol>$=new SymbolInfo();
		LOG(lines,"func_declaration->type_specifier ID LPAREN parameter_list RPAREN SEMICOLON");
		LOG($<Symbol>1->getName()+" "+$<Symbol>2->getName()+"("+$<Symbol>4->getName()+")");
		
		SymbolInfo *s = symbolTable->lookUp($<Symbol>2->getName());
		
		if(s == nullptr){
			
			//TODO : Function
			symbolTable->insert($<Symbol>2->getName(),"ID","Function");

			s = symbolTable->lookUp($<Symbol>2->getName());

			s->set_isFunction();
			
			for(int i=0 ;i < param_list.size() ; i++){
			
				s->get_isFunction()->add_number_of_parameter(param_list[i]->getName(),param_list[i]->getDeclarationType());
				//cout<<param_list[i]->getDeclarationType()<<endl;
			}
			param_list.clear();
			s->get_isFunction()->set_return_type($<Symbol>1->getName());
		} 
		else{
			int num=s->get_isFunction()->get_number_of_parameter();
			
			if(num!=param_list.size()){
			
				errors++;
				ERROR(lines,"Invalid number of parameters ",PARSER);
			
			}else{
				vector<string>para_type=s->get_isFunction()->get_paratype();
				for( int i=0;i < param_list.size(); i++){
					if(param_list[i]->getDeclarationType()!=para_type[i]){
						errors++;
						ERROR(lines,"Type Mismatch ! Expected "+param_list[i]->getDeclarationType()+" Found "+ para_type[i] +" for "+to_string(i)+"th parameter",PARSER);
						break;
					}
				}
				if(s->get_isFunction()->get_return_type()!=$<Symbol>1->getName()){
					errors++;
					ERROR(lines,"Return Type Mismatch ! Expected "+s->get_isFunction()->get_return_type()+ " Found " + $<Symbol>1->getName(),PARSER);
				}
				param_list.clear();
			}
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
				s->get_isFunction()->set_return_type($<Symbol>1->getName());
			
			}
			else{

				if(s->get_isFunction()->get_number_of_parameter()!=0){
					errors++;
					ERROR(lines,"Invalid number of parameters! Expected 0 Found "+to_string(s->get_isFunction()->get_number_of_parameter()),PARSER);
		
				}
				if(s->get_isFunction()->get_return_type()!=$<Symbol>1->getName()){
					errors++;
					ERROR(lines," Return Type Does not Match! Expected "+s->get_isFunction()->get_return_type()+ " Found " +$<Symbol>1->getName(),PARSER);
				}

			}
			$<Symbol>$->setName($<Symbol>1->getName()+" "+$<Symbol>2->getName()+"();");
	}
	;


func_definition: type_specifier ID LPAREN parameter_list RPAREN {
		
		$<Symbol>$ = new SymbolInfo(); 
		SymbolInfo *s = symbolTable->lookUp($<Symbol>2->getName()); 

		if(s != nullptr){ 
			if(s->get_isFunction()->get_isdefined()==0){
				int num = s->get_isFunction()->get_number_of_parameter();
				if(num != param_list.size()){
					errors++;
					ERROR(lines,"Invalid number of parameters ",PARSER);
				} else{
					vector<string>para_type = s->get_isFunction()->get_paratype();
					for(int i=0;i<param_list.size();i++){
						if(param_list[i]->getDeclarationType() != para_type[i]){
							errors++;
							ERROR(lines,"Type Mismatch ! Expected "+param_list[i]->getDeclarationType()+" Found "+para_type[i]+" for "+ to_string(i)+"th "+"Parameter",PARSER);
							break;
						}
					}
					if(s->get_isFunction()->get_return_type() != $<Symbol>1->getName()){
						errors++;
						ERROR(lines,"Return Type Mismatch ! Expected "+s->get_isFunction()->get_return_type()+ " Found " + $<Symbol>1->getName(),PARSER);
					}	
				}
				s->get_isFunction()->set_isdefined();
			}
			else{
				errors++;
				ERROR(lines,"Multiple definition of function "+$<Symbol>2->getName(),PARSER);
			}
		}
		else{ 
			//cout<<param_list.size()<<" "<<lines<<endl;
			symbolTable->insert($<Symbol>2->getName(),"ID","Function");
			s = symbolTable->lookUp($<Symbol>2->getName());
			s->set_isFunction();
			//cout<<s->get_isFunction()->get_number_of_parameter()<<endl;
			s->get_isFunction()->set_isdefined();
			
			for(int i=0;i<param_list.size();i++){
				s->get_isFunction()->add_number_of_parameter(param_list[i]->getName(),param_list[i]->getDeclarationType());
			}
			s->get_isFunction()->set_return_type($<Symbol>1->getName());
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
			s -> get_isFunction()->set_isdefined();
			s -> get_isFunction()->set_return_type($<Symbol>1->getName());
			//	cout<<lines<<" "<<s->get_isFunction()->get_return_type()<<endl;
		}
		else if(s->get_isFunction()->get_isdefined()==0){
			if(s->get_isFunction()->get_number_of_parameter()!=0){
				errors++;
				ERROR(lines," Invalid number of parameters ",PARSER);
			}
			if(s->get_isFunction()->get_return_type()!=$<Symbol>1->getName()){
				errors++;
				ERROR(lines,"Return Type Mismatch ",PARSER);
			}

			s->get_isFunction()->set_isdefined();
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
		
		param_list.push_back(new SymbolInfo($<Symbol>4->getName(),"ID",$<Symbol>3->getName()));
		$<Symbol>$->setName($<Symbol>1->getName()+","+$<Symbol>3->getName()+" "+$<Symbol>4->getName());
	}
	| parameter_list COMMA type_specifier {
		
		$<Symbol>$ = new SymbolInfo();
		LOG(lines,"parameter_list->parameter_list COMMA type_specifier");
		LOG($<Symbol>1->getName()+","+$<Symbol>3->getName());
		
		param_list.push_back(new SymbolInfo("","ID",$<Symbol>3->getName()));
		$<Symbol>$->setName($<Symbol>1->getName()+","+$<Symbol>3->getName());

	}
	| type_specifier ID {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"parameter_list -> type_specifier ID");
		LOG($<Symbol>1->getName()+" "+$<Symbol>2->getName());
		param_list.push_back(new SymbolInfo($<Symbol>2->getName(),"ID",$<Symbol>1->getName()));
		$<Symbol>$->setName($<Symbol>1->getName()+" "+$<Symbol>2->getName());
	}
	| type_specifier {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"parameter_list -> type_specifier");
		LOG($<Symbol>1->getName());
		param_list.push_back(new SymbolInfo("","ID",$<Symbol>1->getName()));
		$<Symbol>$->setName($<Symbol>1->getName()+" ");
	}
	;


//@DONE
compound_statement: LCURL {
	symbolTable->enterScope();
	//	cout<<lines<<" "<<param_list.size()<<endl;
	for(int i=0;i<param_list.size();i++)
		symbolTable->insert(param_list[i]->getName(),"ID",param_list[i]->getDeclarationType());
		//symbolTable->printcurrent();
	param_list.clear();
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
		for(int i=0;i<param_list.size();i++)
			symbolTable->insert(param_list[i]->getName(),"ID",param_list[i]->getDeclarationType());
		//symbolTable->printcurrent();
		param_list.clear();
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"compound_statement->LCURL RCURL");
		LOG("{}");
		$<Symbol>$->setName("{}");
		symbolTable->printAllScopeTables();
		symbolTable->exitScope();
	}
	;

//@DONE
var_declaration: type_specifier declaration_list SEMICOLON {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"var_declaration -> type_specifier declaration_list SEMICOLON");
		LOG($<Symbol>1->getName()+" "+$<Symbol>2->getName()+";");
		if($<Symbol>1->getName()=="void "){ 
			errors++;
			ERROR(lines,"Cannot Declare void Type",PARSER);																
		}
		else{
			for(int i=0;i < declaration_list.size() ; i++){
				if(symbolTable->lookUpLocal(declaration_list[i]->getName()) != nullptr){
					errors++;
					ERROR(lines,"Multiple Declaration of " + declaration_list[i]->getName(),PARSER);
					continue;
				}
				if(declaration_list[i]->getType().size()==3){ //"IDa"
					declaration_list[i]->setType(declaration_list[i]->getType().substr(0,declaration_list[i]->getType().size () - 1));
					symbolTable->insert(declaration_list[i]->getName(),declaration_list[i]->getType(),$<Symbol>1->getName()+"array");
				} else symbolTable->insert(declaration_list[i]->getName(),declaration_list[i]->getType(),$<Symbol>1->getName());
			}
		}
		declaration_list.clear();
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
declaration_list: declaration_list COMMA ID {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"declaration_list -> declaration_list COMMA ID");
		LOG($<Symbol>1->getName()+","+$<Symbol>3->getName());
		declaration_list.push_back(new SymbolInfo($<Symbol>3->getName(),"ID"));
		$<Symbol>$->setName($<Symbol>1->getName()+","+$<Symbol>3->getName());
	}
	| declaration_list COMMA ID LTHIRD CONST_INT RTHIRD {
		$<Symbol>$=new SymbolInfo();
		LOG($<Symbol>1->getName()+","+$<Symbol>3->getName()+"["+$<Symbol>5->getName()+"]");
		LOG(lines,"declaration_list -> declaration_list COMMA ID LTHIRD CONST_INT RTHIRD");
		
		declaration_list.push_back(new SymbolInfo($<Symbol>3->getName(),"IDa")); //TODO : why IDa ?
		$<Symbol>$->setName($<Symbol>1->getName()+","+$<Symbol>3->getName()+"["+$<Symbol>5->getName()+"]");
	}
	| ID {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"declaration_list -> ID");
		LOG($<Symbol>1->getName());
		declaration_list.push_back(new SymbolInfo($<Symbol>1->getName(),"ID"));
		$<Symbol>$->setName($<Symbol>1->getName());
	}
	| ID LTHIRD CONST_INT RTHIRD {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"declaration_list -> ID LTHIRD CONST_INT RTHIRD");
		LOG($<Symbol>1->getName()+"["+$<Symbol>3->getName()+"]");
		declaration_list.push_back(new SymbolInfo($<Symbol>1->getName(),"IDa"));
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
		//TODO: Uncomment ? 
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
			cout<<lines<<" "<<$<Symbol>1->toString()<<" "<<symbolTable->lookUp($<Symbol>1->getName())->getDeclarationType()<<endl;
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
		//cout<<lines<<" "<<$<Symbol>3->getDeclarationType()<<endl;
		if($<Symbol>3->getDeclarationType()=="float "||$<Symbol>3->getDeclarationType()=="void "){
			errors++;
			ERROR(lines," Non-integer Array Index  ",PARSER);
		}
		if(symbolTable->lookUp($<Symbol>1->getName())!=nullptr){
			cout<<lines<<" "<<symbolTable->lookUp($<Symbol>1->getName())->toString()<<endl;
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
			cout<<lines<<" "<<symbolTable->lookUp($<Symbol>1->getName())->toString()<<""<<$<Symbol>3->toString()<<endl;
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
		cout<<$<Symbol>1->toString()<<endl;
		$<Symbol>$->setDeclarationType($<Symbol>1->getDeclarationType());
		$<Symbol>$->setName($<Symbol>1->getName());  
	}
	| simple_expression ADDOP term {
		$<Symbol>$=new SymbolInfo(); 
		LOG(lines,"simple_expression -> simple_expression ADDOP term");
		LOG($<Symbol>1->getName()+$<Symbol>2->getName()+$<Symbol>3->getName());
		//cout<<$<Symbol>3->getDeclarationType()<<endl;
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
		cout<<$<Symbol>1->toString()<<endl;
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
		cout<<$<Symbol>1->toString()<<endl;
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
			ERROR(lines," Undefined Function ",PARSER);
			$<Symbol>$->setDeclarationType("int "); 
		}
		else if(s->get_isFunction()==nullptr){
			errors++;
			ERROR(lines," Not A Function ",PARSER);
			$<Symbol>$->setDeclarationType("int "); 
		}
		else {
			if(s->get_isFunction()->get_isdefined()==0){
				errors++;
				ERROR(lines," Undeclared Function ",PARSER);
			}
			int num=s->get_isFunction()->get_number_of_parameter();
			//cout<<lines<<" "<<arg_list.size()<<endl;
			$<Symbol>$->setDeclarationType(s->get_isFunction()->get_return_type());
			if(num!=arg_list.size()){
				errors++;
				ERROR(lines," Invalid number of arguments ",PARSER);
			}
			else{
				//cout<<s->get_isFunction()->get_return_type()<<endl;
				vector<string>param_list=s->get_isFunction()->get_paralist();
				vector<string>para_type=s->get_isFunction()->get_paratype();
				for(int i=0;i<arg_list.size();i++){
					if(arg_list[i]->getDeclarationType()!=para_type[i]){
						errors++;
						ERROR(lines,"Type Mismatch 14",PARSER);
						break;
					}
				}

			}
		}
		arg_list.clear();
		//cout<<lines<<" "<<$<Symbol>$->getDeclarationType()<<endl;
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
		cout<<$<Symbol>1->toString()<<endl;
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
		arg_list.push_back($<Symbol>3);
		$<Symbol>$->setName($<Symbol>1->getName()+","+$<Symbol>3->getName());
	}
	| logic_expression {
		$<Symbol>$=new SymbolInfo();
		LOG(lines,"arguments->logic_expression");
		LOG($<Symbol>1->getName()); 
		arg_list.push_back(new SymbolInfo($<Symbol>1->getName(),$<Symbol>1->getType(),$<Symbol>1->getDeclarationType()));
		// cout<<$<Symbol>1->getDeclarationType()<<endl;
		$<Symbol>$->setName($<Symbol>1->getName());					
	}
	;
 %%


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
	LOG("Final SymbolTable : ");
	symbolTable->printAllScopeTables();
	LOG("Total Lines :"+to_string(lines));
	LOG("Total Errors :"+to_string(errors));
	ERROR("\nTotal Errors :"+to_string(errors)+'\n',PARSER);
	fclose(fp);
	LOG("\n\n^^^^^^^^^^^Finished Parsing "+fileName+"^^^^^^^^^^^\n\n");
	
	
}

int main(int argc,char *argv[])
{
	Util::clearFiles();
	// if((fp=fopen(argv[1],"r"))==NULL)
	// {
	// 	printf("Cannot Open Input File.\n");
	// 	return 0;
	// }
	// yyin=fp;
	// yyparse();
	// LOG("Final SymbolTable : ");
	// symbolTable->printAllScopeTables();
	// LOG("Total Lines :"+to_string(lines));
	// LOG("Total Errors :"+to_string(errors));
	
	int i = 1;
	while(*(argv + i)!=nullptr){
		test(argv[i]);
		i++;
	}
	// test(argv[1]);
	// test(argv[2]);
	// test(argv[3]);

	
	
	return 0;
}


