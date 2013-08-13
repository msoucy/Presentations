# Uniform Function Call Syntax

There are often instances when one is using a library that for some reason they cannot alter,
but you want to add functionality to a certain class or type.

	!d
	// D allows this through the use of UFCS, which converts any call to:
	x.foo()
	// Into the actual call:
	foo(x);
	// This is used often in `std.algorithm`, which allows one to write code such as:
	writeln(take(generator(5),10));
	// As the much more legible (and easily maintainable):
	generator(5).take(10).writeln();

---

# Voldemort Types

Andrei discovered an interesting interaction between `auto` and declaring structs inside a function:
**Voldemort types** are types that cannot be named.

	!d
	import std.stdio;
	import std.range;

	auto generator(uint seed) { 
	  struct RandomNumberGenerator {
		  @property int front() {
		      return ((seed / 0x10000) * seed) >> 16;
		  }
		  void popFront() {
		      seed = seed * 1103515245 + 12345;
		  }
		  enum empty = false;
	  }
	 
	  RandomNumberGenerator g;
	  g.popFront();    // get it going
	  return g;
	}

	void main() {
	  generator(5).take(10).writeln();
	}

---

# Mixins

	!d
	// Taken from my ZeroMQ wrapper
	mixin template SocketOption(TYPE, string NAME, int VALUE) {
		/// Setter
		@property void SocketOption(TYPE value) {
			if(zmq_setsockopt(this.socket, VALUE, &value, TYPE.sizeof)) {
				throw new ZMQError();
			}
		}
		/// Getter
		@property TYPE SocketOption() {
			TYPE ret;
			size_t size = TYPE.sizeof;
			if(zmq_getsockopt(this.socket, VALUE, &ret, &size)) {
				throw new ZMQError();
			} else {
				return ret;
			}
		}
		mixin("alias SocketOption "~NAME~";");
	}
	mixin SocketOption!(ulong, "hwm", ZMQ_HWM);

---

# C Bindings

In addition to Phobos, D also has the external library Deimos.

Deimos is a set of D bindings to various C libraries, such as:

- ncurses
- 0MQ (zeroMQ)

Much like Phobos, Deimos is supported by the open source community, and is constantly updating.

**This means you can link (almost) any C library to D, and it will work normally.**

	!d
	extern(C) int someCrazyCFunction();
	
	void main() {
		return someCrazyCFunction();
	}

