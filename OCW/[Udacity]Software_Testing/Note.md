# Software Testing Note

## Lesson 1: Domains, Ranges, Oracles, and Kinds of Testing

### Testing Workflow
1. Got **AC**?
2. If not, then Check there exist bugs in **Software Under Test (S.U.T.)**?
3. If not, then Check there exist bugs in **acceptability testing**?
4. If not, then Check there exist bugs in **specification**?
5. If not, then Check there exist bugs in **OS, compiler, librariese, hardware**?


### Principles of Software Under Test (S.U.T.)
- clean code
- refactor
- should always be able to describe what a module does to how it interacts with other code
- no extra threads
- no swamp of global variables
- no pointer soup
- modules should have unit testing
- when applicable, support fault injection
- assertions, assertions, assertions

### Assertion

- **Concept**: Execute checks for a property that must be **true**.
  ```python
  def sqrt(arg):
    assert res >=0
  ```
- **Rule**
  1. Assertions are not for error handling
  2. NO SIDE EFFECTS
    ```python
    assert foo()==0
    //foo() changes a global variable
    ```
  3. No Silly Assertions
  ```python
  assert (1+1)==2
  ```
- **Why use assertion?**
  - make code self-checking, leading to more effective testing
  - make code fail early, closer to the bug
  - assign blame
  - document assumption, precondition, postcondition, invariants
- **Do we disable assertions in prduction mode?**
  - **Pro**
    - code runs faster
    - code keeps going
  - **Con**
    - what if our code relies on a side-effecting assertion
    - even in production mode, may be better to fail early


### Principles of Testing 

- **Use invalid domain to crash**: Interfaces that span trust boundaries are special must be tested on the full range of representable values.
- **Trust Relationships**: Never trust Input.
- **Fault Injection**: Rewrite a system-like call function `my_open()` s.t. succeed 100% then fail 1% of calls. It can be used to test the undefined havior.
- **Timing Dependent Problems**: Because data arriving may be slowly or quickly (quick click / long click, timeout, or some timing dependent API), it will do undefined behaviors.
- **Non-functional inputs**: you can't control the context switches.

### Kinds of Testing
- **Whitebox/Blackbox Testing**
- **Unit Testing**
- **Integration Testing**: after unit testing, test more module together
- **System Testing**: usually white box, and aim to focus on important cases (human behavior)
- **Diffenrential Testing**: same input, different function, compare the equality
- **Stress Testing**: test the huge case
  - **squre root** function: very big/small value
  - **system**: huge system calls, large mem allocation, creating huge file
- **Random Testing**

## Lesson 2: Code Coverage

> How much testing is enough? 
Need enough input to find **Race Condition** Range.

### Introduction

- **Concept**: Choose one representing input for every class. If we find some bug, we will blame the testcase of the class.
- **Function Coverage**: our testcases can cover how many function calls
- **Meaning**: a measure of the proportion of a program execused during testing
- **Pro**
  - give us an objective score
  - when coverage is < 100%, we are given meaningful tasks
- **Con**
  - not very helpful in finding errors of omission
  - difficult to interpret scores < 100%, because some program's need is 100%
  - 100% coverage does not mean all bugs were found
- **Example**: `coverge erase; coverage run splay_tree.py; coverage html -i`

### Coverage Metrics
> How many metrics are out there? a lot
  How many metrics do you need to care about? very few

- **Statement Coverage** (line): Cover how many lines
- **Branch Coverage** (decision): For every **branch** statement, cover how many branchs
- **Loop Coverage**: Cover each loop 3 possibility (0/1/2+), ex: n = 0/1/545
- **MC/DC Coverage** (modified condition/decision): Branch + **Min** condition situations take all outcome
  ```python
  def foo(x, y, z):
    if x or (y and z):
      return Ture
    return False
  foo(0, 0, 1) #False
  foo(0, 1, 0) #False
  foo(1, 0, 1) #Ture
  foo(0, 1, 1) #Ture
  ```
- **Path Coverage**: all possible paths (4 **if statements** will cause 16 paths)
- **Boundary Value Coverage**: Cover input boundary (boundary + (-1/0/1))

