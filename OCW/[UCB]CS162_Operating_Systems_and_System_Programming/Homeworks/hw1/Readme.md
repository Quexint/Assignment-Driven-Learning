# HW01 Shell

## Summary

- Support the command **fg**, **bg**, **cd**, **&**(background processing)
- Use **file descriptor** and **pipe()** to do I/O redirection of jobs.
- Use **signal()** and **fork()** to do job control (foreground/background processing)

## Spec.

1. Support for `cd` and `pwd`
2. Execute programs: `./a.out`
3. Support Path: `vim`
4. Input/Output Redirection: `./a.out < input > output`
5. Single Handling and Terminal Control`<CTRL-C>`, `<CTRL-Z>`
6. Background Processing: `./a.out &`
7. Foreground/Background Switching
	- `fg`: List all jobs.
	- `fg [pid]` or `fg %[i-th]`: Put the job into foreground and continue.
	- `bg [pid]` or `bg %[i-th]`: Contnue the job.

## Commands

- **Environment**: [Vagrantfile](../Vagrantfile)
- **Compile**: `$ make`
- **Execute**: `$ ./shell`

## References

- GNU C Library Reference Manual 28 Job Control
- GNU C Library Reference Manual 17 Low-Level Terminal Interface
- GNU C Library Reference Manual 24.2.5 Job Control Signals
- [A Brief Introduction to Termios](https://blog.nelhage.com/2009/12/a-brief-introduction-to-termios/)