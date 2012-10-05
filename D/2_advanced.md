# C Bindings

In addition to Phobos, D also has the external library Deimos.

Deimos is a set of D bindings to various C libraries, such as:

- ncurses
- 0MQ (zeroMQ)

Much like Phobos, Deimos is supported by the open source community, and is constantly updating.

**This means you can link any C library to D, and it will work fine!**

	!d
	extern(C) int someCrazyCFunction();
	
	void main() {
		return someCrazyCFunction();
	}

