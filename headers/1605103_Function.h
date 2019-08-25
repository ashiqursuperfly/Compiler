//
// Created by Ashiq-103 on 11/7/19.
//

using namespace std;

class Function
{
    string return_type;bool isdefined;
    vector<string> paramList,paramType,varsUsed;
    public:
        Function()
        {
            isdefined = false;
            paramList.clear();
            paramType.clear();
            return_type = "";
        }
        void clear(){
                paramList.clear();
                paramType.clear();
        }
       
        void setReturnType(string type)
        {
            this->return_type = type;
        }
        string getReturnType()
        {
            return return_type;
        }
        int getParamCount()
        {
            return paramList.size();
        }
        void addParam(string newpara, string type)
        {
            paramList.push_back(newpara);
            paramType.push_back(type);
        }
        void addVar(string s){           
            varsUsed.push_back(s);
        }
        vector<string>getVars(){
            // cout<<var_list.size()<<endl;
            return varsUsed;
        }
        vector<string> getAllParams()
        {
            return paramList;
        }
        vector<string> getAllParamTypes()
        {
            return paramType;
        }
        void setDefined()
        {
            this->isdefined = true;
        }
        bool isDefined()
        {
            return isdefined;
        }
};
