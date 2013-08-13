# D derives much of its syntax from C

	!d
	import std.stdio;
	
	// If main is void, it's the same as if it returns 0
	void main() {
		// The developers understand the awesomeness of printf
		writef("Hello, world!\n");
	}

---

# The "auto" keyword

Because expressions, especially those returned from some functions, can have long or complex names,
the `auto` keyword can be used to create variables where the exact type isn't needed or important.

	!d
	import std.algorithm;
	import std.stdio;
	
	void main() {
		auto x = "Hello, world!"; // string
		auto data = [1,2,3,4,5]; // int[]
		auto somefunc = (int x) {return x*x;}; // int function(int)
		// UHHHHH...don't worry about it! (It's int[])
		auto y = data.map!somefunc().filter!q{a % 2}().array();
		writef("%s", y); // %s prints this nicely!
	}

---

# Variable declaration syntax

C is infamous for having an unintuitive syntax for complex function declaration.

	!c
	// C style:
	int *x, *y;
		// * is required for both
	int* x, y;
		// x is an int*, y is an int
	int *p;
		// p is a pointer to an int
	int *p[13];
		// p is an array[13] of pointers to an int
	int *(p[13]);
		// p is an array[13] of pointers to an int
	int **p;
		// p is a pointer to a pointer to an int
	int (*p)[13];
		// p is a pointer to an array[13] of int
	int *f();
		// f is a function returning pointer to int
	int (*f)();
		// f is a pointer to a function returning int
	int (*(*f())[13])();
		// f is a function returning a ptr to an array[13]
		// of pointers to functions to int
	int (*(*x[3])())[5];
		// x is an array[3] of pointers to functions
		// returning pointers to array[5] to int

.notes: Examples from K&R Sec 5.12

---

# Variable declaration syntax (D style)

Isn't it nicer to just do it the D way?

	!d
	// D style:
	int* x, y;
		// D forbids declaring variables of different types in the same expression
	int *x;
	int y;
		// x is an int*, y is an int
	int* p;
		// p is a pointer to an int
	int*[13] p;
		// p is an array[13] of pointers to an int
	int **p;
		// p is a pointer to a pointer to an int
	int[13]* p;
		// p is a pointer to an array[13] of int
	int* function() f;
		// f is a function returning pointer to int
	int function() f;
		// f is a pointer to a function returning int
	int function()[13]* function() f;
		// f is a function returning a ptr to an array[13]
		// of pointers to functions to int
	int[5]* function()[3] x;
		// x is an array[3] of pointers to functions
		// returning pointers to array[5] to int

.notes: Examples from K&R Sec 5.12

---

# Properties

Properties are an extension of accessors, where a "variable" lookup is converted to a function call.

	!d
	@property string twice(string x) {
		return x~x;
	}

	void main() {
		"Hello".twice.writeln();
	}

---

# Smart arrays

Arrays in D can behave more like C++'s std::vector

- Automatic bounds checking (optional)
- Resizable
- Length+data

C-style arrays are also supported:

	!d
	int* p; // Same as in C
	int[5] x; // Same as C's "int x[5];"
	int[] y; // Smart array
	
	y.length = 2; // Resizes
	writef("Length: %s", y.length); // Gets value - property

---

# Built-in associative arrays

D has a built-in associative array type as part of the syntax:

	!d
	import std.stdio;
	
	void main() {
		string[string] x;
		x["what"] = "Hello";
		x["who"] = "world";
		x["emotion"] = "!";
		writefln("%s %s%s",x["what"],x["who"],x["emotion"]);
	}

---

# Foreach loops

Foreach loops in D are kind of awesome:

	!d
	import std.stdio;
	
	void main() {
		int[] arr = [1,3,5,7,9];
		foreach(x;arr) {
			writef("%s ",x); // %s automagically deduces the type
		}
		writef("\n");
		foreach_reverse(x;arr) {
			writef("%s ",x);
		}
		writef("\n");
		foreach(ref x;arr) {
			x *= x; // Poor man's map()
		}
		foreach(x;arr) {
			writef("%s ",x);
		}
	}

Output:

	1 3 5 7 9 
	9 7 5 3 1 
	1 9 25 49 81

---

# Scripting in D

D is designed so that you can even use it in scripts "without compiling"!

