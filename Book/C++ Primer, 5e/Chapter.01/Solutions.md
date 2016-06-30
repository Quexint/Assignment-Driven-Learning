## Chapter 1. Getting Started

### 1.1. Writing a Simple C++ Program

#### Exercise 1.1 ([ex.01.01.cpp](ex.01.01.cpp))

```bash
$ c++ -v
Apple LLVM version 7.3.0 (clang-703.0.31)
Target: x86_64-apple-darwin15.4.0
Thread model: posix
InstalledDir: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin
$ vim ex.01.01.cpp
$ c++ ex.01.01.cpp -o ex.01.01
$ ./ex.01.01
$
```

#### Exercise 1.2 ([ex.01.02.cpp](ex.01.02.cpp))

```bash
$ vim ex.01.02.cpp
$ c++ ex.01.02.cpp -o ex.01.02
$ ./ex.01.02
$ echo $?
255
$
```

### 1.2. A First Look at Input/Output

#### Exercise 1.3 ([ex.01.03.cpp](ex.01.03.cpp))

#### Exercise 1.4 ([ex.01.04.cpp](ex.01.04.cpp))

#### Exercise 1.5 ([ex.01.05.cpp](ex.01.05.cpp))

#### Exercise 1.6

It is not legal because there is no stream in the line 2, 3, and 4.

### 1.3. A Word about Comments

#### Exercise 1.7 ([ex.01.07.cpp](ex.01.07.cpp))

```bash
$ c++ ex.01.07.cpp -o ex.01.07
ex.01.07.cpp:2:18: warning: '/*' within block comment [-Wcomment]
 * comment pairs /* */ cannot nest.
                 ^
ex.01.07.cpp:2:24: error: unknown type name 'cannot'
 * comment pairs /* */ cannot nest.
                       ^
ex.01.07.cpp:2:35: error: expected ';' after top level declarator
 * comment pairs /* */ cannot nest.
                                  ^
                                  ;
1 warning and 2 errors generated.
```

#### Exercise 1.8 ([ex.01.08.cpp](ex.01.08.cpp))

```bash
$ c++ ex.01.08.cpp -o ex.01.08
ex.01.08.cpp:6:22: warning: missing terminating '"' character [-Winvalid-pp-token]
  std::cout << /* "*/" */;
                     ^
ex.01.08.cpp:6:22: error: expected expression
1 warning and 1 error generated.
```

### 1.4. Flow of Control

#### Exercise 1.9 ([ex.01.09.cpp](ex.01.09.cpp))

#### Exercise 1.10 ([ex.01.10.cpp](ex.01.10.cpp))

#### Exercise 1.11 ([ex.01.11.cpp](ex.01.11.cpp))

#### Exercise 1.12

It will count the values from -100 to 100. The value is 0.

#### Exercise 1.13 ([ex.01.13.cpp](ex.01.13.cpp))

#### Exercise 1.14

If I need to use a loop variable, I will use `for` to make the code clear.

#### Exercise 1.15 ([ex.01.15.cpp](ex.01.15.cpp))

```bash
ex.01.15.cpp:3:12: warning: extended initializer lists only available with -std=c++11 or -std=gnu++11
 int main ( {
            ^
ex.01.15.cpp:5:46: error: found ':' in nested-name-specifier, expected '::'
   std::cout << "Read each file." << std::endl:
                                              ^
ex.01.15.cpp:5:42: error: 'std::endl' is not a class or namespace
   std::cout << "Read each file." << std::endl:
                                          ^
ex.01.15.cpp:7:16: error: 'Update' was not declared in this scope
   std::cout << Update master. << std::endl;
                ^
ex.01.15.cpp:7:23: error: expected '}' before 'master'
   std::cout << Update master. << std::endl;
                       ^
ex.01.15.cpp:7:23: error: expected ')' before 'master'
ex.01.15.cpp:9:8: error: 'cout' in namespace 'std' does not name a type
   std::cout << "Write new master." std::endl;
        ^
ex.01.15.cpp:11:3: error: expected unqualified-id before 'return'
   return 0
   ^
ex.01.15.cpp:12:1: error: expected declaration before '}' token
 }
 ^
```

#### Exercise 1.16 ([ex.01.16.cpp](ex.01.16.cpp))

#### Exercise 1.17 ([ex.01.18.cpp](ex.01.18.cpp))

#### Exercise 1.18 ([ex.01.18.cpp](ex.01.18.cpp))

#### Exercise 1.19 ([ex.01.19.cpp](ex.01.19.cpp))

### 1.5. Introducing Classes

#### Exercise 1.20 ([ex.01.20.cpp](ex.01.20.cpp))

#### Exercise 1.21 ([ex.01.21.cpp](ex.01.21.cpp))

#### Exercise 1.22 ([ex.01.22.cpp](ex.01.22.cpp))

#### Exercise 1.23 ([ex.01.23.cpp](ex.01.23.cpp))

#### Exercise 1.24 ([ex.01.24.cpp](ex.01.24.cpp))

#### Exercise 1.25 ([ex.01.25.cpp](ex.01.25.cpp))
