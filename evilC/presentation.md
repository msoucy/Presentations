Evil C/C++
==========
Things that you should probably never do, and other C tricks
------------------------------------------------------------

- Presented/created by Matt Soucy
- Ranked from least to most evil (IMHO)

---
Not evil
========

---
Prerequisites
=============

Some of these tricks require knowledge of various shenanigans:

 * Pointers
 * Basic bit twiddling (&, |, ^, ~)
 * Hex and Octal literals (May count as evil actually)
 * Ternary operator
 * Switch statements, labels, etc

If you don't know these, you may get lost in the insanity that will follow.

---
String Concatenation
====================

Two string literals, placed "next to" each other, will be treated as one:

    !cpp
    printf("abc" "def"); // == printf("abcdef")

This is useful for long strings (such as insanely complex printf formatting strings) that you can extend onto more than one line

---
Octal
=====
There is a HUGE difference between the following:

    !cpp
    int x = 10; // decimal 10
    int y = 010; // decimal 8
    int z = 0x10; // decimal 16

---
Slightly evil
=============
---
Void pointers
=============

Can be used as any pointer type, and point to any data type
In order to use it as anything other than just a pointer, it must be cast

    !cpp
    #include <cstdio>
    void printPtr(void* p) {
        *(char*)p += 1;
        printf("%p",p); // Pointer printf
    }
    int main() {
        char c = 'A';
        char* p = &c;
        printPtr(p);
    }

---
sizeof
======
Most people have heard of the sizeof command, however, they are unaware that sizeof doesn't actually evaluate its contents.
The entire thing is performed at compile time, but not executed - it returns the size of the result of the expression, and compiles that in.
The original code doesn't actually make it to the executable.

---
The comma operator
==================

Commas are useful for more than just separating function arguments:

    !cpp
    int foo() {return 5;}
    int bar() {return 6;}
    int baz() {return 7;}

    int x = (foo(),bar(),baz());
    cout << x; // Outputs 7

You may be familiar with the comma in for loops and variable declarations:

    !cpp
    int x=2,y=3;
    for(int i=0,j=2;i<j;i++) { /*do stuff*/}

Now try sticking them in, say, an if statement:

    !cpp
    int x=0;
    if(cin>>x,x*=2,x<8) { /*do stuff*/}

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
---
# Array/pointer tricks
---
Simple magic
============
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
---
By extension
============
String literals have a type of const char*.

It's perfectly legal to index a const char*.

Because of this, you're allowed to do something like this:

    !cpp
    // Gets the lowest hex value of a variable
    "0123456789abcdef"[x & 0xf];
    // Indexes into the string, but does the same thing
    (x & 0xf)["0123456789abcdef"];

---
# Fairly evil
---
Trigraphs
=========
In order to support those poor programmers who don't have access to such exotic keys as {}, C/C++ support the following:

<h3><table>
    <tr>
        <td>Trigraph</td>
        <td>Equivalent</td>
        <td />
        <td>Trigraph</td>
        <td>Equivalent</td>
    </tr>
    <tr>
        <td>??=</td>
        <td>#</td>
        <td />
        <td>??/</td>
        <td>\</td>
        <td />
        <td>??'</td>
        <td>^</td>
    </tr>
    <tr>
        <td>??(</td>
        <td>[</td>
        <td />
        <td>??)</td>
        <td>]</td>
        <td />
        <td>??!</td>
        <td>|</td>
    </tr>
    <tr>
        <td>??&gt;</td>
        <td>{</td>
        <td />
        <td>??&lt;</td>
        <td>}</td>
		<td />
        <td>??-</td>
        <td>~</td>
    </tr>
</table></h3>

Important:

 * These require the -trigraphs flag in GCC.
 * `???` is not a valid trigraph
 * Replacements are made as the FIRST step of the preprocessor
 * Trigraphs within strings are replaced - to prevent this, do "?""?-" instead of "??-"
 * With the advent of raw strings (C++11), in order to safely remove all trigraphs you essentially need to write a complete C++ parser.
---
Digraphs
========
There are also digraphs, meant to be more readable:

<h3><table>
    <tr>
        <td>Digraph</td>
        <td>Equivalent</td>
    </tr>
    <tr>
        <td>&gt;:</td>
        <td>[</td>
    </tr>
    <tr>
        <td>:&lt;</td>
        <td>]</td>
    </tr>
    <tr>
        <td>&gt;%</td>
        <td>{</td>
    </tr>
    <tr>
        <td>%&lt;</td>
        <td>}</td>
    </tr>
    <tr>
        <td>%:</td>
        <td>#</td>
    </tr>
</table></h3>

Differences:

 * Digraphs within strings will NOT be replaced
 * -trigraphs isn't required for these
 * Checked during tokenization in the preprocessor
 * A digraph must represent a full token by itself, except for %:%:, which replaces the preprocessor ##
