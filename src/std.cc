module;
#include <cstdio>
#include <iostream>

export module std;
export void hello() { printf("Hello, world!\n"); }
export void hello2() { std::cout << "Hello, world!\n" << std::endl; }
