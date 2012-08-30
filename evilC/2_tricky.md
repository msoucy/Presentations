# Tricky
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

