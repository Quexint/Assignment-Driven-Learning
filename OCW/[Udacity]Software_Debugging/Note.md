# Software Debugging Notes

## Lesson 1: How Debuggers work
- **What's in  this Course**
  - Explore the **basics of debugging**
  - Build a **simple debugger** in Python
- **The Devil's Guide To Debugging**
  - Scatter output statements everywhere
  - Proceed systematically
  - Never back up earlier versions
  - Understand what the program should do
  - Fix the problem, not the symptom
- **Before applying a fix, one should...**
  - Understand what the problem is
  - Understand what the code should do
  - Be able to predict how the fix would address the problem
- **How Failure come to be**
  - Error: not correct, not right, or not ture
  - A **failure** is an error in the execution.
  - A **defect(bug)** is an error in the code.
  - An **infection** is an error in the state.
  - Debugging: identify+break cause-affect chain
- **The Scientific Method**
  1. Initial Observation
  2. Hypothesis
  3. Prediction
  4. Experiment
  5. Observation -> Yes: support and refine hypothesis -> Theory
  6. Observation -> No: reject and create new hypothesis
- **Use the Scientific Method to find the Bug**
  - As Failure (run more to get) as Initial Observation
  - As Diagnosis as Theory
- **After the Fix**
  - Check whether the same error has been made elsewhere.
  - Ensure that that error does not occur again.
    - Tests
    - Assertions

## Lesson 2: Asserting Expectations
- **Asserting Expectations**
  - Assetions = the most powerful debugging tool => automating debugging
  - Assertions
    - **write** assertions
    - **check** assertions
    - **infer** assertions from executions
- **Built-in Assertions**
  - Identification
  - Location
  - Optional
  - Standardized
- **Preconditions and Postconditions**
  - Assertions **in a test** - check **a single run**
  - Assertions **in the code** - check **all run**
  - Ex: `def squeare_root(x): assert x>=0; - assert y*y==0;`
- **Assetions Forever**
  - for **catching errors**
  - for **testing**
  - for **documentation**
- **Refining Assertions**
  - Control whether pre/post-condition is permissive or strict.
  - Postcondition is hard to control.
    - Ex: Postcondition of `sort(x)`: `assert is_sort(y) and is_permutation(y, x)` 
- **Data Invariants**
  - Assertions can check
    - several execution of a function
    - **large portions of data**
- **Large-Scale Assetion Checking**
  - **invariant** = condition that always holds for a data object
  - *always* means at the **begining** and **end** of each public method
  - create the **checkRep** function
  - most useful for **large, complex** data structures
- **Assertions are optional**
  - Assertions **take time!** => Assertions **can be turned off**
    - Python: The `-O` option turns assertions **off**.
    - C/C++: `-DNDEBUG` => assertions **off**
    - Java: `-ea` => assertions **on**
  - Assertions **can be turned off** => **assertions must not change the program semantics**
- **Public Preconditions**
  - Assertions should **not** check for public preconditions
    ```python
    # Bad sample, because you will forgot it when disable assertions
    deposit = int(input)
    assert deposit >= 0
    ```
    ```python
    # Good sample
    deposit = int(input)
    if deposit < 0:
      raise IllegalDataExcption
    ```
- **Should assertions remain enabled in production code?**
  - Pro
    - Failing is better than bad data
    - Eases debugging
    - Defects in the field are hard to track
  - Con
    - Performance
    - Not user friendly
- **System Invariants**
  - Sometimes, you need to ensure that
    - **a properly holds throughout the entire execution**
      ```python
      # It will trace every line.
      import sys
      sys.settrace(traceit)
      def traceit(frame, ev, args):
        global flag
        assert flag
        return traceit
      ```
