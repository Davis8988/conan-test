// MathLibrary.cpp
// compile with: cl /c /EHsc MathLibrary.cpp
// post-build command: lib MathLibrary.obj

#include "Printings.h"
#include <string>
#include <iostream>

namespace Printings
{
    void Printer::Print(std::string s) 
    {
        std::cout << s;
    }

    void Printer::Println(std::string s) 
    {
        std::cout << s << "\n";
    }
    
}