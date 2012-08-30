# Devious
---
#Array and pointer indexing
Given:

    !cpp
    int arr[100];

We know that:

 * arr is a specific type: an array
 * &arr is a pointer to an array
 * &arr[0] is the location of/a pointer to the first element of the array

Therefore, each of these is equivalent:

    !cpp
    arr[5]
    *(arr+5)
    5[arr]

####This is assuming, of course, that arr is a pointer/array, and not a class with operator[] overloaded

---
#By extension
String literals have a type of const char*.

It's perfectly legal to index a const char*.

Because of this, you're allowed to do something like this:

    !cpp
    // Gets the lowest hex value of a variable
    "0123456789abcdef"[x & 0xf];
    // Indexes into the string, but does the same thing
    (x & 0xf)["0123456789abcdef"];

---
#The ternary operator

The ternary operator, using the format `(x?y:z)`, becomes `y` if `x` is true, otherwise `z`

Here's a simple example:

    !cpp
    #include <stdio.h>

	int main() {
		int x = (1>2)?printf("Fail"):printf("Expected");
		printf("\n%d\n",x);
	}

However, it actually much more diabolical uses:

    !cpp
    int x,y,z;
    cin>>x>>y;
    z = (x>y)?x:y; // Sets z to the higher of x and y

Or, if you want to get REALLY crazy:

    !cpp
    int x,y;
    cin>>x>>y;
    // Sets the lower of x and y to the inverse of the other
    ((x<y)?x:y) = -((x>y)?x:y);

---
#Abusing destructors

Destructors are called when a class (or struct) leaves scope.

This includes when the program is cleaning up after itself when it's exiting main.

	!cpp
	#include <iostream>
	using namespace std;
	
	struct ProgramWrapper {
		~ProgramWrapper() {
			cin.sync();cin.ignore();
		}
	} wrapper;
	
	int main() {
		return 0;
	}

---
#Function Pointers

Since you can create a pointer to a variable, it makes sense that you can create a pointer to a function.
The syntax is rather ugly though...

    !cpp
    #include <stdio.h>

    int f(int x) {
	    return x+1;
    }
    int g(int x) {
	    return x*2;
    }
    int h(int x) {
	    return x-3;
    }

    typedef int(*FunctionPointer)(int); // Create a type FunctionPointer
    // This type points to a function taking an int and returning an int
    int main() {
	    FunctionPointer todo[3] = {f,g,h}; // Array of function pointers
	    int x=10;
	    for(unsigned i=0;i < 3;i++) {
		    x = todo[i](x);
	    }
        // Result should be 19
	    printf("Result>\t%d\n",x);
	    return 0;
    }


