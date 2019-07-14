%{
#include<iostream>
#include "headers/1605103_SymbolTable.h"
#define ERROR Util::appendLogError
#define LOG Util::parserLog


//#define YYSTYPE SymbolInfo*

using namespace std;

extern "C" int yylex(void);
int yyparse(void);
int lines=1,errors=0;
extern FILE *yyin;


FILE *fp;

SymbolTable *symbolTable = new SymbolTable(100);
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
		LOG(lines,"program->program unit");
		LOG($<symbolinfo>1->getName()+" "+$<symbolinfo>2->getName()); 
		
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+$<symbolinfo>2->getName());
	}

	| unit {

		$<symbolinfo>$ = new SymbolInfo();
		LOG(lines,"program->unit");
		LOG($<symbolinfo>1->getName()+'\n');

		$<symbolinfo>$->setName($<symbolinfo>1->getName());
	}
	
	;


//@DONE
unit: var_declaration {

		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"unit->var_declaration");
		LOG($<symbolinfo>1->getName()); 

		$<symbolinfo>$->setName($<symbolinfo>1->getName()+"\n");
	}
	
	| func_declaration {

		$<symbolinfo>$ = new SymbolInfo();
		LOG(lines,"unit->func_declaration");
		LOG($<symbolinfo>1->getName()); 

		$<symbolinfo>$->setName($<symbolinfo>1->getName()+"\n");
	}
    
	| func_definition { 

		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"unit->func_definition");
		LOG($<symbolinfo>1->getName());

		$<symbolinfo>$->setName($<symbolinfo>1->getName()+"\n");
	}
	
	;

//@DONE
func_declaration: type_specifier ID LPAREN parameter_list RPAREN SEMICOLON {

		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"func_declaration->type_specifier ID LPAREN parameter_list RPAREN SEMICOLON");
		LOG($<symbolinfo>1->getName()+" "+$<symbolinfo>2->getName()+"("+$<symbolinfo>4->getName()+")");
		
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
				ERROR(lines,"Invalid number of parameters ");
			
			}else{
				vector<string>para_type=s->get_isFunction()->get_paratype();
				for( int i=0;i < param_list.size(); i++){
					if(param_list[i]->getDeclarationType()!=para_type[i]){
						errors++;
						ERROR(lines,"Type Mismatch ! Expected "+param_list[i]->getDeclarationType()+" Found "+ para_type[i] +" for "+to_string(i)+"th parameter");
						break;
					}
				}
				if(s->get_isFunction()->get_return_type()!=$<symbolinfo>1->getName()){
					errors++;
					ERROR(lines,"Return Type Mismatch ! Expected "+s->get_isFunction()->get_return_type()+ " Found " + $<symbolinfo>1->getName());
				}
				param_list.clear();
			}
		}

		$<symbolinfo>$->setName($<symbolinfo>1->getName()+" "+$<symbolinfo>2->getName()+"("+$<symbolinfo>4->getName()+");");

	}
	| type_specifier ID LPAREN RPAREN SEMICOLON {

			$<symbolinfo>$ = new SymbolInfo();
			
			LOG(lines,"func_declaration -> type_specifier ID LPAREN RPAREN SEMICOLON");
			LOG($<symbolinfo>1->getName()+" "+$<symbolinfo>2->getName()+"();");
			
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
					ERROR(lines,"Invalid number of parameters! Expected 0 Found "+to_string(s->get_isFunction()->get_number_of_parameter()));
		
				}
				if(s->get_isFunction()->get_return_type()!=$<symbolinfo>1->getName()){
					errors++;
					ERROR(lines," Return Type Does not Match! Expected "+s->get_isFunction()->get_return_type()+ " Found " +$<symbolinfo>1->getName());
				}

			}
			$<symbolinfo>$->setName($<symbolinfo>1->getName()+" "+$<symbolinfo>2->getName()+"();");
	}
	;


