# C++ Evil
---
#Templates

Templates can often come to be regarded as immensely evil due to their "interesting" syntax.


	!cpp
	#include <stdio.h>
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
		vector<vector<int> > x; // There has to be a space between the > > in C++98
		Foo<(2>1)> y; // Booleans "graduate" to integers, so this is legal
		//Foo<(1>2)> q; // Creates a zero-width bitfield, so illegal
		Bar<int> z; // Legal, "typename" matches "int"
		Bin<42>(); // Print the binary representation of 42
		return 0;
	}

---
#C++11 Lambdas

The latest revision of the C++ standard, C++11, added support for lambda functions.

These are awesome and make some of the standard library's functions actually usable.

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

