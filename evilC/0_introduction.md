# Evil C++ 2
## Obfuscation Boogaloo
### C and C++ Standard tricks to bemuse and befuddle

- Presented and created by Matt Soucy
- Ranked from least to most evil, in the author's opinion
- Now with 200% more evil

---

#Prerequisites

Some of these tricks may require knowledge of the following:

 - Basic C syntax
    - Variable initialization and creation
    - Loops and control flow
    - Logical operators
    - Statements vs. Expressions
 - Familiarity with pointers and references
 - Basic bit manipulation (the &, |, ^, ~ operators)
 - Base-8 and Base-16

---

#Warnings

The tricks involved in this presentation may exploit definitions found in the standard,
or they may merely be things that aren't commonly known.
Either way, in 99.9999% of the cases where you wonder if you need to use them, you definitely don't.

> The people who actually need them know with certainty that they need them, and don't need an explaination about why

>> Python Guru Tim Peters

This presentation is designed to show the effects of:

 - Different language features interacting
 - The programmer having complete control over how an individual segment of memory is used
 - Manipulating the build system (such as the preprocessor)

It is NOT meant to demonstrate things that should be used for anything more than messing around and learning.
If you use these in production code, you will be ***REDACTED***.

