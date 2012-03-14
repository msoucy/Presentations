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
