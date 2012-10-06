#C++ Evil

---

#C++11 Warning

All examples marked with C++11 are part of the C++11 standard ONLY.

This requires the compiler to support at least those features of the standard.

For gcc, the switch to enable this is:

    gcc -std=c++11 file.cpp

---

#Templates

Templates are a way to write code that can be adapted to work on any type, such as containers.
std::vector is a template, so `vector<T>` means roughly `vector of some type T`
The syntax for declaring a template is:

    !cpp
    template<typename T> struct MyType {
        T data;
        MyType(T data):data(data) {}
    };

In this case, `T` is used as a type determined at compile time:

    !cpp
    MyType<int> x = MyType(5); // "typename T" matches "int"

---

#Template turing-completeness

C++ templates are turing-complete:

	!cpp
	#include <cstdio>

	template<int N> void bin() {
		bin<(N>>1)>(); printf("%d",N%2);
	}
	template<> void bin<0>() {} // Base case

	int main() {
		bin<42>(); // Print the binary representation of 42
		printf("\n");
		return 0;
	}

---

#Templates on unions (C++11)

Templates can be done on the types in a union as well:

	!cpp
	template<typename From, typename To>
	union union_cast {
		From from;
		To   to;

		union_cast(From from)
		    :from(from) { }

		To getTo() const { return to; }
	};

.notes: Type punning didn't stop being undefined, by the way.

---

#Templates on bitfields

Templates can be used for integral values, not just types.
They must be calculatable in compile-time.
This means that a template value can be used in the place of any other compile-time value.

	!cpp
	#include <cstdio>
	
	template<int N> class BitField {
		unsigned x:N; // Generate a compiler error if N==0
	};
	
	int main() {
		Bitfield<2> x; // Booleans "graduate" to integers, so this is legal
		//Bitfield<(1>2)> y; // Creates a zero-width bitfield, so illegal
		return 0;
	}

---

#Lambdas (C++11)

Lambda functions are basically anonymous functions.
These can make some of the standard library's functions much more usable.

    !cpp
    vector<int> x = vector<int>(10); // Vector with 10 values
    generate(x.begin(),x.end(),[]() {
        return (rand() % 100); // Make a "random" value
    });
    printf("Number of odd values: ",count_if(x.begin(), x.end(), [](int i){
        return i%2;}));

However they can VERY easily confuse anyone who is unaware:

	!cpp
	#include <stdio.h>

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

#Range-based For Loops (C++11)

C++11 allows the use of foreach loops using a somewhat familiar syntax:

    !cpp
    vector<int> vec = ...; // Some values or whatever
    for(int i : vec) {
		cout << i << endl;
	}

The trick is that this can operate on C-style arrays, initializer lists, and types that have .begin() and .end() functions.

It's identical to writing:

    !cpp
    for(auto _iter = vec.begin(); _iter != vec.end(); _iter++) {
    	auto i = *_iter;
        cout << i << endl;
    }

---

#Exploiting ranges

This can be exploited to use foreach over things that aren't "real" collections.

    !cpp
    class Count {
        int val, step;
    public:
        class iterator {
            int val, step;
        public:
            iterator(int val, int step) : val(val), step(step) {}
            iterator operator++() {
                val+=step;
                return *this;
            }
            bool operator!=(const iterator& other) const {
                return (val+step > other.val);
            }
            int operator*() const { return val; }
        };
        Count(int v, int step=1) : val(v), step(step) {}
        iterator begin() { return iterator(val, step); }
        iterator end() { return iterator(val-1, step); }
    };
    
    for(int i : Count(5,3)) {
        cout << i << endl;
    }

