//
// Created by Latif Siddiq Suuny on 28-Apr-18.
//

#include <bits/stdc++.h>
#include "1505069_function.h"
using namespace std;

class SymbolInfo
{
    string name, type, dectype;
    SymbolInfo *next;
    Function *isFunction;

public:
    SymbolInfo()
    {
        this->isFunction = nullptr;
        this->next = nullptr;
    }

    SymbolInfo(string sym_name, string sym_type, string sym_dec = "")
    {
        this->name = sym_name;
        this->type = sym_type;
        this->dectype = sym_dec;
        this->next = 0;
    }

    string get_name()
    {
        return this->name;
    }

    string get_type()
    {
        return this->type;
    }
    string get_dectype()
    {
        return this->dectype;
    }

    SymbolInfo *get_next()
    {
        return this->next;
    }

    string set_name(string new_name)
    {
        this->name = new_name;
        return this->name;
    }

    string set_type(string new_type)
    {
        this->type = new_type;
        return this->type;
    }
    string set_dectype(string new_type)
    {
        this->dectype = new_type;
        return this->dectype;
    }

    SymbolInfo *set_next(SymbolInfo *new_next)
    {
        this->next = new_next;
        return this->next;
    }
    void set_isFunction()
    {
        isFunction = new Function();
    }
    Function *get_isFunction()
    {
        return isFunction;
    }
};
