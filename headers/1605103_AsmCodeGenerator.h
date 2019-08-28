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
        string curFunction;
        int labelCount=0,tempCount=0;
        vector<string> vars;
        vector<string> func_var_dec;
        vector<pair<string,string>> arr_dec;



        string getIntro(){
            return ".MODEL SMALL\n.STACK 100H\n.DATA \n";
        }

        string getDeclarations(){
            string code="";
            for(int i=0;i<vars.size();i++){
		        code+=vars[i]+" dw ?\n";
	        }
            for(int i=0;i<arr_dec.size();i++){
		        code+=arr_dec[i].first+" dw "+arr_dec[i].second+" dup(?)\n";
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
            return "mov AX,@DATA\n\tmov DS,AX \n\n";
        }

        string getMainOutro(){
            return curFunction+":\n\tmov AH,4CH\n\tint 21H\n";
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
            push AX \n\
            push BX \n\
            push CX \n\
            push DX  \n\
            cmp AX,0 \n\
            jge BEGIN \n\
            push AX \n\
            mov DL,'-' \n\
            mov AH,2 \n\
            int 21H \n\
            pop AX \n\
            neg AX \n\
            \n\
            BEGIN : \n\
            xor CX,CX \n\
            mov BX,10 \n\
            \n\
            REPEAT : \n\
            xor DX,DX \n\
            div BX \n\
            push DX \n\
            inc CX \n\
            or AX,AX \n\
            jne REPEAT \n\
            mov AH,2 \n\
            \n\
            PRINT_LOOP : \n\
            pop DX \n\
            add DL,30H \n\
            int 21H \n\
            loop PRINT_LOOP \n\
            \n\
            mov AH,2\n\
            mov DL,10\n\
            int 21H\n\
            \n\
            mov DL,13\n\
            int 21H\n\
        	\n\
            pop DX \n\
            pop CX \n\
            pop BX \n\
            pop AX \n\
            ret \n\
        OUTDEC ENDP \n\
        END MAIN\n";
        }


};
