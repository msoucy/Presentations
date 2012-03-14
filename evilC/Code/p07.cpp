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

template<int N> struct ProgramWrapper {
	~ProgramWrapper() {
		getchar();
	}
} wrapper;

int main() {
	vector<vector<int> > x; // There has to be a space between the > >
	Foo<(2>1)> y; // Booleans "graduate" to integers, so this is legal
	//Foo<(1>2)> q; // Creates a zero-width bitfield, so illegal
	Bar<int> z; // Legal, "typename" matches "int"
	Bin<42>();
	return 0;
}
