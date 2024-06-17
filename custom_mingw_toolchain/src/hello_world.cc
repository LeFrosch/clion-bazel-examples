#include <iostream>
#include <windows.h>

int main() {
    DWORD username_len = 64;
    char username[username_len];

    GetUserName(username, &username_len);

    std::cout << "Hello " << username << std::endl;

    return 0;
}