Example script:

	!d
	#!/usr/bin/dmd -run
	// If you have multiple files, you can use /usr/bin/rdmd
	import std.stdio;
	import std.string;
	import std.random;

	void main(){
		// Simple raffle name reorderer
		char[] data;
		writeln("Enter names:");
		string[] names;
		do {
			write("==> ");
			stdin.readln(data);
			data = data.strip();
			if(data != "") names ~= data.idup;
		} while(data != "");
		writeln("--- OUTPUT ---");
		uint i=0;
		foreach(name;names.randomCover(Random(unpredictableSeed))) {
			writef("%s: `%s`\n", i, name);
			i++;
		}
	}

---

# Switch statements

D continues C's style of a switch statement, but with a few tricks:

	!d
	string s;
	// ... Do stuff, assign s
	// switch now works directly on strings!
	switch(s) {
	case "A":
		// Do stuff
		break;
	case "B","C","E":
		// Do stuff if it matches any of those
		break;
	default:
		// Same old, same old
	}
	switch(s[0]) {
	case 'a' : .. case 'z': // Matches anything between a-z
	}


---

# Templates

Templates, combined with compile-time duck typing, allow for some powerful and simple type manipulation.

Their syntax is significantly cleaner than in C++,
due to using a single binary operator ! instead of overloading <>:

	!d
	template Foo(T, U) {
		class Bar { ... }
		T foo(T t, U u) { ... }
		T abc;
		typedef T* Footype; // any declarations can be templated
	}

	class Baz(T) {
		T t;
	}

	Foo!(int,char).Bar b;
	Foo!(int,char).foo(1,2);
	Foo!(int,char).abc = 3;
	Baz!int baz; // If there's only one argument it doesn't need parenthesis

---

# Eponymous Templates

When you make an eponymous template, the template takes the value of a static variable with the same name inside it.

	!d
	template factorial(int n) {
		static if (n == 1) const factorial = 1;
		else const factorial = n * factorial!(n-1);
	}

	int x = factorial!5; // Same as "int x = 120;"

---

# CTFE

The factorial example is simple, but in a lot of cases you'd prefer to be able to do a calculation both at compile and run time.
For this reason, D allows compile-time function execution.
Any variable what is created with `enum` or `static` is determined at compile-time.

	!d
	int factorial(int n) {
		if (n == 1) return 1;
		else return n * factorial(n - 1);
	}

	int x = factorial(5); // x is initialized to 120 at runtime
	static int x = factorial(5); // x is statically initialized to 120

---

# Iterators

D's standard library uses the concept of `Range`s instead of `Iterator`s like C++.

Iterators have some conceptual issues:

- There is no single, simple definition of what an iterator is
- Tied to pointer syntax
- Essential primitives:
    - At the end
    - Access value
    - Move (increment)
- Come in pairs (mostly)

---

# <s>Iterators</s> Ranges

A range is a single interface that allows for an alternative method of iteration.

	!d
	// Taken verbatim from std.range
	template isInputRange(R)
	{
	    enum bool isInputRange = is(typeof(
	    (inout int _dummy=0)
	    {
	        R r = void;       // can define a range object
	        if (r.empty) {}   // can test for empty
	        r.popFront();     // can invoke popFront()
	        auto h = r.front; // can get the front of the range
	    }));
	}

# Presenter Notes

Ranges in their simplest form share some similarities with Java - at least the foreach loop syntax.

---

# Ranges

More importantly, it simplifies iterating over things that may not be a "real" range.

	!d
	// Reverses iteration over a bidirectional range
	struct Reversed
	{
	    int[] range;

	    this(int[] range) { this.range = range; }

	    @property bool empty() const { return range.empty; }

	    @property int front() const { return range.back; } // ← reverse

	    @property int back() const { return range.front; } // ← reverse

	    void popFront() { range.popBack(); } // ← reverse

	    void popBack() {range.popFront(); } // ← reverse
	}

---

# Standard Library

The standard library (Phobos) takes a "batteries included" approach like python

Phobos contains many different modules, such as:

- `std.regex` or `std.conv` to handle string processing and conversion
- `std.csv`, `std.json`, `std.xml`, and `std.zip` to handle many different file formats
- `std.concurrency` and `std.process` for processes and tasks
- `std.socket` for network sockets

Much like C++'s STL and iterators, Phobos is designed almost entirely around ranges.

Because of this, any user-made range is instantly supported by the entire standard library,
including a large number of algorithms for acting on those ranges (`std.algorithm`)