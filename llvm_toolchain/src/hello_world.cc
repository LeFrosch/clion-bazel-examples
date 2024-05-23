#include <iostream>

int main() {
#ifdef __llvm__
    std::cout << "Hello, LLVM!" << std::endl;
#else
    std::cout << "Hello, there!" << std::endl;
#endif
    return 0;
}

