//
// Created by Ashiq-103 on 5/6/2019.
//

#include <string>
#include <iostream>
#include "SymbolInfo.h"

using namespace std;

class ScopeTable
{

private:
    SymbolInfo **hashtable;
    ScopeTable *parentScope;

    int hash(const string &key)
    {
        int hashcode = 7;
        int len = key.length();
        for (int i = 0; i < len; i++)
        {
            hashcode = hashcode * 31 + key[i];
        }
        return abs(hashcode) % size;
    }

public:
    int size, id;

    ScopeTable(int id, int size)
    {
        this->id = id;
        this->size = size;
        hashtable = new SymbolInfo *[size];
        parentScope = nullptr;
        for (int i = 0; i < size; ++i)
        {
            hashtable[i] = nullptr;
        }
        //scopeCount++;
        //cout<<"Created Scope:"<<this->id<<endl;
    }


    // static void setScopeCount(int val){
    //     ScopeTable::scopeCount = val;
    // }

    // static int getScopeCount(){
    //    return ScopeTable::scopeCount;
    // }

    ScopeTable *getParentScope() const
    {
        return parentScope;
    }

    void setParentScope(ScopeTable *parentScope)
    {
        ScopeTable::parentScope = parentScope;
    }

    bool deleteSymbol(const string &symbol_name)
    {

        if (lookUp(symbol_name) == nullptr)
        {
            string msg = "ScopeTable " + to_string(id) + " Error : Symbol Not Found";
            Util::printMessage("Delete From", msg + "\n");
            return false;
        }
        int row = hash(symbol_name);
        int col = 0;

        SymbolInfo *iterator = hashtable[row];

        if (iterator->getName() == symbol_name)
        {
            hashtable[row] = iterator->getNext();
            delete iterator;

            string msg = "ScopeTable " + to_string(id) + " Position(" + to_string(row) + "," + to_string(col) +
                         ") Successful";
            Util::printMessage("Delete From", msg + "\n");
            return true;
        }
        col++;
        while (iterator->getName() != symbol_name)
        {
            iterator = iterator->getNext();
            col++;
        }
        SymbolInfo *newNext = nullptr;
        if (iterator->getNext() != nullptr)
            newNext = iterator->getNext()->getNext();
        delete iterator->getNext();
        iterator->setNext(newNext);

        string msg = "ScopeTable " + to_string(id) + " Position(" + to_string(row) + "," + to_string(col) + ") Successful";
        Util::printMessage("Delete From", msg + "\n");
        return true;
    }

    bool insert(string sName,string sType,string sDecType)
    {
        if (lookUp(sName) != nullptr)
        {
            Util::printMessage("Insert", "Error ! Symbol Already Exists.\n");
            return false;
        }
        int row = hash(sName);
        int col = 0;
        auto *newData = new SymbolInfo(sName, sType, sDecType);
        if (hashtable[row] == nullptr)
        {
            hashtable[row] = newData;
        }
        else
        {
            col++;
            SymbolInfo *iterator = hashtable[row];
            while (iterator->getNext() != nullptr)
            {
                iterator = iterator->getNext();
                col++;
            }
            iterator->setNext(newData);
            newData->setNext(nullptr);
        }

        Util::printMessage("Insert At",
                     "ScopeTable :" + to_string(id) + " Symbol" + newData->toString() + " Position(" + to_string(row) + "," + to_string(col) +
                         ") Successful\n");
        return true;
    }

    SymbolInfo *lookUp(const string &symbol_name)
    {
        int row = hash(symbol_name);
        int col = 0;
        SymbolInfo *iterator = hashtable[row];
        while (iterator != nullptr)
        {
            if (iterator->getName() == symbol_name)
            {
                Util::printMessage("LookUp At", "ScopeTable :" + to_string(id) + " Found " + iterator->toString() + " Position(" +
                                              to_string(row) + "," + to_string(col) + ")\n");
                return iterator;
            }
            iterator = iterator->getNext();
            col++;
        }
        Util::printMessage("LookUp At", "ScopeTable :" + to_string(id) + " Symbol<" + symbol_name + "> Not Found !\n");
        return nullptr;
    }

    void print()
    {
        Util::printMessage("Print", "SCOPE TABLE #" + to_string(id) + "\n");
        Util::parserLog("\n  SCOPE TABLE #" + to_string(id));
        for (int i = 0; i < size; ++i)
        {
            string output;
            if (hashtable[i] != nullptr)
            {
                output += hashtable[i]->printLinkedList();
                Util::printMessage("  " + to_string(i), output + "\n");
                Util::parserLog("  " + to_string(i) + ":" + output);
            }
            // Util::printMessage(""+to_string(i),output+"\n");
            // appendLog(""+to_string(i)+":"+output+"\n");
        }
        Util::parserLog("\n");
    }

    virtual ~ScopeTable()
    {
        for(int i=0; i<size; i++)
        {
            delete (hashtable[i]);
        }
        delete(parentScope);
    }
};

// TEST
