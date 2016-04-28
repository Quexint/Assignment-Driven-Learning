# Notes for Stanford CS143 Compilers

## Week 01: Introduction & the Cool Programming Language

**How to Run the Program**

- Compiler (Offline)
  - $Program \rightarrow Compiler \rightarrow Execute$
  - $Execute + Data \rightarrow Output$
- Interpreters (Online)
  - $Program + Data \rightarrow Interpreter \rightarrow Output$

**Compiler Concept**

- (Syntactic) **Lexical Analysis**
  - Concept: Divide program text into words or tokens.
  - Input: text
  - Output: words or tokens
  - Sample Input: `if x == y then z = 1; else z = 2;`
  - Sample Output: `#IF #ID(x) #EQAUL #ID(y) #THEN ...`
- (Syntactic) **Parsing**
  - Concept: Diagramming Sentences.
  - Input: Tokens
  - Output: Abstruct Semantic Tree
  - Sample Input: #INT(5) #PLUS #INT(3) #MULTIPLY #INT(5)
  - Sample Output: `(#PLUS (#INT(5))  (#MULTIPLY (#INT(3))  (#INT(5))))`
- (Types scope) **Semantic Analysis**
  - Concept: Catch inconsistencies.
  - Sample Input: `{ int Jack=3; { int Jack=4; cout << Jack; } }`
  - Question: What is the value?
- **Optimization**
  - Concept: Run faster/Use less memory/Use low power/network.
- (Translation) **Code Generation**
  - Concept: Produce assembly code.

**Related Questions**

- Why are there so many programming languages?
  - Application domains have distinct/conflicting needs.
- Why are there new programming languages?
  - Programming training is the dominant cost for a programming language.
  - Wild-used languages are **slow to change**.
  - Easy to start a new language: when **productivity** > **training cost**
  - Languages adopted to fill a void. (**Void** means new techniques.)
- What is a good programming languages?
  - There is **no** universally accepted metric for language design.


## Week 02: Lexical Analysis & Finite Automata

### 03 Lexical Analysis

**Token Class (or Class)**

Classify **program substrings** according to **role** (token class), **class** corresponding to **sets of strings**:

- **Identifier** : string of letters or digits, starting with a letter
- **Integer**: a non-empty string of digits
- **Keyword**: else, if, begin, ...
- **Whitespace**: a non-empty sequence of blanks, newlines, tabs

**Goal of Lexical Analysis**

- Definition
	- **lexeme**: A lexeme is a sequence of characters that matches the pattern for a token.
	- **token**: A token is a pair consisting of the token name and the value.
- Concept
	- Parttition the input string into lexemes.
	- Identity the token of each lexeme.
	- Communicate tokens to the parser.
- Input: Program Substrings
- Output: Tokens
- Sample Input: `string (foo=42)`
- Sample Output: `<class, "string">, <'('>, <ID, "foo">, <Operator, "=">, <"Int", "42>, <')'>`
- Remark
	- **Left-to-Right** scan => **lookahead** required.

#### Regular Languages

Regular Expression:

- Concept: Regular expressions (syntax) specify regular languages (set of strings).
- 2 base cases
  - Single Character: $'c' = \{ "c" \}$
  - Empty String: $\epsilon = \{ "" \}$
- 3 compound expressions
  - Union: $A + B = \{a\ |\ a \in A\} \cup \{ b\ |\ b \in B \}$
  - Concatenation: $AB = \{ab\ |\ a \in A \wedge b \in B \}$
  - Iteration: $
A^* = \bigcup_{i \geq 0} A^i,
\begin{cases}
A^i = A...A \\
A^0 = \epsilon
\end{cases}
$

**Def.** The **regular expression** over $\Sigma$ are the smallest set of expressions including:
$$
\begin{align}
  R &= \epsilon \\
    &|\ 'c', c\in\Sigma\\
    &|\ R+R\\
    &|\ RR\\
    &|\ R^*
\end{align}
$$

#### Formal Languages

