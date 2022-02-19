// MathClient.cpp
// compile with: cl /EHsc MathClient.cpp /link MathLibrary.lib

#include <iostream>
#include <string>
#include "MathLibrary.h"
#include "Printings.h"

using namespace std;
int main()
{
    double a = 7.4;
    int b = 99;

    Printings::Printer::Println("a = " + to_string(a));
    Printings::Printer::Println("b = " + to_string(b));
    Printings::Printer::Print("\n");
    Printings::Printer::Println("a + b = " + to_string(MathLibrary::Arithmetic::Add(a, b)));
    Printings::Printer::Println("a - b = " + to_string(MathLibrary::Arithmetic::Subtract(a, b)));
    Printings::Printer::Println("a * b = " + to_string(MathLibrary::Arithmetic::Multiply(a, b)));
    Printings::Printer::Println("a / b = " + to_string(MathLibrary::Arithmetic::Divide(a, b)));

    system("pause");
    return 0;
    
}