- **Buffer Overflows**
  - C/C++: [Electric Fence](http://elinux.org/Electric_Fence), [Valgrind](http://valgrind.org)
- **Getting Started with Assertions**
  - Define **data invariants**
  - Provide **preconditions**
  - Provoid **postconditions**
  - Run a system invariant checker, ex: valgrind
- **Inferring Invariants**
  - A tool automatically provides **data invariants**, **preconditions**, and **postconditions**
  - **DAIKON**: Dynamically detect invariants

## Lesson 3: Simplifying Failures
- **Simplifying Failures**
  - How to simplity failures
  - How to do this antomatically
- **The Tao of Simplifying**
  - > "The goal of simplifying the test case is to make it so simple that changing any aspect of it changes the behavior of the error." - Steve McConne, Code Complete
  - > "Everything should be made as simple as possible, but no simpler." - Albert Einstein
  - A Simple Process for Simplifying
    - For every **circumstance** of the problem, check whether it is **relevant** for the problem to occur.
    - If not, remove it.
- **Automated Simplification**
  - We need a **stralegy**, ex: Binary Search
    - Throw away **half the input** and see if the output is still wrong.
    - If not, **go back to the previous state** and discard **the other half** of the input.
- **Delta Debugging**
  1. Split input into **n** subsets (initially, `n=2`)
  2. If removing any of these subsets fails, proceed with this subset, and `n=max(n-1,2)`
  3. Otherwise, increase granularity: `n = min(2n, input)`
- **Simplifying Fuzz Inputs**
  - **Fuzz testing**: random inputs for a program or API
  - Fuzz Tester -> Program -> Delta Debugging -> Minimal Failing Input
- **Causes and Causality**
  - Delta Debugging returns a **failure cause**
  - When we fix a defect, we want to make sure that
    - it is an error -> **show how to correct it**
    - it causes the failure -> **show that the failure no longer occurs after the correction**
  - Causes and Errors
    - **Errors that are not causes**
    - **Causes that are not errors**
  - An **actual cause** assumes and changes as little as possible, yet changes the effect.
- **Leveraging Input Structure**
  - Delta Debugging: **dumb** (economical in its assumptions)
- **Tracking Origins**
  - How errors propagate in a program
  - How we can trace back these dependencies

## Lesson 4: Tracking Origins
- **[Pex For Fun](http://www.pexforfun.com/)**
- **Dependency**
  - **Data Dependency**: If a statement A writes a variables which then B reads, then B is **data dependent** on A.
  - **Control Dependency**: If a statement A controls whether B is executed or not, then B is **control dependent** on A.
  - **Backward Slice**: A **backward slice** of S contains all statements that S would (transtively) depend upon.
  - **Forward Slice**: A **forward slice** of S contains all statements that (transitively) depend on S.
  - **Dynamic Slices**
    - apply to **executions** instead of programs
    - tells what **has happened** in an execution
    - Dynamic slices form **small subset** of programs
      - only **executed** lines
      - only statement that **influence** the output
- **Dependencies and the Scientific Method**
  - Use dependencies to find **possible origins**
  - Use **scientific method** to trace down infections
  - ...or use **deduction** to rule out possibilities
- **Focus on Likely Origins**
  - What possible origin should I look first?
    1. Infections: If some origin is wrong, go for it.
    2. Causes: If some state causes the failure, use delta debugging to find it.
    3. Code Smells: If you suspect some code is wrong or got warning from checker, go for it.
    4. Bug History: If some code got a lot of problem reports lately.
    5. Last Changes: Code that has changed recently is way more likely to have errors.
    6. Anomalies: If some code shows abnormal behavior before reaching the failure, produce the log to find.
- **Isolate Cause-Effect Chains Automatically**
  - If we can change a variable s.t. the failure no longer occurs, we have a **failure cause**.
  - For this, we can use values from a **successful fun**.

  
## Lesson 5: Reproducing Failures
- **The Art of Reproduction**
  - We need to **observe** the run
  - We need to **check the fix**
- **Bug Catefories**
  - Bohr Bug
    - Repeatable
    - manifests reliably under a set of conditions
  - Heisenbug
    - Disappears or changes when one attempt to probe or isolate it
  - Mandelbug
    - Appears chaotic or even now non-determinisitc
  - Schrodinbug
    - does not manifest until someone realizes it nerver should have worked
- **Example 1**
  - Code
    ```C
    void bug(){
      int x;
      assert x == 0;
    }
    ```
  - Result
    - run normally: **crashed**
    - run in a debugger: **all fine**
  - Heisenbug
- **The many Facets of Input**
  - We need to reproduce
    - Interaction between program and environment by function calls: operating Environment, static data, user interaction
      - Operating Environment
      - Static Data
        - Types: Files, Tables (Database)
        - Contains Documents and Configuration Files
        - Issue: Removing Confidential Information
        - Solution: Keep data secret (NDA), Produce anonymized data
      - User Interaction
        - Use capture replay tool
        - All input from the user: mouse click, keystrokes, and similar events
        - GUI
          - Record mouse clicks as coordinate
          - Records all changes in size, in spped, in language, in the program
          - Or record it as element (button, textview, ...)
          - Risk
            - They may capture **sensitive information**, which should not go to developers
            - Recording scripts **may not be replayable** in different environment (locale, resolution, font size, speed, ...)
            - Recording scripts **may be prone to change** as the software or the GUI changes
    - Non-deterministic behavior: Physical Influences, Schedules, Time, Randomness, Debugging Tools
    - Make it deterministic and controllable
      - Time
        - For diagonstic purposes: provide a means to set these
        - Or use real timing
      - Randomness
        - If you use a pseudorandom generator, be sure to save its seed.
        - If you use a true random generator, save the sequence of random numbers
      - Schedules
        - find means to make these thread switches deterministic
        - Otherwise, you may run into heard-to-reproduce thread scheduling issues
      - Physical Influences: Most are electric problems, not software problem
      - Debugging Tools: they will influence the real timing. They may induce Heisenbugs.
- **Capturing Coverage**
  - Example: Write a line coverage
- **Phi Coefficient**
  - Binary Correlation
    - Phi correlation coefficient - for **binary** dependency

      
|         |FAIL Run|PASS Run|Total   |
|---------|--------|--------|--------|
|Covered  |$N_{11}$|$N_{10}$|$N_{1R}$|
|Uncovered|$N_{01}$|$N_{00}$|$N_{0R}$|
|Total    |$N_{C1}$|$N_{C0}$|$N$     |


    - Phi Coefficient: $\frac{(N_11*N_00 - N_10*N_01)}{ / sqrt(N_1R*N_0R*N_C0*N_C2)}
    - High (Postive Value): Diagonal(`N_11 to N_00`) is High
    - Low (Negative Value): Diagonal(`N_10 to N_01`) is High
  - Plan
    1. Compute Phi Coefficient for each line
    2. Rank lines from high value to low value

## Lesson 6: Learning from Mistakes

- **The Managemnet Side of Bugs**
  - How to track bugs
  - How to organize the debugging process
  - How to make sure bugs don't appear
  - How to find out where and why bugs occur
- **What goes in a Bug Reports**
  - Facts about the problem
    - The problem history (steps needs to reproduce the problem) (most crucial)
    - Diagnostic information (core dumps, stack traces, logs)
    - The experience behavior (what user saw)
    - The expected behavior (as a reality check)
    - A one-line summary
- **Bug Databases**: save to a problem database
- **Bug Report Fields**
  - Severity: the impact of the problem on the user (Blocker/Critical/Major/Minor/Enhancement)
  - Priority: how soon the problem will be addressed
  - Bug ID: a unique identifier
  - Comments: added by developers
  - Notification: the stakeholders
- **Managing Problems**
  - Use a **software change control board** (SCCB) to set the priority
- **The Problem Life Cycle**
  - Unconfirmed -> New
  - Unconfirmed - invalid/duplicate -> Resolved
  - New -> Assigned
  - Assigned - Duplicate/Fixed/Invalid/WontFix/WorksForMe -> Resolved
  - Resolved - (if fixed) -> Verified
  - Resolved - ? -> Reopened
  - Verified -> Closed
  - Closed - ? -> Reopened
  - Reopened - ? -> Assigned
- **Housekeeping**
  - Issues in problem databases
    - Duplicates
    - Obsolete Problems
      - will never be fixed
      - old and occured only once
      - old and occured only interally
      - => WONTFIX resolution
    - Subsuming Test Cases
      - make problem report obsolete
- **Defect Maps**
  - Link problem database and version database, you can find the bug-related information in the source code.
  - Where do Bugs Come From?
    - If lots of bugs in one place, it will be more
    - heavily tested code, more buggy
    - complexity doesn't matter
    - team structure matter
    - defect maps is the problem domain
  - Factor
    - Developer: Get assigned to the tasks. Hard tasks make more bugs. 
    - Past Bugs: Hard tasks make more past bugs.
    - Tests: Hard tasks make more testing.
    - Complexity
    - Team
    - Domain: the domain changes frequently/is complex/not well-defined?
  - Look at Data: At first, make a defect map and find the hot spot.

## Summary
- **The Seven Steps of Debugging**
  - Track the problem (Life Cycle)
  - Reproduce it
  - Automate + Simplify (Regression Testing, Delta Debugging)
  - Find possible infection origins (Dependency)
  - Focus on most likely origins (Known Infections/Causes/Anomalies/Code Smells)
  - Isolate the infection chain (scientific method)
  - Correct the defect
- **What you can DO**
  - Get your **requirements** right (spec.)
  - Increase **precision** and **automation** (Don't waste human resourse)
  - Reduce **complexit** 
  - Set up **assertions**
  - Test **early**, test **often**
  - **Review** your code
  - Analyze **problem history** (hot spot)
  - **Learn** from your mistakes