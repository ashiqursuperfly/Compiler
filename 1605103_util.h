//
// Created by Ashiq-103 on 5/6/2019.
//
#ifndef COMPILEROFFLINE_UTIL_H
#define COMPILEROFFLINE_UTIL_H
#endif
#include <string>
#include <iostream>
#include <algorithm>
#include <iterator>
#include <sstream>
#include <fstream>
#include <sys/stat.h>
#include <unistd.h>
using namespace std;

#define OUTPUT_FILE "output_symbolTable.txt"
#define INPUT_FILE "input_symbolTable.txt"

#define LOG_FILE "1605103_log.txt"
#define TOKEN_FILE "1605103_token.txt"


inline bool isFileExists (const string& name) {
  struct stat buffer;
  return (stat (name.c_str(), &buffer) == 0);
}

void appendToFile(const string & data){
    ofstream outfile;

    outfile.open(OUTPUT_FILE, std::ios_base::app);
    outfile << data;
}
void appendLogError(int line_no,const string & error_msg){
    ofstream outfile;

    outfile.open(LOG_FILE, std::ios_base::app);
    outfile <<"Line No:"<<line_no<<" Error"<<": "<<error_msg<<endl;
}
void appendLog(const string & data){
    ofstream outfile;
    
    outfile.open(LOG_FILE, std::ios_base::app);
    outfile << data<<endl;
}
void appendLog(int line_no,const string & token,const string & lexeme){
    ofstream outfile;

    outfile.open(LOG_FILE, std::ios_base::app);
    outfile << "Line No:"<<line_no<<" Token: "<<token<<" Lexeme: "<<lexeme<<endl;;
}
void appendToken(const string & symbol){
    ofstream outfile;

    outfile.open(TOKEN_FILE, std::ios_base::app);
     outfile <<"< "<<symbol<<" >"<<endl;
}
void appendToken(const string & type,const string & symbol){
    ofstream outfile;

    outfile.open(TOKEN_FILE, std::ios_base::app);
    outfile <<"< "<<type<<" , "<<symbol<<" >"<<endl;
}
void appendToken(const string & type,char symbol){
    ofstream outfile;

    outfile.open(TOKEN_FILE, std::ios_base::app);
    outfile <<"< "<<type<<" , "<<symbol<<" >"<<endl;
}
void clearFiles(){
	if(isFileExists(OUTPUT_FILE))remove(OUTPUT_FILE);
	if(isFileExists(LOG_FILE))remove(LOG_FILE);
	if(isFileExists(TOKEN_FILE))remove(TOKEN_FILE);
}


template <class Container> void readAllFromFile(Container& container){
    ifstream inFile(INPUT_FILE);
    string line;
    while (std::getline(inFile, line))
    {
        container.push_back(line);
    }
}

void printMessage(string tag,string msg){
    //cout<<tag<<" : "<<msg<<endl;
    appendToFile(tag + " : "+msg+"\n");
    fflush(stdout);
}

template <class Container> void split(const std::string& str, Container& cont,
            char delim = ' ')
{
    std::size_t current, previous = 0;
    current = str.find(delim);
    while (current != std::string::npos) {
        cont.push_back(str.substr(previous, current - previous));
        previous = current + 1;
        current = str.find(delim, previous);
    }
    cont.push_back(str.substr(previous, current - previous));
}