### Concurrent Software
- **What about concurrent software?** avoid race condition and deadlock
  - **synchronization coverage**: check during testing the lock actually does something
  - **interleaving coverage**: if you recall functions which accessed shared data are actually called and in a truly concurrent fashion that is by multiple threads at the same time
- **When coverage doesn't work?** not good at discovering areas of omission like missing error checks, try fault injection
- **What dows code that doesn't get covered mean?** For Infeasible Code: `#pragma: no cover`
- **Code Not Worth Covering**
  - Infeasible Code
  - Code not worth covering: res = formatDisk(); if res==ERROR: abort();
  - test suite inadequate 
- **Automated Whitebox Testing**: generate good test to do path coverage
  - conidtion -> constranints -> solver
  - http://klee.llvm.org
- **How to use coverage?**
  1. good testing -> measure coverage <-> high coverage: use feedback to improve tests
  2. good testing -> measure coverage -> poor coverage: re-think tests
- **Good tests** will lead to **good coverage**. But **good coverage** may not be **good tests**.

## Lesson 3: Random Testing
- **Driver Script Workflow**
  - Seed -> PRNG(pseudorandom number generator) + Domain Knowledge -> Random Test Case Generator -> S.U.Tl -> Oracle
    1. Output ok -> Back to Random Test Case Generator
    2. Output not ok -> Save Test Case -> Later inspection -> Back to Random Test Case Generation
  - Remember the Seed -> Know What Test Case Got Crashed
