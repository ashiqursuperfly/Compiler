//
// Created by Ashiq-103 on 11/7/19.
//

using namespace std;

class Function
{
    string return_type;
    vector<string> parameter_list;
    vector<string> parameter_type;
    bool isdefined;

public:
    Function()
    {
        isdefined = false;
        parameter_list.clear();
        parameter_type.clear();
        return_type = "";
    }
    void set_return_type(string type)
    {
        this->return_type = type;
    }
    string get_return_type()
    {
        return return_type;
    }
    int get_number_of_parameter()
    {
        return parameter_list.size();
    }
    void add_number_of_parameter(string newpara, string type)
    {
        parameter_list.push_back(newpara);
        parameter_type.push_back(type);
    }
    vector<string> get_paralist()
    {
        return parameter_list;
    }
    vector<string> get_paratype()
    {
        return parameter_type;
    }
    void set_isdefined()
    {
        this->isdefined = true;
    }
    bool get_isdefined()
    {
        return isdefined;
    }
};
