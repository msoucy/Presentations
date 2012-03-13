#include <cstdio>
void printPtr(void* p) {
    printf("%p",p);
}
int main() {
    char c = 'A';
    char* p = &c;
    printPtr(p);
}