func_definition: type_specifier ID LPAREN parameter_list RPAREN {
		
		$<symbolinfo>$ = new SymbolInfo(); 
		SymbolInfo *s = symbolTable->lookUp($<symbolinfo>2->getName()); 

		if(s != nullptr){ 
			if(s->get_isFunction()->get_isdefined()==0){
				int num = s->get_isFunction()->get_number_of_parameter();
				if(num != param_list.size()){
					errors++;
					ERROR(lines,"Invalid number of parameters ");
				} else{
					vector<string>para_type = s->get_isFunction()->get_paratype();
					for(int i=0;i<param_list.size();i++){
						if(param_list[i]->getDeclarationType() != para_type[i]){
							errors++;
							ERROR(lines,"Type Mismatch ! Expected "+param_list[i]->getDeclarationType()+" Found "+para_type[i]+" for "+ to_string(i)+"th "+"Parameter");
							break;
						}
					}
					if(s->get_isFunction()->get_return_type() != $<symbolinfo>1->getName()){
						errors++;
						ERROR(lines,"Return Type Mismatch ! Expected "+s->get_isFunction()->get_return_type()+ " Found " + $<symbolinfo>1->getName());
					}	
				}
				s->get_isFunction()->set_isdefined();
			}
			else{
				errors++;
				ERROR(lines,"Multiple definition of function "+$<symbolinfo>2->getName());
			}
		}
		else{ 
			//cout<<param_list.size()<<" "<<lines<<endl;
			symbolTable->insert(SymbolInfo($<symbolinfo>2->getName(),"ID","Function"));
			s = symbolTable->lookUp($<symbolinfo>2->getName());
			s->set_isFunction();
			//cout<<s->get_isFunction()->get_number_of_parameter()<<endl;
			s->get_isFunction()->set_isdefined();
			
			for(int i=0;i<param_list.size();i++){
				s->get_isFunction()->add_number_of_parameter(param_list[i]->getName(),param_list[i]->getDeclarationType());
			}
			s->get_isFunction()->set_return_type($<symbolinfo>1->getName());
		}

	}
	compound_statement {
		LOG(lines,"func_definition -> type_specifier ID LPAREN parameter_list RPAREN compound_statement ");
		LOG($<symbolinfo>1->getName()+" "+$<symbolinfo>2->getName()+"("
		+$<symbolinfo>4->getName()+") "+ $<symbolinfo>7->getName());
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+" "+$<symbolinfo>2->getName()+"("+$<symbolinfo>4->getName()+")"+$<symbolinfo>7->getName());
	}
	| type_specifier ID LPAREN RPAREN { 
		$<symbolinfo>$ = new SymbolInfo();
		SymbolInfo *s = symbolTable->lookUp($<symbolinfo>2->getName());
		if(s == nullptr){
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
				ERROR(lines," Invalid number of parameters ");
			}
			if(s->get_isFunction()->get_return_type()!=$<symbolinfo>1->getName()){
				errors++;
				ERROR(lines,"Return Type Mismatch ");
			}

			s->get_isFunction()->set_isdefined();
		}
		else{
			errors++;
			ERROR(lines,"Multiple defination of function "+$<symbolinfo>2->getName());
		}
											
		$<symbolinfo>1->setName($<symbolinfo>1->getName()+" "+$<symbolinfo>2->getName()+"()");
	} compound_statement {
		LOG(lines,"func_definition->type_specifier ID LPAREN RPAREN compound_statement");
		LOG($<symbolinfo>1->getName()+" "+$<symbolinfo>6->getName());
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+$<symbolinfo>6->getName());
			
	}
	;




