//
// Created by Ashiq-103 on 5/6/2019.
//
#ifndef COMPILEROFFLINE_UTIL_H
#define COMPILEROFFLINE_UTIL_H

#endif

#include <string>
#include <iostream>
#include "1605103_util.h"

using namespace std;

/**@class SymbolInfo is basically a Symbol LinkedList */

class SymbolInfo {
private:
    string name;
    string type;
    SymbolInfo *next;
public:
    SymbolInfo() {
        next = nullptr;
    }

    SymbolInfo(const string &name,const string &type) :name(name),type(type) {
        next = nullptr;
    }

    const string &getName() const {
        return name;
    }

    void setName(const string &name) {
        SymbolInfo::name = name;
    }

    const string &getType() const {
        return type;
    }

    void setType(const string &type) {
        SymbolInfo::type = type;
    }

    SymbolInfo *getNext() const {
        return next;
    }

    void setNext(SymbolInfo *next) {
        SymbolInfo::next = next;
    }

    bool equals(const SymbolInfo &rhs) {
        return getName() == rhs.getName() && getType() == rhs.getType();
    }

    string printLinkedList() {
        if (this == nullptr)
            return "";
        string output = this->toString() + " - ";
        output += this->getNext()->printLinkedList();
        return output;
    }

    string toString() const {
        return "<" + getName() + "," + getType() + ">";
    }

    friend istream &operator>>(istream &in, SymbolInfo &si);

    virtual ~SymbolInfo() {
        delete next;
    }

};


istream &operator>>(istream &in, SymbolInfo &si) {
    cout << "Enter Symbol Name :" << endl;
    in >> si.name;
    cout << "Enter Symbol Type :" << endl;
    in >> si.type;
    return in;
}