**Def.** Let $\Sigma$ be a set of characters (an alphabet).
A **language** over $\Sigma$ is a set of strings of characters drawn from $\Sigma$.
Meaning function $L$ maps **regular expressions** to **set of strings**.

$$
\begin{align}
L(\epsilon) &= \{ "" \} \\
L('c') &= \{ "c" \} \\
L(A+B) &= L(A) \cup L(B) \\
L(AB) &= \{ab\ |\ a \in L(A) \wedge b \in L(B)\} \\
L(A^*) &= \bigcup_{i \geq 0} L(A)^i \\
\end{align}
$$

**Q**:Why use a meaning function?

- Make clear what is syntax, what is semantics.
- Allow us to consider notation as a seperate issue.
- Because exp and meanings are not 1-1.
  - Meaning is many to one.

### 04 Lexical Specifications

**Lexemes**

- **Keyword**: "if" / "else" / "then" / ...
  - $ 'if' + 'else' + 'then' + ...$
- **Integer**: a non-empty string of digits
  - $digits: '0' + '1' + '2' + ...$
  - $(digit)(digit)^* = digit^+$
- **Identifier**: strings of letters or digits, starting with a letter
  - $letter = 'a' + 'b' + 'c' + ... = [a-zA-Z]$
  - $(letter)(digit+letter)^*$
- **Whitespace**: a non-empty sequence of blanks, newlines, and tabs
  - $('\;' + '\setminus n' + '\setminus t')^+$

**More regular expressions**

- At least one: $A^+ = AA^*$
- Union: $A|B = A+B$
- Option: $A? = A+\epsilon$
- Range: $'a'+'b'+\dots+'z' = [a-z]$
- Excluded Range: $\widehat{[a-z]} = [\wedge a-z]$

**How do we check $program \in L(R)$**?

1. Write a regular expression for the lexemes of each token class
	- Number $= digit^+$
	- Keyword $= 'if'+'else'+\dots$
	- Identifiew $= letter(letter+digit)^*$
	- OpenPar $='('$
	- ...
2. Construct $R$ to match all lexemes.
	- $R = Number + Keyword + Number + ... = R_1 + R_2 + ...$
3. Let input be $x_1...x_n$. Find the longest length $i$ such that $x_1...x_i \in L(R)$.
4. Remove $x_1...x_i$. Go to step 3.
5. If $x_1...x_i \in L(R_a) \cap L(R_b)$, apply $R_{\min(a,b)}$.

## Week 03: Parsing & Top-Down Parsing

## Week 04: Bottom-Up Parsing I & II

#### First Set

**Def**. (First Set)

$$First(X)=\{t\ |\ X\rightarrow^*t\alpha\}\cup\{\epsilon\ |\ X\rightarrow^*\epsilon\}$$

**Algo**

1. $First(X)=\{t\}, if\ t\ is\ a\ terminal.$
2. $\epsilon \in First(X), if
\begin{cases}
X\rightarrow \epsilon \\
X\rightarrow A_1A_2\dots A_n, and\ \epsilon \in First(A_i), \forall 1\leq i\leq n
\end{cases}$
3. $First(\alpha) \subseteq First(X), if\ X\rightarrow A_1A_2\dots A_n\alpha, and\ \epsilon \in First(A_i), \forall 1\leq i\leq n$

#### Follow Set

**Def**. (Follow Set)

$$Follow(X)=\{t\ |\ S\rightarrow^*\beta Xt\delta\}$$

**Algo**

1. $\$ \in Follow(S)$
2. $First(\beta)-\{\epsilon\}\subseteq Follow(X), for\ each\ A\rightarrow\alpha X\beta$
3. $Follow(A) \subseteq Follow(X), for\ each A\rightarrow\alpha X\beta\ where\ \epsilon\in First(\beta)$


## Week 05: Semantic Analysis and Type Checking

## Week 06: Cool Type Checking & Runtime Organization

## Week 07: Code Generation & Operational Semantics

## Week 08: Local Optimization & Global Optimization

## Week 09: Register Allocation & Garbage Collection

## Week 10: Java
