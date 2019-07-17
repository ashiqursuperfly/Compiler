//
// Created by Ashiq-103 on 11/7/19.
//

using namespace std;

class Function
{
    string return_type;bool isdefined;
    vector<string> paramList,paramType;
public:
    Function()
    {
        isdefined = false;
        paramList.clear();
        paramType.clear();
        return_type = "";
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