//@DONE
parameter_list: parameter_list COMMA type_specifier ID {
		
		$<symbolinfo>$ = new SymbolInfo();
		LOG(lines,"parameter_list -> parameter_list COMMA type_specifier ID");
		LOG($<symbolinfo>1->getName()+","+$<symbolinfo>3->getName()+" "+$<symbolinfo>4->getName());
		
		param_list.push_back(new SymbolInfo($<symbolinfo>4->getName(),"ID",$<symbolinfo>3->getName()));
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+","+$<symbolinfo>3->getName()+" "+$<symbolinfo>4->getName());
	}
	| parameter_list COMMA type_specifier {
		
		$<symbolinfo>$ = new SymbolInfo();
		LOG(lines,"parameter_list->parameter_list COMMA type_specifier");
		LOG($<symbolinfo>1->getName()+","+$<symbolinfo>3->getName());
		
		param_list.push_back(new SymbolInfo("","ID",$<symbolinfo>3->getName()));
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+","+$<symbolinfo>3->getName());

	}
	| type_specifier ID {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"parameter_list -> type_specifier ID");
		LOG($<symbolinfo>1->getName()+" "+$<symbolinfo>2->getName());
		param_list.push_back(new SymbolInfo($<symbolinfo>2->getName(),"ID",$<symbolinfo>1->getName()));
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+" "+$<symbolinfo>2->getName());
	}
	| type_specifier {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"parameter_list -> type_specifier");
		LOG($<symbolinfo>1->getName());
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
		LOG(lines,"compound_statement -> LCURL statements RCURL");
		LOG("{"+$<symbolinfo>3->getName()+"}");
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
		LOG(lines,"compound_statement->LCURL RCURL");
		LOG("{}");
		$<symbolinfo>$->setName("{}");
		symbolTable->printAllScopeTables();
		symbolTable->exitScope();
	}
	;

//@DONE
var_declaration: type_specifier declaration_list SEMICOLON {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"var_declaration -> type_specifier declaration_list SEMICOLON");
		LOG($<symbolinfo>1->getName()+" "+$<symbolinfo>2->getName()+";");
		if($<symbolinfo>1->getName()=="void "){ // TODO : "void" ?
			errors++;
			ERROR(lines,"Cannot Declare void Type");																
		}
		else{
			for(int i=0;i < declaration_list.size() ; i++){
				if(symbolTable->lookUpLocal(declaration_list[i]->getName()) != nullptr){
					errors++;
					ERROR(lines," Multiple Declaration of " + declaration_list[i]->getName());
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
		LOG(lines,"type_specifier -> INT");
		LOG("int ");
		$<symbolinfo>$->setName("int ");
	}
	| FLOAT  {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"type_specifier -> FLOAT");
		LOG("float ");
		$<symbolinfo>$->setName("float ");
	}
	| VOID  {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"type_specifier -> VOID");
		LOG("void ");
		$<symbolinfo>$->setName("void ");
	}
	;


//@DONE
declaration_list: declaration_list COMMA ID {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"declaration_list -> declaration_list COMMA ID");
		LOG($<symbolinfo>1->getName()+","+$<symbolinfo>3->getName());
		declaration_list.push_back(new SymbolInfo($<symbolinfo>3->getName(),"ID"));
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+","+$<symbolinfo>3->getName());
	}
	| declaration_list COMMA ID LTHIRD CONST_INT RTHIRD {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"declaration_list -> declaration_list COMMA ID LTHIRD CONST_INT RTHIRD");
		LOG($<symbolinfo>1->getName()+","+$<symbolinfo>3->getName()+"["+$<symbolinfo>5->getName()+"]");
		
		declaration_list.push_back(new SymbolInfo($<symbolinfo>3->getName(),"IDa")); //TODO : why IDa ?
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+","+$<symbolinfo>3->getName()+"["+$<symbolinfo>5->getName()+"]");
	}
	
	| ID LTHIRD CONST_INT RTHIRD {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"declaration_list -> ID LTHIRD CONST_INT RTHIRD");
		LOG($<symbolinfo>1->getName()+"["+$<symbolinfo>3->getName()+"]");
		declaration_list.push_back(new SymbolInfo($<symbolinfo>1->getName(),"IDa"));
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+"["+$<symbolinfo>3->getName()+"]");
	}
	| ID {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"declaration_list -> ID");
		LOG($<symbolinfo>1->getName());
		declaration_list.push_back(new SymbolInfo($<symbolinfo>1->getName(),"ID"));
		$<symbolinfo>$->setName($<symbolinfo>1->getName());
	}
	;

