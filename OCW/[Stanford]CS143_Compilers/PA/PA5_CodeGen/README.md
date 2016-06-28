# PA04 Code Generation

## Summary

1. Learn the MIPS format.
2. Learn how to do dynamic type checking.
3. Report error information when errors occurs.

This assignment is heavier than PA03. Because everything you write in PA03 will be used in PA04. It becomes more complicated. Try to make a stack machine to record/report the locations of all symbols. Don't save anything in the temporal registers. Push it into the stack and pop it out before exiting the scope.

## Related Files

- **grading**: After judging, the folder will be created. The folder contains 63 test cases.
- **pa4-grading.pl**: The grading shell script.
- **cool-tree.h**: Definition of every structure in AST.
- **cgen.h/cc**: Where you put the code.
- **Makefile**: Use `$ make cgen` to compile.
- **emit.h**: Marcos for emitting MIPS instructions.

## Instructions

1. Create the directory you want to do hw, ex: `~/cool/my_assign_sol/PA5`
2. Copy source into the working directory.
  - C++: `$ make -f /usr/class/cs143/assignments/PA5/Makefile`
  - Java: `$ make -f /usr/class/cs143/assignments/PA5J/Makefile`
4. Compile: `$ make semant`
5. Start to code.

## Sample I/O

<details>
<summary>Input: [grading/case-none.cl](grading/case-none.cl)</summary>

```
class Main inherits IO
{
  main() : Object
  {
    let thing : Object <- self in
      case thing of
	i : Int => out_string( "int\n" );
	b : Bool => out_string( "bool\n" );
      esac
  };
};
```

</details>

<details>
<summary>Output: [grading/case-none.cl.out](grading/case-none.cl.out)</summary>

```
SPIM Version 6.5 of January 4, 2003
Copyright 1990-2003 by James R. Larus (larus@cs.wisc.edu).
All Rights Reserved.
See the file README for a full copyright notice.
Loaded: /usr/class/cs143/cool/lib/trap.handler
No match in case statement for Class Main
```

</details>

## Commands

- **Compile**: `$ make cgen`
- **Execute**: `$ ./mycoolc good.cl`
  - **mycoolc** will run **lexer**, **parser**, **semant**, and **cgen** together.
  - `$ ./cgen good.cl` will do nothing.
  - You can replace the **tutor's modules** with **your modules**.
  - `$ make clean` will delete the lexer.
- **Judge**
  1. Download the script: `$ wget http://spark-university.s3.amazonaws.com/stanford-compilers/scripts/pa4-grading.pl`
  2. Grading: `$ perl pa4-grading.pl`

## References

- [Assignment 4 Spec](https://s3-us-west-1.amazonaws.com/prod-edx/Compilers/ProgrammingAssignments/PA4.pdf)
- [The Cool Reference Manual](https://lagunita.stanford.edu/c4x/Engineering/Compilers/asset/cool_manual.pdf), Sec. 13 **Operational Semantics**
- [A Tour of the Cool Support Code](https://lagunita.stanford.edu/c4x/Engineering/Compilers/asset/cool-tour.pdf) Sec. 7 **The Runtime System**
- [The Cool Runtime System](https://web.stanford.edu/class/cs143/materials/cool-runtime.pdf)
- [SPIM Manual](http://www.stanford.edu/class/archive/cs/cs143/cs143.1112/materials/other/SPIM_Manual.pdf)

## Tips

- **To answer to ambiguous cases, you can read the test cases carefully.**
- The tutor's modules may cause your semant to output the wrong line number.