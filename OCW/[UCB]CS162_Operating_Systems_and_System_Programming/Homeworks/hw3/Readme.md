# HW03 Malloc

## Summary

- Use `sbrk()` to manage heap in virtual space of a process
- Use `linked-list` to manage the memory list
- Use Linux kernel marco such as `container_of(ptr, type, member)` 
- Support random testing  `mm_test` to verify the function.
- Support fragmentation merging when use the `free` function.

## Spec.

- This is a simple implementation of memroy management in C.
- `mm_malloc()`: `malloc()`
- `mm_realloc()`: `realloc()`
- `mm_free()`: `free()`

## Commands

- **Environment**: [Vagrantfile](../Vagrantfile)
- **Compile**: `$ make`
- **Test**: `$ ./mm_test`

## Future Works

- Support balanced binary search tree to improve the complexity?
- Support multithreading?
- Support lock-free?