//@DONE
statements: statement {
		$<symbolinfo>$ = new SymbolInfo();
		LOG(lines,"statements -> statement");
		LOG($<symbolinfo>1->getName()); 
		$<symbolinfo>$->setName($<symbolinfo>1->getName());
	}
	| statements statement {
		$<symbolinfo>$ = new SymbolInfo();
		LOG(lines,"statements -> statements statement");
		LOG($<symbolinfo>1->getName()+" "+$<symbolinfo>2->getName()); 
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+"\n"+$<symbolinfo>2->getName()); 
	}
	;

statement: var_declaration {
		$<symbolinfo>$ = new SymbolInfo();
		LOG(lines,"statement -> var_declaration");
		LOG($<symbolinfo>1->getName());
		$<symbolinfo>$->setName($<symbolinfo>1->getName()); 
	}
	| expression_statement {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"statement -> expression_statement");
		LOG($<symbolinfo>1->getName()); 
		$<symbolinfo>$->setName($<symbolinfo>1->getName()); 
	}
	| compound_statement {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"statement -> compound_statement");
		LOG($<symbolinfo>1->getName()); 
		$<symbolinfo>$->setName($<symbolinfo>1->getName()); 
	}
	| FOR LPAREN expression_statement expression_statement expression RPAREN statement {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"statement -> FOR LPAREN expression_statement expression_statement expression RPAREN statement");
		LOG("for("+$<symbolinfo>3->getName()+" "+$<symbolinfo>4->getName()+" "+
		$<symbolinfo>5->getName()+")\n"+$<symbolinfo>7->getName());
		
		if($<symbolinfo>3->getDeclarationType()=="void "){
			errors++;
			ERROR(lines,"Type Mismatch! Variable Cannot Be Declared void ");
			//$<symbolinfo>$->setDeclarationType("int "); 
		}
		$<symbolinfo>$->setName("for("+$<symbolinfo>3->getName()+$<symbolinfo>4->getName()+$<symbolinfo>5->getName()+")\n"+$<symbolinfo>5->getName()); 
	}
	| IF LPAREN expression RPAREN statement %prec LOWER_THAN_ELSE {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"statement->IF LPAREN expression RPAREN statement");
		LOG("if("+$<symbolinfo>3->getName()+")\n"+$<symbolinfo>5->getName());
		
		if($<symbolinfo>3->getDeclarationType()=="void "){
			errors++;
			ERROR(lines,"Type Mismatch! Variable Cannot Be Declared void ");
			//$<symbolinfo>$->setDeclarationType("int "); 
		}
		$<symbolinfo>$->setName("if("+$<symbolinfo>3->getName()+")\n"+$<symbolinfo>5->getName()); 

	}
	| IF LPAREN expression RPAREN statement ELSE statement {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"statement->IF LPAREN expression RPAREN statement ELSE statement");
		LOG("if("+$<symbolinfo>3->getName()+")\n"+$<symbolinfo>5->getName()+"else\n"+$<symbolinfo>7->getName());
		if($<symbolinfo>3->getDeclarationType()=="void "){
			errors++;
			ERROR(lines," Type Mismatch ");
			//$<symbolinfo>$->setDeclarationType("int "); 
		}
		$<symbolinfo>$->setName("if("+$<symbolinfo>3->getName()+")\n"+$<symbolinfo>5->getName()+" else \n"+$<symbolinfo>7->getName()); 
	}

	| WHILE LPAREN expression RPAREN statement {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"statement->WHILE LPAREN expression RPAREN statement");
		LOG("while("+$<symbolinfo>3->getName()+")\n"+$<symbolinfo>5->getName());

		if($<symbolinfo>3->getDeclarationType()=="void "){
			errors++;
			ERROR(lines," Type Mismatch ");
			//	$<symbolinfo>$->setDeclarationType("int "); 
		}
		$<symbolinfo>$->setName("while("+$<symbolinfo>3->getName()+")\n"+$<symbolinfo>5->getName()); 
	}
	| PRINTLN LPAREN ID RPAREN SEMICOLON {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"statement->PRINTLN LPAREN ID RPAREN SEMICOLON");
		LOG("\n ("+$<symbolinfo>3->getName()+")");
		$<symbolinfo>$->setName("\n("+$<symbolinfo>3->getName()+")"); 
	}
	| RETURN expression SEMICOLON {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"statement->RETURN expression SEMICOLON");
		LOG("return "+$<symbolinfo>2->getName());
		if($<symbolinfo>2->getDeclarationType()=="void "){
			errors++;
			ERROR(lines," Type Mismatch ");
			$<symbolinfo>$->setDeclarationType("int "); 
		}
		$<symbolinfo>$->setName("return "+$<symbolinfo>2->getName()+";"); 
	}
	;

