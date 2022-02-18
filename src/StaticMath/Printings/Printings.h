// Printings.h
#pragma once
#include <string>

namespace Printings
{
    class Printer
    {
    public:
        // Prints s
        static void Print(std::string s);

        // Print s and then new line
        static void Println(std::string s);
    };
}