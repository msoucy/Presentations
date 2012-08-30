# Harmless
---
#String Concatenation

Two string literals, placed "next to" each other, will be treated as one:

    !cpp
    printf("abc" "def"); // same as printf("abcdef")

This is useful for long strings (such as insanely complex printf formatting strings) that you can extend onto more than one line

---
#Octal
There is a HUGE difference between the following:

    !cpp
    int x = 10; // decimal 10
    int y = 010; // decimal 8
    int z = 0x10; // decimal 16

---
#Void pointers

Can be used as any pointer type, and point to any data type
In order to use it as anything other than just a pointer, it must be cast

    !cpp
    #include <stdio.h>
    void printPtr(void* p) {
        *(char*)p += 1;
        printf("%p",p); // Pointer printf
    }
    int main() {
        char c = 'A';
        char* p = &c;
        printPtr(p);
    }

Many C standard library functions use void* to accept pointers because of their properties

---
# Commenting out/testing values
If you need to change a value really quick to test something:

    !cpp
    int x =
	    //Actual_value
	    Testing_value
	    ;

Debug versions of code can use different values:

    !cpp
    int x =
    #if DEBUG
	    DEBUG_VALUE
    #else
	    ACTUAL_VALUE
    #endif
	    ;

