# Standard Library Ranges

Much like C++'s STL and iterators, Phobos is designed almost entirely around ranges.

Because of this, any user-made range is instantly supported by the entire standard library,
including a large number of algorithms for acting on those ranges (`std.algorithm`)

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

**This means you can link any C library to D, and it will work fine!**

	!d
	extern(C) int someCrazyCFunction();
	
	void main() {
		return someCrazyCFunction();
	}

