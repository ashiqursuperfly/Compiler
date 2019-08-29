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

class AssemblyCode{
  string assembly;
public:
  string& append(const string & code){
    assembly += code;
    return assembly;
  }
  string getFinalCode(){
    return assembly;
  }
};


class AsmCodeGenerator{

    bool isFileExists (const string& name) {
            struct stat buffer;
            return (stat (name.c_str(), &buffer) == 0);
    }

    public:
        string currentProcedure;
        int labelCount=0,tempCount=0;
        vector<string> vars;
        vector<string> funcLocalVars;
        vector<pair<string,string>> arrays;


        string getPushAllRegs(){
          return "\tpush ax\n\tpush bx \n\tpush cx \n\tpush dx\n";
        }

        string getIntro(){
            return ".model small\n.stack 100H\n.data \n";
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
            Util::clearFile(fileName);
            ofstream outfile;

            outfile.open(fileName, std::ios_base::app);
            outfile <<code;

        }

        string getMainIntro(){
            return "\tmov ax,@DATA\n\tmov ds,ax \n\n";
        }

        string getMainOutro(){
            return currentProcedure+":\n\tmov ah,4CH\n\tint 21H\n";
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
        string getPrintlnAssembly(){
            return "OUTDEC PROC  \n\
            push ax \n\
            push bx \n\
            push cx \n\
            push dx  \n\
            cmp ax,0 \n\
            jge BEGIN \n\
            push ax \n\
            mov DL,'-' \n\
            mov ah,2 \n\
            int 21H \n\
            pop ax \n\
            neg ax \n\
            \n\
            BEGIN: \n\
            xor cx,cx \n\
            mov bx,10 \n\
            \n\
            REPEAT: \n\
            xor dx,dx \n\
            div bx \n\
            push dx \n\
            inc cx \n\
            or ax,ax \n\
            jne REPEAT \n\
            mov ah,2 \n\
            \n\
            PRINT_LOOP: \n\
            pop dx \n\
            add DL,30H \n\
            int 21H \n\
            loop PRINT_LOOP \n\
            \n\
            mov ah,2\n\
            mov DL,10\n\
            int 21H\n\
            \n\
            mov DL,13\n\
            int 21H\n\
        	\n\
            pop dx \n\
            pop cx \n\
            pop bx \n\
            pop ax \n\
            ret \n\OUTDEC ENDP \nEND MAIN\n";
        }


};
