//
// Created by Ashiq-103 on 5/6/2019.
//
#ifndef COMPILEROFFLINE_UTIL_H
#define COMPILEROFFLINE_UTIL_H

#endif

#include <string>
#include <iostream>

#include "1605103_SymbolInfo.h"

using namespace std;

class ScopeTable {

private:
    SymbolInfo **hashtable;
    ScopeTable *parentScope;

    int hash(const string &key) {
        int hashcode = 7;
        int len = key.length();
        for (int i = 0; i < len; i++) {
            hashcode = hashcode * 31 + key[i];
        }
        return abs(hashcode) % size;
    }

public:
    int size, id;

    ScopeTable(int id, int size) {
        this->id = id;
        this->size = size;
        hashtable = new SymbolInfo *[size];
        parentScope = nullptr;
        for (int i = 0; i < size; ++i) {
            hashtable[i] = nullptr;
        }
    }

    ScopeTable *getParentScope() const {
        return parentScope;
    }

    void setParentScope(ScopeTable *parentScope) {
        ScopeTable::parentScope = parentScope;
    }

    bool deleteSymbol(const string &symbol_name) {

        if (lookUp(symbol_name) == nullptr) {
            string msg = "ScopeTable " + to_string(id) + " Error : Symbol Not Found";
            printMessage("Delete From", msg+"\n");
            return false;
        }
        int row = hash(symbol_name);
        int col = 0;

        SymbolInfo *iterator = hashtable[row];

        if (iterator->getName() == symbol_name) {
            hashtable[row] = iterator->getNext();
            delete iterator;

            string msg = "ScopeTable " + to_string(id) + " Position(" + to_string(row) + "," + to_string(col) +
                         ") Successful";
            printMessage("Delete From", msg+"\n");
            return true;
        }
        col++;
        while (iterator->getName() != symbol_name) {
            iterator = iterator->getNext();
            col++;
        }
        SymbolInfo *newNext = nullptr;
        if (iterator->getNext() != nullptr)
            newNext = iterator->getNext()->getNext();
        delete iterator->getNext();
        iterator->setNext(newNext);

        string msg ="ScopeTable " + to_string(id) + " Position(" + to_string(row) + "," + to_string(col) + ") Successful";
        printMessage("Delete From", msg+"\n");
        return true;
    }

    bool insert(const SymbolInfo &si) {
        if (lookUp(si.getName()) != nullptr) {
            printMessage("Insert", "Error ! Symbol Already Exists.\n");
            return false;
        }
        int row = hash(si.getName());
        int col = 0;
        auto *newData = new SymbolInfo(si.getName(), si.getType());
        if (hashtable[row] == nullptr) {
            hashtable[row] = newData;
        } else {
            col++;
            SymbolInfo *iterator = hashtable[row];
            while (iterator->getNext() != nullptr) {
                iterator = iterator->getNext();
                col++;
            }
            iterator->setNext(newData);
            newData->setNext(nullptr);

        }

        printMessage("Insert At",
                     "ScopeTable :" + to_string(id) + " Symbol"+si.toString()+" Position(" + to_string(row) + "," + to_string(col) +
                     ") Successful\n");
        return true;

    }

    SymbolInfo *lookUp(const string& symbol_name) {
        int row = hash(symbol_name);
        int col = 0;
        SymbolInfo *iterator = hashtable[row];
        while (iterator != nullptr) {
            if (iterator->getName() == symbol_name) {
                printMessage("LookUp At", "ScopeTable :" + to_string(id) + " Found " + iterator->toString() + " Position(" +
                                          to_string(row) + "," + to_string(col) + ")\n");
                return iterator;
            }
            iterator = iterator->getNext();
            col++;
        }
        printMessage("LookUp At", "ScopeTable :" + to_string(id) + " Symbol<" + symbol_name + "> Not Found !\n");
        return nullptr;
    }

    void print() {
        printMessage("Print","SCOPE TABLE #" + to_string(id)+"\n");
	    parserLog("\n  SCOPE TABLE #" + to_string(id));
        for (int i = 0; i < size; ++i) {
            string output;
            if (hashtable[i] != nullptr){
                output += hashtable[i]->printLinkedList();
                printMessage("  "+to_string(i),output+"\n");
                parserLog("  "+to_string(i)+":"+output);
            }
            // printMessage(""+to_string(i),output+"\n");
	          // appendLog(""+to_string(i)+":"+output+"\n");
        }
        parserLog("\n");
    }

    virtual ~ScopeTable() {
        delete[] hashtable;
        hashtable = nullptr;
        delete parentScope;
        parentScope = nullptr;
    }

};

//TEST
void ScopeTableTest(ScopeTable *st) {
    string name, type;
    while (true) {
        cout << "1. insert 2.delete 3.lookup 4.print" << endl;
        int choice;
        cin >> choice;
        switch (choice) {
            case 1: {
                SymbolInfo data;
                cin >> data;
                st->insert(data);
                st->print();
                break;
            }
            case 2: {
                SymbolInfo data;
                cin >> data;
                st->deleteSymbol(data.getName());
                st->print();

                break;
            }
            case 3: {
                SymbolInfo data;
                cin >> data;
                st->lookUp(data.getName());
                break;
            }
            case 4: {
                st->print();
                break;

            }
            case 5: {
                st->~ScopeTable();
                break;

            }

        }
        fflush(stdin);
    }
}
