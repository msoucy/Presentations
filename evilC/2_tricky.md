#Tricky

---

#sizeof
Most people have heard of the sizeof command, however, they are unaware that sizeof doesn't actually evaluate its contents.

The entire thing is performed at compile time, but not executed - it returns the size of the result of the expression, and compiles that in.

The original code doesn't actually make it to the executable.

	!cpp
	// Notice the lack of a body there
	template <typename T, int N> char ( &Array( T(&)[N] ) )[N];
	int x[5];
	printf("Length of an array: %d\n",sizeof(Array(x)));

---

#The comma operator

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

#Conditional Scope

Conditionals require *expressions*.
The difference between expressions and statements is that expressions have a value.
Variable declarations are expressions, not statements.

This means that this is possible, limiting the scope of the variable to the body of the if statement and its else clause(s)

    !cpp
    if(int ret = someFunction()) {
        // Use ret
    } else {
        // ret is 0
    }

---

#Bitfields

It's possible to compact a group of variables into the size of a single variable.
This is called bitfields.
Care must be taken to arrange bitfields to end on a WORD boundry.

	!cpp
	struct Bitfield {
		unsigned x:2; // 2 bits
		unsigned y:16; // 16 bits
		unsigned z:14; // 14 bits
	};

