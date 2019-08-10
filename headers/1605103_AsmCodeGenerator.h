//
// Created by Ashiq-103 on 5/6/2019.
//

#include <string>

#include <cstring>
#include <iostream>
#include <algorithm>
#include <iterator>
#include <sstream>
#include <fstream>
#include <sys/stat.h>
#include <unistd.h>


class AsmCodeGenerator{

    bool isFileExists (const string& name) {
            struct stat buffer;
            return (stat (name.c_str(), &buffer) == 0);
    }
    
    public:
        int labelCount=0,tempCount=0;
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

        void generateFinalAsmFile(string fileName,const string& code){
            //if(isFileExists(fileName))remove(fileName);
            
            ofstream outfile;

            outfile.open(fileName, std::ios_base::app);
            outfile <<code;
    
        }
        char *newLabel()
        {
            char *lb= new char[4];
            strcpy(lb,"L");
            char b[3];
            sprintf(b,"%d", labelCount);
            labelCount++;
            strcat(lb,b);
            return lb;
        }

        char *newTemp()
        {
            char *t= new char[4];
            strcpy(t,"t");
            char b[3];
            sprintf(b,"%d", tempCount);
            tempCount++;
            strcat(t,b);
            return t;
        }


};