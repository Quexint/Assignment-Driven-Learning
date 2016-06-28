# PA03 Semantics

## Summary

1. Learn how to do type decoration (static type checking). For example, `void ptr; ptr+3;` is illegal in C.
2. Learn how to check **everything**.
	1. Varible Scopes
	2. Circular Type Inheritance
	3. Inherited Attribute Overriding
	4. Redefined or Undefined Attribute
	5. Method Parameter
	6. `SELF` and `SELF_TYPE`
3. Report error information when error occurs.

This assignment is so **heavy**. It took me 2 ~ 3 weeks. Try to make a **symbol table** and **inheritance graph** at first.

## Related Files

- **grading**: After judging, the folder will be created. The folder contains 74 test cases.
- **pa3-grading.pl**: The grading shell script.
- **cool-tree.h**: Definition of every structure in AST.
- **dumptypes.cc**: Sample to demo how to traverse the entire AST.
- **symtable_example.cc**: An utility to enter scope / add k-v pair / exit scope. Or you can use std::map.
- **semant.h/cc**: Where you put the code.
- **Makefile**: Use `$ make semant` to compile.

## Instructions

1. Create the directory you want to do hw, ex: `~/cool/my_assign_sol/PA4`
2. Copy source into the working directory.
  - C++: `PA4 $ make -f /usr/class/cs143/assignments/PA4/Makefile`
  - Java: `PA4 $ make -f /usr/class/cs143/assignments/PA4J/Makefile`
4. Compile: `$ make semant`
5. Start to code.

## Sample I/O

<details>
<summary>Input: [grading/badarith.test](grading/badarith.test)</summary>

```
class Main { main() : Int {0 }; };
class A {
	inky():Object { 1 + "hello" };
};
```

</details>

<details>
<summary>Output: [grading/badarith.test.out](grading/badarith.test.out)</summary>

```
badarith.test:4: non-Int arguments: Int + String
Compilation halted due to static semantic errors.
```

</details>

## Commands

- **Compile**: `$ make semant`
- **Execute**: `$ ./mysemant good.cl`
  - **mysemant** will run **lexer**, **parser**, and **semant** together.
  - `$ ./semant good.cl` will do nothing.
  - You can replace the **tutor's modules** with **your modules**.
  - `$ make clean` will delete the lexer.
- **Judge**
  1. Download the script: `$ wget http://spark-university.s3.amazonaws.com/stanford-compilers/scripts/pa3-grading.pl`
  2. Grading: `$ perl pa3-grading.pl`

## References

- [Assignment 3 Spec](https://s3-us-west-1.amazonaws.com/prod-edx/Compilers/ProgrammingAssignments/PA3.pdf)
- [The Cool Reference Manual](https://lagunita.stanford.edu/c4x/Engineering/Compilers/asset/cool_manual.pdf), Sec. 12 **Type Rules**
- [A Tour of the Cool Support Code](https://lagunita.stanford.edu/c4x/Engineering/Compilers/asset/cool-tour.pdf) Sec. 6.4 **Class Members**

## Tips

- **To answer to ambiguous cases, you can read the test cases carefully.**
- The tutor's modules may cause your semant to output the wrong line number.