expression_statement: SEMICOLON	{
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"expression_statement->SEMICOLON");
		LOG(";"); 
		$<symbolinfo>$->setName(";"); 
	}
	| expression SEMICOLON {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"expression_statement->expression SEMICOLON");
		//TODO: Uncomment ? 
		LOG($<symbolinfo>1->getName()+";");
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+";"); 
	}
	;

variable: ID {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"variable->ID");
		LOG($<symbolinfo>1->getName());
		if(symbolTable->lookUp($<symbolinfo>1->getName())==nullptr){
			errors++;
			ERROR(lines," Undeclared Variable: "+$<symbolinfo>1->getName());
		}
		else if(symbolTable->lookUp($<symbolinfo>1->getName())->getDeclarationType()=="int array" || symbolTable->lookUp($<symbolinfo>1->getName())->getDeclarationType()=="float array"){
			errors++;
			ERROR(lines," Not an array: "+$<symbolinfo>1->getName());
		}
		if(symbolTable->lookUp($<symbolinfo>1->getName())!=nullptr){
			//cout<<lines<<" "<<$<symbolinfo>1->getName()<<" "<<symbolTable->lookUp($<symbolinfo>1->getName())->getDeclarationType()<<endl;
			$<symbolinfo>$->setDeclarationType(symbolTable->lookUp($<symbolinfo>1->getName())->getDeclarationType()); 
		}
		$<symbolinfo>$->setName($<symbolinfo>1->getName()); 
												
	}
	| ID LTHIRD expression RTHIRD  {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"variable->ID LTHIRD expression RTHIRD");
		LOG($<symbolinfo>1->getName()+"["+$<symbolinfo>3->getName()+"]");
		if(symbolTable->lookUp($<symbolinfo>1->getName())==nullptr){
			errors++;
			ERROR(lines,"Undeclared Variable :"+ $<symbolinfo>1->getName());
		}
		//cout<<lines<<" "<<$<symbolinfo>3->getDeclarationType()<<endl;
		if($<symbolinfo>3->getDeclarationType()=="float "||$<symbolinfo>3->getDeclarationType()=="void "){
			errors++;
			ERROR(lines," Non-integer Array Index  ");
		}
		if(symbolTable->lookUp($<symbolinfo>1->getName())!=nullptr){
			//cout<<lines<<" "<<symbolTable->lookUp($<symbolinfo>1->getName())->getDeclarationType()<<endl;
			if(symbolTable->lookUp($<symbolinfo>1->getName())->getDeclarationType()!="int array" && symbolTable->lookUp($<symbolinfo>1->getName())->getDeclarationType()!="float array"){
				errors++;
				ERROR(lines," Type Mismatch ");	
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
		LOG(lines,"expression->logic_expression");
		LOG($<symbolinfo>1->getName());
		$<symbolinfo>$->setName($<symbolinfo>1->getName()); 
		$<symbolinfo>$->setDeclarationType($<symbolinfo>1->getDeclarationType()); 
	}
	| variable ASSIGNOP logic_expression {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"expression->variable ASSIGNOP logic_expression");
	   	LOG($<symbolinfo>1->getName()+"="+$<symbolinfo>3->getName());
		
		if($<symbolinfo>3->getDeclarationType()=="void "){
			errors++;
			ERROR(lines," Type Mismatch ");
			$<symbolinfo>$->setDeclarationType("int "); 
		}else if(symbolTable->lookUp($<symbolinfo>1->getName())!=nullptr) {
			//cout<<lines<<" "<<symbolTable->lookUp($<symbolinfo>1->getName())->getDeclarationType()<<""<<$<symbolinfo>3->getDeclarationType()<<endl;
			if(symbolTable->lookUp($<symbolinfo>1->getName())->getDeclarationType()!=$<symbolinfo>3->getDeclarationType()){
				errors++;
				ERROR(lines,"Type Mismatch ");
			}
		}
		$<symbolinfo>$->setDeclarationType($<symbolinfo>1->getDeclarationType()); 
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+"="+$<symbolinfo>3->getName());  

	}
	;
