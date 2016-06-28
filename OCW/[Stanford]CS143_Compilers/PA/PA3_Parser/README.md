# PA02 Parsing

## Summary

1. Learn how to use `bison/CUP` to construct AST. For example, `3 + + x` is illegal in C.
2. Report error information when error occurs.

## Related Files

- **grading**: After judging, the folder will be created. The folder contains 70 test cases.
- **pa2-grading.pl**: The grading shell script.
- **cool.y**: What we need to code.
- **cool-tree.aps**: The functions to make tokens to a phylum.
- **Makefile**: Use `$ make parser` to compile.

## Instructions

1. Create the directory you want to do hw, ex: `~/cool/my_assign_sol/PA3`
2. Copy source into the working directory.
  - C++: `PA3 $ make -f /usr/class/cs143/assignments/PA3/Makefile`
  - Java: `PA3 $ make -f /usr/class/cs143/assignments/PA3J/Makefile`
3. Comment out the line 29 in the file **parser-phase.cc**.
  - Line 29: ` //int curr_lineno;               // needed for lexical analyzer`
4. Compile: `$ make parser`
5. Start to code.

## Sample I/O

<details>
<summary>Input: [grading/assignment.test](grading/assignment.test)</summary>

```
class Test {
  foo:Int;
  bar():Object{foo <- 3 };
};
```

</details>

<details>
<summary>Output: [grading/assignment.test.out](grading/assignment.test.out)</summary>

```
#4
_program
  #4
  _class
    Test
    Object
    "assignment.test"
    (
    #2
    _attr
      foo
      Int
      #2
      _no_expr
      : _no_type
    #3
    _method
      bar
      Object
      #3
      _assign
        foo
        #3
        _int
          3
        : _no_type
      : _no_type
    )
```

</details>

## Commands

- **Compile**: `$ make parser`
- **Execute**: `$ ./myparser good.cl`
  - **myparser** will run **lexer** and **parser** together.
  - `$ ./parser good.cl` will do nothing.
  - You can replace the **tutor's lexer** with **your lexer**.
  - `$ make clean` will delete the lexer.
- **Judge**
  1. Download the script: `$ wget http://spark-university.s3.amazonaws.com/stanford-compilers/scripts/pa2-grading.pl`
  2. Grading: `$ perl pa2-grading.pl`

## References

- [Assignment 2 Spec](https://s3-us-west-1.amazonaws.com/prod-edx/Compilers/ProgrammingAssignments/PA2.pdf)
- [The Cool Reference Manual](https://lagunita.stanford.edu/c4x/Engineering/Compilers/asset/cool_manual.pdf), Sec. 11 "Cool Syntax"
- [A Tour of the Cool Support Code](https://lagunita.stanford.edu/c4x/Engineering/Compilers/asset/cool-tour.pdf), Sec. 6 "Abstract Syntax Trees"
- [GNU Bison - The Yacc-compatible Parser Generator](https://www.gnu.org/software/bison/manual/html_node/index.html), Sec. 5 "The Bison Parser Algorithm" and Sec. 6 "Error Recovery".

## Tips

- **To answer to ambiguous cases, you can read the test cases carefully.**
- Don't use **Right Recursive Rules** in bison. [This post](https://lagunita.stanford.edu/courses/Engineering/Compilers/Fall2014/discussion/forum/i4x-Engineering-Compilers-Assignments-Fall2014/threads/546c9ab657f960acde001038) save me lots of time. 
  > If you doing the assignment just after week 3 lectures, you might be tempted to refactor left recursion into right recursive rules. On the contrary, bison prefers left recursive rules.
- Don't forget to implement cool manual sec. 11.1.
