#Evil

---

#Trigraphs
In order to support those poor programmers who don't have access to such exotic keys as {}, C/C++ support the following:

| Trigraph | Equivalent | Trigraph | Equivalent | Trigraph | Equivalent |
|:--------:|:----------:|:--------:|:----------:|:--------:|:----------:|
| ??= | # | ??/ | \ | ??' | ^ |
| ??( | [ | ??) | ] | ??! | &#124; |
| ??< | { | ??> | } | ??- | ~ |

Important:

 * These require the -trigraphs flag in GCC.
 * `???` is not a valid trigraph
 * Replacements are made as the FIRST step of the preprocessor
 * Trigraphs within strings are replaced - to prevent this, do "?""?-" instead of "??-"
 * With the advent of raw strings (C++11), in order to safely remove all trigraphs you essentially need to write a complete C++ parser.

---

#Digraphs
There are also digraphs, meant to be more readable:

 Digraph | Equivalent
---------|-----------
 <: | [
 >: | ]
 <% | {
 %> | }
 %: | #

Differences between trigraphs and digraphs:

 * Digraphs within strings will NOT be replaced
 * -trigraphs isn't required for these
 * Checked during tokenization in the preprocessor
 * A digraph must represent a full token by itself, except for %:%:, which replaces the preprocessor ##

---

#X-Macros

The preprocessor uses a textual replace for #include, replacing the #include with the (preprocessed) body of the file.

Someone unfamiliar with the preprocessor may be confused by this,
because it's common for beginners to assume that the preprocessor must produce complete tokens.
However, 

This means that the preprocesser can be used to generate some types of code.

---

#X-macros Example

###colors.def
    !cpp
    X(red)
    X(green)
    X(blue)

###main.cpp
    !cpp
    #include <stdio.h>

    #define X(a) a,
    enum COLOR {
      #include "colors.def"
    };
    #undef X

    #define X(a) #a,
    const char *color_name[] = {
      #include "colors.def"
    };
    #undef X

    int main() {
      enum COLOR c = red;
      printf("c=%s\n", color_name[c]);
      return 0;
    }

---

#X-Macros final result

###The end result:

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

.notes: Example blatantly stolen from [Randy Meyers](http://www.drdobbs.com/the-new-c-x-macros/184401387)

---

#Supermacros

By using `#undef` within the X-macro file, any code that uses it won't have to clean up after itself.

You can use #define and X-macros together to simulate passing a parameter to the included header file.

---

#Unary + operator

Everyone knows that the + operator is used to sum two values.
However, it can also be used as a unary operator.

	!cpp
	int x = +1234;
	printf("%d",+x);

Alone, it's somewhat useless, but it has some interesting side effects.

---

#Unary + on enums

When used on an enum, unary + is the same as a cast to int.

	!cpp
	enum X {
		a,b,c
	};
	
	X val = a;
	printf("%d",+val); // +val is an int

---

#Unary + to create const ref

Sometimes, a function requires a const reference, but you want to pass it something else.
When this happens, you can use + to create a "temporary reference" to a value.

	!cpp
	struct Foo {
	  static int const value = 42;
	};

	// This does something interesting...
	template<typename T>
	void f(T const&);

	int main() {
	  // fails to link - tries to get the address of "Foo::value"!
	  f(Foo::value);

	  // works - pass a temporary value
	  f(+Foo::value);
	}

.notes: Taken from [Johannes Schaub](http://stackoverflow.com/questions/75538/hidden-features-of-c)

---

#Unary + to convert arrays to pointers

On occasion, you'll need to send a pointer to a function. Typically, your options are:

	!cpp
	&arr[0];
	(int*)arr[0];

However, using unary + you can convert any array into a pointer while remaining easy-to-read.

	!cpp
	// This does something interesting...
	template<typename T>
	void f(T const& a, T const& b);

	int main() {
	  int a[2];
	  int b[3];
	  f(a, b); // won't work! different values for "T"!
	  f(+a, +b); // works! T is "int*" both times
	}

.notes: Taken from [Johannes Schaub](http://stackoverflow.com/questions/75538/hidden-features-of-c)

---

#Switch Statements

How do switch statements work?

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

#Switch Statements (Fallthrough)

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
        float y = 1.66;
        printf("float: %f\n",y);
    default:
        // do nothing
        break;
    }

---

#Switch Statements (Blocks)

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
		float y = 1.66;
		printf("float: %f\n",y);
	}
	default: {
		// do nothing
		break;
	}
	}

---

#Switch Interlacing

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

#Switch Interlacing Example

This trick can be extended to work with if(){}else{}:

	!cpp
    switch(mode) {
	case PARSE_MODE_COMMAND:
	    // We have a null command!
	    fprintf(stderr, "Illegal null command\n");
	    return NULL;
	    break;
	case PARSE_MODE_PIPE:
	case PARSE_MODE_ARGUMENT:
	    if(allowLT) {
	        // Set the mode
	        mode = PARSE_MODE_INREDIR;
	        allowLT = false;
	    } else {
	default:
	        // It's a illegal redirect
	        if(currentArg + 1 < argCount) {
	            fprintf(stderr, "%s: Illegal input redirect\n",
	                argList[currentArg + 1]);
	        } else {
	            fprintf(stderr, "Illegal input redirect\n");
	        }
	        return NULL;
	    }
	    break;
	}

.notes: Credit to Ben Russel <benrr101> for this snippet

---

#Duff's Device

This trick was used with a for loop for this lovely, famous (but slightly modified) bit of code:

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

#Loop classes

Everyone knows how to create a variable inside of a for loop:

    !cpp
    for(int i=0;...;...) {
        ...
    }

Because of how structures are declared, it's also possible to create one in the same place.  
This can be used to create several variables with different types,
which is otherwise impossible while keeping their scope limited to the for loop.

    !cpp
    for(struct { int a; float b; } loop = { 1, 2.0 }; ...; ...) {
        ...
    }


