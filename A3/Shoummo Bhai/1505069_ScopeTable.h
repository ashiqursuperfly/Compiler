//
// Created by Latif Siddiq Suuny on 28-Apr-18.
//



#include <bits/stdc++.h>
#include "1505069_SymbolInfo.h"

using namespace std;

class ScopeTable
{
    int uniqueid,num;
    int pcon;
    SymbolInfo **symbol;
    ScopeTable *parentScope;
public:

    ScopeTable()
    {
        parentScope=0;
    }
    ScopeTable(int id,int n,ScopeTable *prev)
    {
        this->uniqueid=id;
        this->num=n;
        this->parentScope=prev;
        pcon=1;
        symbol=new SymbolInfo*[n];
        for(int i=0; i<n; i++)
        {
            symbol[i]=0;
        }


    }
    int Hash(string s)
    {
        unsigned long long  h = 5381;
        int len = s.length();

        for (int i = 0; i < len; i++)
            h += ((h * 33) + (unsigned long long )s[i]);

        return (h%this->num);
    }

    SymbolInfo *lookup(string target)
    {
        int hashv=Hash(target);
        SymbolInfo *temp=symbol[hashv];
        int pos=0;
        while(temp!=0)
        {
            if(temp->get_name()==target)
            {

                if(pcon)
                {
		//fprintf(logout," Found in ScopeTable# %d at position %d, %d\n",uniqueid,hashv,pos);
                   

                }
                return temp;
            }
            temp=temp->get_next();
            pos++;

        }

        if(pcon)
        {
	//fprintf(logout," %s not found\n",target.c_str());
           // cout<<target<<" not found"<<endl;
        }
        return temp;




    }
    bool Insert(string name,string type,string dectype)
    {
	
        pcon=0;
         SymbolInfo *temp=lookup(name);
        if(temp!=0)
        {
            //fprintf(logout,"< %s,%s > already exists in current ScopeTable\n",name.c_str(),type.c_str());
            return false;
        }


        int hashv=Hash(name);
        temp=symbol[hashv];
        SymbolInfo *new_symbol=new SymbolInfo(name,type,dectype);
        if(temp==0)
        { 
            symbol[hashv]=new_symbol;  


            //fprintf(logout," Inserted in ScopeTable# %d at position %d, 0\n",uniqueid,hashv); 
	    	//printScopeTable();
          
           
            return true;
        }

        int pos=0;
        while(temp->get_next()!=0)
        {
            temp=temp->get_next();
            pos++;

        }
        temp->set_next(new_symbol);
	    //printScopeTable();
       // cout<<"Inserted in ScopeTable# "<<uniqueid<<" at position "<<hashv<<", "<<pos+1<<endl;
        return true;



    }
    bool Delete(string name)
    {
        pcon=1;
        if(lookup(name)==0)
        {
            return false;
        }
        pcon=0;
        int hashv=Hash(name);
        SymbolInfo *temp=symbol[hashv];
        if(temp->get_name()==name)
        {
            symbol[hashv]=temp->get_next();
            cout<<" Deleted entry at "<<hashv<<", 0 from current ScopeTable"<<endl;
            return true;

        }
        SymbolInfo *prev=0;
        SymbolInfo *next=0;
        next=temp;
        int pos=0;
        while(next->get_name()!=name)
        {
            prev=next;
            next=next->get_next();
            pos++;
        }
        prev->set_next(next->get_next());
       // cout<<" Deleted entry at "<<hashv<<", "<<pos<<" from current ScopeTable"<<endl;
        return true;



    }
    void printScopeTable()
    {
        //fprintf(logout," ScopeTable# %d \n",uniqueid); 
        SymbolInfo *temp;

        for (int i = 0; i < num; i++)
        {

            temp = symbol[i];
	    	if(temp==0)
		{
			continue;
		}
	    //fprintf(logout," %d  --> ",i); 

        //cout <<" "<< i << " --> ";

        while (temp)
        {
	       // fprintf(logout,"< %s : %s > ",temp->get_type().c_str(),temp->get_name().c_str()); 
                

            // cout << "<" << temp->get_name() << " : " << temp->get_type()<< ">  ";
            temp = temp->get_next();
        }
	    //fprintf(logout,"\n"); 

           // cout<<endl;
        }
        //fprintf(logout,"\n"); 
    }

    void set_pcon(int x)
    {
        pcon=x;

    }
    int get_id()
    {
        return uniqueid;
    }
    ScopeTable *get_parent()
    {
        return parentScope;
    }
    ~ScopeTable()
    {
        for(int i=0; i<num; i++)
        {
            delete (symbol[i]);
        }
        delete(parentScope);
    }
};
