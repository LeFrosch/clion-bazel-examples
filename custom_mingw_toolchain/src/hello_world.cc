#include <iostream>
#include <windows.h>
#include <Lmcons.h>

int main() {
    DWORD username_len = UNLEN+1;
    char username[username_len];

    GetUserName(username, &username_len);

    std::cout << "Hello " << username << std::endl;

    return 0;
}

