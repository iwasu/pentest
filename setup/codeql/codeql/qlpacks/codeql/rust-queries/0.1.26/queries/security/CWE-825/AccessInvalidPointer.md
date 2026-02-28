# Access of invalid pointer
Dereferencing an invalid or dangling pointer may cause undefined behavior. Memory may be corrupted causing the program to crash or behave incorrectly, in some cases exposing the program to potential attacks.


## Recommendation
When dereferencing a pointer in `unsafe` code, take care that the pointer is valid and points to the intended data. Code may need to be rearranged or additional checks added to ensure safety in all circumstances. If possible, rewrite the code using safe Rust types to avoid this kind of problem altogether.


## Example
In the following example, `std::ptr::drop_in_place` is used to execute the destructor of an object. However, a pointer to that object is dereferenced later in the program, causing undefined behavior:


```rust

unsafe {
    std::ptr::drop_in_place(ptr); // executes the destructor of `*ptr`
}

// ...

unsafe {
    do_something(&*ptr); // BAD: dereferences `ptr`
}

```
In this case, undefined behavior can be avoided by rearranging the code so that the dereferencing comes before the call to `std::ptr::drop_in_place`:


```rust

unsafe {
    do_something(&*ptr); // GOOD: dereferences `ptr` while it is still valid
}

// ...

{
    std::ptr::drop_in_place(ptr); // executes the destructor of `*ptr`
}

```

## References
* Rust Documentation: [Behavior considered undefined &gt;&gt; Dangling pointers](https://doc.rust-lang.org/reference/behavior-considered-undefined.html#dangling-pointers).
* Rust Documentation: [Module ptr - Safety](https://doc.rust-lang.org/std/ptr/index.html#safety).
* Massachusetts Institute of Technology: [Unsafe Rust - Dereferencing a Raw Pointer](https://web.mit.edu/rust-lang_v1.25/arch/amd64_ubuntu1404/share/doc/rust/html/book/second-edition/ch19-01-unsafe-rust.html#dereferencing-a-raw-pointer).
* Common Weakness Enumeration: [CWE-476](https://cwe.mitre.org/data/definitions/476.html).
* Common Weakness Enumeration: [CWE-825](https://cwe.mitre.org/data/definitions/825.html).
