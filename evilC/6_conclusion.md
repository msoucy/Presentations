#Eldritch Abomination

---

#Disclaimer

This last trick is NOT for the faint of heart.
If you are squeamish or think that you may be unable to handle this monstrosity, please stop reading.

It abuses some rules in the C++ syntax that should probably never be abused

---

#Void Type Expressions

A void function is normally assumed to not return anything.
In fact, you can leave the return out of the end of a void function.

However, technically a return expression can contain any expression that evaluates to a value of a type that can be coerced into the return type of the function.

	!cpp
	void f() { }
	void g() { return f(); }
	void h(void(*k)()) {
		return k();
	}

	int main() {
		h(g);
		return 0;
	}

---

#Void Type Expression Details

Some common void-type expressions:

 - Functions returning void
 - Throw statements (Yes, the statement is an expression, it just returns void)

Other places a void-type expression can be used:

 - As either result of a ternary expression
 - Returning from a templated function, that returns the template type, that gets passed a void as the template

---

# Conclusion

I actually can't produce a piece of code that encorporates MOST of these tricks, let alone ALL.
Such code should probably never exist.

Reminder: Most of these should only be used if there is literally no other way to do what you want to do.
They give you more control over your code, at the expense of readability and maintainability.

Always remember that it's always a good idea to "Code for the Maintainer":

> Always code as if the person who ends up maintaining your code is a violent psychopath who knows where you live.

>> *I usually maintain my own code, so the as-if is true*

---

#return 0;