logic_expression: rel_expression {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"logic_expression->rel_expression");
		LOG($<symbolinfo>1->getName());
		$<symbolinfo>$->setName($<symbolinfo>1->getName()); 
		$<symbolinfo>$->setDeclarationType($<symbolinfo>1->getDeclarationType()); 
	}
	| rel_expression LOGICOP rel_expression {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"logic_expression->rel_expression LOGICOP rel_expression");
		LOG($<symbolinfo>1->getName()+$<symbolinfo>2->getName()+$<symbolinfo>3->getName());
		
		if($<symbolinfo>1->getDeclarationType()=="void "||$<symbolinfo>3->getDeclarationType()=="void "){
			errors++;
			ERROR(lines," Type Mismatch ");
			$<symbolinfo>$->setDeclarationType("int "); 
		}
		$<symbolinfo>$->setDeclarationType("int "); 
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+$<symbolinfo>2->getName()+$<symbolinfo>3->getName());  

	}
	;

rel_expression: simple_expression {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"rel_expression->simple_expression");
		LOG($<symbolinfo>1->getName());
		$<symbolinfo>$->setName($<symbolinfo>1->getName()); 
		$<symbolinfo>$->setDeclarationType($<symbolinfo>1->getDeclarationType()); 
	}
	| simple_expression RELOP simple_expression	 {
		$<symbolinfo>$=new SymbolInfo();
			LOG(lines,"rel_expression->simple_expression RELOP simple_expression");
			LOG($<symbolinfo>1->getName()+$<symbolinfo>2->getName()+$<symbolinfo>3->getName());
			if($<symbolinfo>1->getDeclarationType()=="void "||$<symbolinfo>3->getDeclarationType()=="void "){
				errors++;
				ERROR(lines," Type Mismatch! ");
				$<symbolinfo>$->setDeclarationType("int "); 
			}
			$<symbolinfo>$->setDeclarationType("int "); 
			
			$<symbolinfo>$->setName($<symbolinfo>1->getName()+$<symbolinfo>2->getName()+$<symbolinfo>3->getName());  
		}
	;

simple_expression: term {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"simple_expression->term");
		LOG($<symbolinfo>1->getName());
		$<symbolinfo>$->setDeclarationType($<symbolinfo>1->getDeclarationType());
		$<symbolinfo>$->setName($<symbolinfo>1->getName());  
	}
	| simple_expression ADDOP term {
		$<symbolinfo>$=new SymbolInfo(); 
		LOG(lines,"simple_expression->simple_expression ADDOP term");
		LOG($<symbolinfo>1->getName()+$<symbolinfo>2->getName()+$<symbolinfo>3->getName());
		//cout<<$<symbolinfo>3->getDeclarationType()<<endl;
		if($<symbolinfo>1->getDeclarationType()=="void "||$<symbolinfo>3->getDeclarationType()=="void "){
			errors++;
			ERROR(lines," Type Mismatch ");
			$<symbolinfo>$->setDeclarationType("int "); 
		}else if($<symbolinfo>1->getDeclarationType()=="float " ||$<symbolinfo>3->getDeclarationType()=="float ")
			$<symbolinfo>$->setDeclarationType("float ");
			else  $<symbolinfo>$->setDeclarationType("int ");
			$<symbolinfo>$->setName($<symbolinfo>1->getName()+$<symbolinfo>2->getName()+$<symbolinfo>3->getName());  
	}
	;

