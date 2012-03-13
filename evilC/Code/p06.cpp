#include <cstdio>

int main() {
	int x;
	printf("==> ");
	scanf("%d",&x);
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
	return 0;
}