---
What we've covered so far
=========================

    !cpp
    ??=include <cstdio>
    int main() <%
        // Syntax highlighting doesn't like any of this
        printf("Hello, world!\n");
        printf("5 XOR 2 = %d\n", 5 ??' (17,2)); //??/
        These lines looks like they break code, but the ??/
        continues the comment from the previous lines ??/
        printf("%d",1/0); // Doesn't actually get run, still commented out
        return 0;
    ??>
---
# Pretty evil
---
The ternary operator
====================

The ternary operator, using the format (x?y:z), is used similarly to the following:

    !cpp
    if(x) {y} else {z}

However, it's actually much more diabolical:

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
Abusing destructors
===================
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
Include tricks
==============
The preprocessor uses a textual replace for #include, replacing the #include with the (preprocessed) body of the file.

You can take advantage of this for some fun tricks.

Someone unfamiliar with the preprocessor may be confused by this

What does this example expand to?

####(Example courtesy of Dr. Dobbs)

colors.def
---------

    !cpp
    X(red),
    X(green),
    X(blue)

---
Include tricks (cont.)
======================
main.cpp
--------

    !cpp
    #include <stdio.h>

    #define X(a) a,
    enum COLOR {
      #include "colors.def"
    };
    #undef X

    #define X(a) #a,
    char *color_name[] = {
      #include "colors.def"
    };
    #undef X

    int main() {
      enum COLOR c = red;
      printf("c=%s\n", color_name[c]);
      return 0;
    }

---
Include tricks (cont.)
======================
The end result:
---------------
    !cpp
    #include <stdio.h>

    enum COLOR {
      red,
      green,
      blue
    };

    char *color_name[] = {
      "red",
      "green",
      "blue"
    };

    int main() {
      enum COLOR c = red;
      printf("c=%s\n", color_name[c]);
      return 0;
    }
---
Function Pointers
=================
Since you can create a pointer to a variable, it makes sense that you can create a pointer to a function.
The syntax is rather ugly though...

    !cpp
    #include <cstdio>

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

---
# Abandon all hope ye who enter here
---
Switch Statements
=================

How do switch statements work?
------------------------------
An ordinary switch statement might look something like this:

    !cpp
    switch( x ) {
    case 0:
        printf("Case 0\n");
        break;
    case 1:
        printf("Case 1\n");
        break;
    case 2:
        printf("Case 2\n");
        break;
    default:
        // do nothing
        break;
    }

---
Switch Statements (cont.)
=========================

Regular switch statements, by default, have a unique scope for the whole switch (as shown by the {}).

However, if you want to pass through to the next case, this poses problems and will error:

    !cpp
    switch( x ) {
    case 0:
        int y = 0;
        printf("int: %d\n",y);
    case 1:
        char y = 'A'; // Error: y is already an int
        printf("char: %c\n",y);
    case 2:
        float y = 'A';
        printf("float: %f\n",y);
    default:
        // do nothing
        break;
    }

---
Switch Statements (cont.)
=========================

This can be used to properly handle scope for each case, as well as group statements together logically:

    !cpp
    switch(x) {
	case 0: {
		int y = 0;
		printf("int: %d\n",y);
	}
	case 1: {
		char y = 'A'; // Error: y is already an int
		printf("char: %c\n",y);
	}
	case 2: {
		float y = 'A';
		printf("float: %f\n",y);
	}
	default: {
		// do nothing
		break;
	}
	}

---
Switch Statements (cont.)
=========================

We're able to combine switch and if in some convoluted ways:

    !cpp
    switch(x) {
	case 0: {
		int y = 0;
		printf("int: %d\n",y);
	} if(0)
	case 1: {
		char y = 'A'; // Error: y is already an int
		printf("char: %c\n",y);
	} if(0)
	case 2: {
		float y = 'A';
		printf("float: %f\n",y);
	}
	case 3: {
		printf("Gets run iff x is 0, 1, 2, or 3\n");
	} if(0)
	default: {
		// do nothing
		printf("Not a valid choice!\n");
		break;
	}
	}

---
Duff's Device
=============

This trick was used with a for loop for this lovely, famous bit of code:

    !cpp
    void duff(char* to, char* from, short count)
    {
        char n = (count + 7) / 8;
        switch(count % 8) {
        case 0:     do {     *to++ = *from++;
        case 7:              *to++ = *from++;
        case 6:              *to++ = *from++;
        case 5:              *to++ = *from++;
        case 4:              *to++ = *from++;
        case 3:              *to++ = *from++;
        case 2:              *to++ = *from++;
        case 1:              *to++ = *from++;
                    } while(--n > 0);
        }
    }

What does this code do?

---
#C++ Evil
---
Templates
=========

Templates are often regarded to be immensely evil due to their "interesting" syntax.


	!cpp
	#include <cstdio>
	#include <vector>
	using std::vector;

	template<int N> class Foo {
		int x:N; // Generate a compiler error if N==0
	};
	template<typename T> class Bar {};

	template<int N> struct Bin() {
		Bin(){
			Bin<T>>1> B; printf("%d",T%2);
		}
	};
	struct Bin<O>{}; // Base case

	int main() {
		vector<vector<int> > x; // There has to be a space between the > >
		Foo<(2>1)> y; // Booleans "graduate" to integers, so this is legal
		//Foo<(1>2)> q; // Creates a zero-width bitfield, so illegal
		Bar<int> z; // Legal, "typename" matches "int"
		Bin<42>();
		return 0;
	}
---
C++0x Lambdas
=====

The latest revision of the C++ standard, C++11, added support for lambda functions.

These are awesome and make some of the standard library's functions actually usable.

However they can VERY easily be used for evil:

	!cpp
	#include <cstdio>

	int main() {
		// Harmless example
		printf("%d\n",[]{return 2+2;}());
		[](){}(); // Does absolutely nothing but scare future readers
		// And you can capture them with function pointers!
		int(*f)(int) = [](int x) {return x+2;};
		printf("%d\n",f(5));
		return 0;
	}

---
return 0;
==========