term: unary_expression {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"term->unary_expression");
		LOG($<symbolinfo>1->getName()); 
		$<symbolinfo>$->setDeclarationType($<symbolinfo>1->getDeclarationType()); 
		$<symbolinfo>$->setName($<symbolinfo>1->getName()); 
	}
    | term MULOP unary_expression {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"term->term MULOP unary_expression");
		LOG($<symbolinfo>1->getName()+$<symbolinfo>2->getName()+$<symbolinfo>3->getName());
		if($<symbolinfo>1->getDeclarationType()=="void "||$<symbolinfo>3->getDeclarationType()=="void "){
			errors++;
			ERROR(lines," Type Mismatch ");
			$<symbolinfo>$->setDeclarationType("int "); 
		}else if($<symbolinfo>2->getName()=="%"){
			if($<symbolinfo>1->getDeclarationType()!="int " ||$<symbolinfo>3->getDeclarationType()!="int "){
			errors++;
			ERROR(lines," Integer operand on modulus operator  ");

			} 
			$<symbolinfo>$->setDeclarationType("int "); 
		}
		else if($<symbolinfo>2->getName()=="/"){
			if($<symbolinfo>1->getDeclarationType()=="void "||$<symbolinfo>3->getDeclarationType()=="void "){
				errors++;
				ERROR(lines," Type Mismatch ");
				$<symbolinfo>$->setDeclarationType("int "); 
			}
			else  if($<symbolinfo>1->getDeclarationType()=="int " && $<symbolinfo>3->getDeclarationType()=="int ")$<symbolinfo>$->setDeclarationType("int "); 
			else $<symbolinfo>$->setDeclarationType("float "); 
			
		}
		else{
			if($<symbolinfo>1->getDeclarationType()=="void "||$<symbolinfo>3->getDeclarationType()=="void "){
				errors++;
				ERROR(lines," Type Mismatch!");
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
	LOG(lines,"unary_expression->ADDOP unary_expression");
	LOG($<symbolinfo>1->getName()+$<symbolinfo>2->getName());
	if($<symbolinfo>2->getDeclarationType()=="void "){
		errors++;
		ERROR(lines," Type Mismatch ");
		$<symbolinfo>$->setDeclarationType("int "); 
	}else 
		$<symbolinfo>$->setDeclarationType($<symbolinfo>2->getDeclarationType()); 	
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+$<symbolinfo>2->getName()); 

	}
	| NOT unary_expression {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"unary_expression->NOT unary_expression");
		LOG("!"+$<symbolinfo>2->getName()); 
		if($<symbolinfo>2->getDeclarationType()=="void "){
			errors++;
			ERROR(lines," Type Mismatch ");
			$<symbolinfo>$->setDeclarationType("int "); 
		}else 
			$<symbolinfo>$->setDeclarationType($<symbolinfo>2->getDeclarationType());  
			$<symbolinfo>$->setName("!"+$<symbolinfo>2->getName()); 
	}
	| factor {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"unary_expression->factor");
		LOG($<symbolinfo>1->getName()); 
		// cout<<$<symbolinfo>1->getDeclarationType()<<endl;
		$<symbolinfo>$->setDeclarationType($<symbolinfo>1->getDeclarationType()); 
		$<symbolinfo>$->setName($<symbolinfo>1->getName()); 
				
	}
	;

