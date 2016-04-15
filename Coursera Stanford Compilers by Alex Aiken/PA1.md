## Introduction

To make a Cool compiler, try to complete the scanner part at first. The other parts are completed by the instructor. It means we only need to transform the scanning rules to regular expressions based on lex. 

## Important Files
- **grading**: The folder contains 63 test cases.
- **pa1-grading.pl**: The grading shell script.
- **cool.flex**: What we need to code.
- **cool-parse.h**: The definition of token types to return.
- **stringtab.h**: Where to save the token's value.
- **Makefile**: Use `make lexer` to compile.

Use `find ~ -name "cool-parse.h"` to find the file **cool-parse.h**.

## Get Started from [Instructions](https://class.coursera.org/compilers-004/assignment/view?assignment_id=2)
1. [Install the VM](https://class.coursera.org/compilers-004/wiki/view?page=GettingstartedwiththeVMsEC2andVirtualBox) (ID:**compilers**, PW:**cool**)
2. Assignment number begins from `2`, ex: assignment I is `PA2`.
3. Create the directory you want to do hw, ex: `~/cool/my_assign_sol/PA2`
4. Copy source into the working directory. (Sec. 3 in Assignment PDF) 
  - C++: `make -f /usr/class/cs143/assignments/PA2/Makefile`
  - Java: `make -f /usr/class/cs143/assignments/PA2J/Makefile`
5. Read the References.
6. Start to code `cool.flex`.

## How to Judge
1. Download the grading script: `wget http://spark-university.s3.amazonaws.com/stanford-compilers/scripts/pa1-grading.pl`
2. Setting the Permission: `chmod a+x pa1-grading.pl`
3. Submit: `perl pa1-grading.pl`

## References
- Assignment 1 PDF
- The Cool Reference Manual, Sec. 10 and Figure 1
- A Tour of the Cool Support Code, Sec. 3 "String Tables"
- [Lex - A Lexical Analyzer Generator](http://dinosaur.compilertools.net/lex/index.html)

## Tips

- How do I ssh into my VM?
  1. Set the network setting of VM to use NAT.
  2. Close the VM.
  3. In the host OS, create the port forwording rule in the Terminal.
    - `$ VBoxManage modifyvm myserver --natpf1 "ssh,tcp,,3022,,22"`
  4. Ensure the Rule is created.
    - `$ VBoxManage showvminfo myserver | grep 'Rule'`
  5. Start the VM
  6. Install Openssh-Server: `sudo apt-get install openssh-server`
  7. ssh into the VM: `ssh -p 3022 compilers@127.0.0.1`