- **Example** of Testing compilers: [**Csmith**](https://embed.cs.utah.edu/csmith/)
- **Input Validity**: Random Generator may not pass Input Validity
- **Mandatory Input Validity**
  - Normal Situation: Mapping Invalid Input -> Input Rejected Region
  - But ingnoring invalid input handling -> misbehavior, crashes (what we want)
  - Recall Csmith, never write a compelete input valid checker
- **Random Testing gets NO Respect**
- **Penetration Testing**: Find the vulnerable spot
- **Random Testing of APIs**: Need to check the dependency
  - Workflow: Test Driver <-> API <-> S.U.T.
  - if failed, need to save/load test case to do **regression testing** and **test case reduction**
- **Way to Generate Random Inputs**
  - Generative Random Testing -> inputs are created from scratch
  - Mutation-based random testing -> inputs are created by randomly modifying existing non-randomly created inputs
- **Mutation Besed Random Testing**: Generating Mutators (How should we mutate test cases?)
  - flip bits
  - modify selected fields
  - add/remove/replace tokens, sub-trees of the AST (Abstruct Syntax Tree)
- **Oracles for Random Testing**: If the oracle isn't automated, you don't have an oracle.
  - Weak Oracles
    - Crash
    - Violation of a language rule
    - Rule Violation of an enhanced execution environment
  - Medium Oracle
    - Assertions
  - Strong Oracles
    - Alternate Implementation  
      - self-checker function
      - differential testing of compilers
      - old version of S.U.T.
      - reference implementation (use other programming language to implement)
    - Function Inverse Pair
      - assembler/disassembler
      - encryption/decrypt
      - compression/decompression
      - save/load
      - transmit/receive
      - encoding/decoding
    - Null Space Transformation 

## Lesson 4: Advanced Random Testing

### Oracles (Lesson 3)
### Random Testing in the Bigger Picture
- **Why does random testing work?**
  - beased on **weak bug hypothese**
  - people tend to make the same mistakes while coding and testing
  - huge asymmetry between speed of computers & people
- **Why is random testing so effective on (some) commercial software?**
  - because the developers aren't doing it (enough)
  - I'd argue: Software development efforts not taking proper advantage of random testing are flawed.
- **Random System Testers**
  - statr testing from a simple version of system with not very much functions by using a weak fuzzer
  - more and more strong

### Tuning Rules & Probabilities
- **Workflow**
  - Start Simple
  - -> Examine test cases, Think Hard, Look at Coverage Results
  - -> Adjust Rules, Tweak Probabilities, Add Functionality
  - -> Back to Step 2 (Examine test cases, Think Hard, Look at Coverage Results)
- **Example** of File System Testing
  - special-case mount/unmount
  - keep track of open files
  - limit size of files
  - limit directory depth
- **Fuzzing Implicit Inputs**
  - perturbing the scheduler
    - generate load
    - network activity
    - thread stress testing tools
  - inserting delays near synchronization / accesses to shared variables
  - "unfriendly emulators" (special VM to testing)
- **Can random testing inspire confidence?**
  - Confidence
    - Well-understood API 
    - Small Code
    - Strong Assertions
    - Mature, tuned random tester
    - Good Coverage Results
  - We never **just** random test;
- **Tradeoffs in spending time on random testing**
  - **Disadvantages**
    - input validity can be hard
    - oracles are hard too
    - no stopping criterion
    - may find unimportant bugs
    - may spend all testing time on boring tests
    - may find same bugs many times
    - can be hard to debug when test case is large and/or makes no sense
    - every fuzzer finds different bugs
  - **Advantages**
    - less tester bias, weaker hypotheses about where bugs are
    - once testing is automated, human cost of testing goes to nearly zero
    - often surprises us
    - every fuzzer finds different bugs
    - fun

## Lesson 5: Consequences
- **Overwhelmed by success?**
  - Start Tester
  - Go Home
  - Too Many Bugs!!!!
  - Next
    1. Report One Bug
    2. Bug Triage
- **Bug Triage** (Avoid the Same Bug)
  1. -> Disambiguate based on Assertion Violation Messages
    - 1 defect -> Many Symptoms
    - (Normal Case) Many Defects -> 1 symptom
    - (We Want) 1 defect -> 1 Symptom (Report All in Parallel)
  2. -> core dump or stack trace 
  3. Search over Version History, ex: git-bisect
  4. Examine Bug-triggering Test Cases -> Test Case Reduction
- **Test case Reduction**
  1. Manual Reduction (DIY)
  2. Delta Debugging (Work for any text file input!!)
- **Reporting Bugs** (to open source projects)
  - to avoid reporting duplicate bug
  - respect the conventions
  - include a small, stand-alone test case
  - only report valid test cases
  - expected/actual output
  - instruction for reproduction
    - platform details
    - version of S.U.T.
- **Building a Test Suite**
  - a **test suite** is a collection of tests
    - often can be run automatically
    - run periodically
      - nightly
      - on every commit
  - goal is to show that S.U.T. has some desired properties
  - what goes into the suite?
    - small, feature-specific tests
    - large, realistic inputs
    - regression tests -> any input that caused some previous version to fail
  - usually **not** a random tester
- **Hard Testing Problems**
  - What can make testing really hard?
    - lack of a specification
    - no comparable implementation
    - big SUT
    - large, highly structured input space
    - non-determinism
    - lots of hidden state
  - examples
    - large molecular simulation
    - autopilot
    - JVM running on 32 cores for a month, using 40GB of heap
  - What to do?
    - weak oracless
    - try to make do with small, hand-checked test inputs
    - rely on code inspections, formal methods, and other non-testing methods
- **Summary of Testing Principles**
  - testers must want software to fail
  - testers are detectives: they must be obscruant for suspicious behavior and anomalies in the SUT
  - all available test oracles should be used in testing
  - test cases should contain values selected from th entire input domain
  - interfaces that cross a trust boundary need to be tested with representable values, not just those from the ostensible - input domain
  - a little brute force goes a long ways
    - sometimes, selected interfaces can be exhaustively tested
    - almost everything else can be randomly tested
  - quality cannot be tested into bad software; in contrast, testable software has...
    - no hidden coupling, side channels
    - few variables exposed to concurrent access
    - few globals shared between modules
    - no pointer soup
  - code should be self checking, whenever possible, using lots of assertions; however:
    - these assertion are not used for error-checking
    - assertions must never be side effecting
    - assertions should never be trivial, or silly
  - when appropriate, all three kinds of input should be used as a basis for testing
    - APIs that are provided by the S.U.T. can be tested directly
    - APIs used by the S.U.T. can be tested using fault injection
    - non-functional inputs
  - failed coverage items do not provide a mandate to cover the failed items, but rather give clues to ways in which the tests are inadequate

## Appendix
- [Charlie Miller - **Babysitting on Army of Monkeys** - Part #1](https://www.youtube.com/watch?v=Xnwodi2CBws)
- [Charlie Miller - **Babysitting on Army of Monkeys** - Part #2](https://www.youtube.com/watch?v=lK5fgCvS2N4)