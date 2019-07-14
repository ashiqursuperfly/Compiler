//
// Created by Ashiq-103 on 5/6/2019.
//

#include <string>
#include <iostream>
#include <vector>
#include "1605103_Util.h"
#include "1605103_Function.h"
using namespace std;

/**@class SymbolInfo is basically a Symbol LinkedList */

class SymbolInfo
{
private:
    string name;
    string type;
    string declarationType; // Function,Variable, empty(not a declaration)
    SymbolInfo *next;
    Function *isFunction;

public:
    SymbolInfo()
    {
        next = nullptr;
        isFunction = nullptr;
    }

    SymbolInfo(const string &name, const string &type, string decType = "")
        : name(name), type(type), declarationType(decType)
    {
        next = nullptr;
        isFunction = nullptr;
    }

    const string &getName() const
    {
        return name;
    }

    void setName(const string &name)
    {
        SymbolInfo::name = name;
    }

    const string &getType() const
    {
        return type;
    }

    void setType(const string &type)
    {
        SymbolInfo::type = type;
    }

    const string &getDeclarationType() const
    {
        return declarationType;
    }

    void setDeclarationType(const string &type)
    {
        SymbolInfo::declarationType = type;
    }

    SymbolInfo *getNext() const
    {
        return next;
    }

    void setNext(SymbolInfo *next)
    {
        SymbolInfo::next = next;
    }
    void set_isFunction()
    {
        isFunction = new Function();
    }
    Function *get_isFunction()
    {
        return isFunction;
    }
    bool equals(const SymbolInfo &rhs)
    {
        return getName() == rhs.getName() && getType() == rhs.getType();
    }

    string printLinkedList()
    {
        if (this == nullptr)
            return "";
        string output = this->toString() + " - ";
        output += this->getNext()->printLinkedList();
        return output;
    }

    string toString() const
    {
        return "<" + getType() + "," + getName() + ">";
    }

    //friend istream &operator>>(istream &in, SymbolInfo &si);

    virtual ~SymbolInfo()
    {
        delete next;
    }
};

// istream &operator>>(istream &in, SymbolInfo &si)
// {
//     cout << "Enter Symbol Name :" << endl;
//     in >> si.name;
//     cout << "Enter Symbol Type :" << endl;
//     in >> si.type;
//     return in;
// }
