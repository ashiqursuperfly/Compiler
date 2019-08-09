//
// Created by Ashiq-103 on 5/6/2019.
//

#include <string>


class AsmCodeGenerator{

    public:
        vector<string> vars;
        vector<string> func_var_dec;
        vector<pair<string,string>> arrays;
        
        

        string getIntro(){
            return ".MODEL SMALL\n.STACK 100H\n.DATA \n";
        }

        string getDeclarations(){
            string code="";
            for(int i=0;i<vars.size();i++){
		        code+=vars[i]+" dw ?\n";
	        }
            for(int i=0;i<arrays.size();i++){
		        code+=arrays[i].first+" dw "+arrays[i].second+" dup(?)\n";
	        }
            return code;
        }


};