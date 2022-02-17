// ConsoleApplication1.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include "headers/factorial.h"
#include "headers/MathLibrary.h"


using namespace std;
int main()
{
    int some_int = 5;
    int factorial_result = factorial(some_int);
    std::cout << "Hello World!\nFactorial result is: " << factorial_result << "\n";
    
    std::cout << "\nDone\n";
    system("pause");
}

