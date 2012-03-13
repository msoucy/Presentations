#include <cstdio>

int main() {
	int x;
	scanf("%d",&x);
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
	return 0;
}
