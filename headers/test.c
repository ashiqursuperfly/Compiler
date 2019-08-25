// #include <iostream>
// #include 1605103_ScopeTable.h

// using namespace std;

// void ScopeTableTest(ScopeTable *st)
// {
//     string name, type;
//     while (true)
//     {
//         cout << "1. insert 2.delete 3.lookup 4.print" << endl;
//         int choice;
//         cin >> choice;
//         switch (choice)
//         {
//         case 1:
//         {
//             SymbolInfo data;
//             cin >> data;
//             st->insert(data);
//             st->print();
//             break;
//         }
//         case 2:
//         {
//             SymbolInfo data;
//             cin >> data;
//             st->deleteSymbol(data.getName());
//             st->print();

//             break;
//         }
//         case 3:
//         {
//             SymbolInfo data;
//             cin >> data;
//             st->lookUp(data.getName());
//             break;
//         }
//         case 4:
//         {
//             st->print();
//             break;
//         }
//         case 5:
//         {
//             st->~ScopeTable();
//             break;
//         }
//         }
//         fflush(stdin);
//     }
// }

// int main(){
    
//     ScopeTableTest();
//     return 0;
// }