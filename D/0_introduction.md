# The D Programming Language

##A new take on C++

- Presented by Matthew Soucy
- msoucy@csh.rit.edu

---

# What is D?

## "Great, the last thing I need is another D in programming!" - Walter Bright

- Developed by:
    - Walter Bright (Digital Mars, first native C++ compiler)
    - Andrei Alexandrescu (_Modern C++ Design_, Facebook)
    - Many contributors (Phobos standard library)
- Designed to be "C++ Done Right"
- Compiles to native code
- Community driven, multi-paradigm, buzzword-filled (but in a good way!)

![D Logo](Dlogo.png)

---

# Six instantly-useful features

- Garbage collection, unless you want manual memory management, in which case you can use it or turn the GC off.
- Arrays know their length, and assigning to their length resizes them.
- Strings are treated as arrays of characters, and have access to all array properties.
- `const` types are actually const, and you can't circumvent the type system to change this.
- Compile time is insanely short. (Downside is there's less time for shenanigans)
- Object-oriented, but only when you want it - doesn't limit you to a specific paradigm.
    - For example, use a functional style by marking functions as `pure`