factor: variable {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"factor->variable");
		LOG($<symbolinfo>1->getName());
		$<symbolinfo>$->setDeclarationType($<symbolinfo>1->getDeclarationType()); 
		$<symbolinfo>$->setName($<symbolinfo>1->getName()); 
	}
	| ID LPAREN argument_list RPAREN {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"factor->ID LPAREN argument_list RPAREN");
		LOG($<symbolinfo>1->getName()+"("+$<symbolinfo>3->getName()+")");
		SymbolInfo* s=symbolTable->lookUp($<symbolinfo>1->getName());
		if(s==nullptr){
			errors++;
			ERROR(lines," Undefined Function ");
			$<symbolinfo>$->setDeclarationType("int "); 
		}
		else if(s->get_isFunction()==nullptr){
			errors++;
			ERROR(lines," Not A Function ");
			$<symbolinfo>$->setDeclarationType("int "); 
		}
		else {
			if(s->get_isFunction()->get_isdefined()==0){
				errors++;
				ERROR(lines," Undeclared Function ");
			}
			int num=s->get_isFunction()->get_number_of_parameter();
			//cout<<lines<<" "<<arg_list.size()<<endl;
			$<symbolinfo>$->setDeclarationType(s->get_isFunction()->get_return_type());
			if(num!=arg_list.size()){
				errors++;
				ERROR(lines," Invalid number of arguments ");
			}
			else{
				//cout<<s->get_isFunction()->get_return_type()<<endl;
				vector<string>param_list=s->get_isFunction()->get_paralist();
				vector<string>para_type=s->get_isFunction()->get_paratype();
				for(int i=0;i<arg_list.size();i++){
					if(arg_list[i]->getDeclarationType()!=para_type[i]){
						errors++;
						ERROR(lines,"Type Mismatch ");
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
		LOG(lines,"factor->LPAREN expression RPAREN");
		LOG("("+$<symbolinfo>2->getName()+")"); 
		$<symbolinfo>$->setDeclarationType($<symbolinfo>2->getDeclarationType()); 
		$<symbolinfo>$->setName("("+$<symbolinfo>2->getName()+")"); 
	}
	| CONST_INT { 
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"factor->CONST_INT");
		LOG($<symbolinfo>1->getName());
		$<symbolinfo>$->setDeclarationType("int "); 	
		$<symbolinfo>$->setName($<symbolinfo>1->getName()); 
			
	}
	| CONST_FLOAT {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"factor->CONST_FLOAT");
		LOG($<symbolinfo>1->getName()); 
		$<symbolinfo>$->setDeclarationType("float "); 	
		$<symbolinfo>$->setName($<symbolinfo>1->getName()); 
				
	}
	| variable INCOP {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"factor->variable INCOP");
		LOG($<symbolinfo>1->getName()+"++"); 
		$<symbolinfo>$->setDeclarationType($<symbolinfo>1->getDeclarationType());
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+"++"); 
					 
	}
	| variable DECOP {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"factor->variable DECOP");
		LOG($<symbolinfo>1->getName()+"--");
		$<symbolinfo>$->setDeclarationType($<symbolinfo>1->getDeclarationType()); 
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+"--"); 
					 
	}
	;

argument_list: arguments {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"argument_list->arguments");
		LOG($<symbolinfo>1->getName());
		$<symbolinfo>$->setName($<symbolinfo>1->getName());
	}
	| %empty {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"argument_list-> ");
		$<symbolinfo>$->setName("");}
	;

arguments: arguments COMMA logic_expression {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"arguments->arguments COMMA logic_expression ");
		LOG($<symbolinfo>1->getName()+","+$<symbolinfo>3->getName());
		arg_list.push_back($<symbolinfo>3);
		$<symbolinfo>$->setName($<symbolinfo>1->getName()+","+$<symbolinfo>3->getName());
	}
	| logic_expression {
		$<symbolinfo>$=new SymbolInfo();
		LOG(lines,"arguments->logic_expression");
		LOG($<symbolinfo>1->getName()); 
		arg_list.push_back(new SymbolInfo($<symbolinfo>1->getName(),$<symbolinfo>1->getType(),$<symbolinfo>1->getDeclarationType()));
		// cout<<$<symbolinfo>1->getDeclarationType()<<endl;
		$<symbolinfo>$->setName($<symbolinfo>1->getName());					
	}
	;
 %%



int main(int argc,char *argv[])
{
	Util::clearFiles();
	if((fp=fopen(argv[1],"r"))==NULL)
	{
		printf("Cannot Open Input File.\n");
		return 0;
	}
	yyin=fp;
	yyparse();
	LOG("Final SymbolTable : ");
	symbolTable->printAllScopeTables();
	cout<<"Total Lines "<<lines<<endl;
	cout<<"Total Errors "<<errors<<endl;
	
	
	fclose(fp);
	
	return 0;
}


