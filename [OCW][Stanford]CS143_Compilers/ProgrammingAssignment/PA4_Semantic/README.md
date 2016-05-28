# Programming Assignment 03 Semantics

## Related Files
- **grading**: After judging, the folder will be created. The folder contains 74 test cases.
- **pa3-grading.pl**: The grading shell script.
- **cool-tree.h**: Definition of every structure in AST.
- **dumptypes.cc**: Sample to demo how to traverse the entire AST.
- **symtable_example.cc**: An utility to enter scope / add k-v pair / exit scope. Or you can use std::map.
- **semant.h/cc**: Where you put the code.
- **Makefile**: Use `$ make semant` to compile.

## Get Started from [Instructions](https://lagunita.stanford.edu/courses/Engineering/Compilers/Fall2014/courseware/ea6a541a18c3461d9b840ade44fa44d8/51a2f7b24fd74ee8b149a7046f64ef85/)
1. Create the directory you want to do hw, ex: `~/cool/my_assign_sol/PA4`
2. Copy source into the working directory.
  - C++: `$ make -f /usr/class/cs143/assignments/PA4/Makefile`
  - Java: `$ make -f /usr/class/cs143/assignments/PA4J/Makefile`
4. Compile: `$ make semant`
5. Start to code.

## Sample I/O

### Sample Input from `grading/letself.test`

```cool
-- CoolAid 7.2
class Main {
main () :Int {let self:Int in 0};
};
```

### Sample Output from `grading/letself.test.out`

```cool
letself.test:3: 'self' cannot be bound in a 'let' expression.
Compilation halted due to static semantic errors.
```

## Instruction

- **Compile**: `$ make semant`
- **Execute**: `$ ./mysemant good.cl`
  - **myparser** will run **lexer**, **parser**, and **semant** together.
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

## Hints

- **To answer to ambiguous cases, you can read the test cases carefully.**
- The tutor's modules may cause your semant to output the wrong line number.