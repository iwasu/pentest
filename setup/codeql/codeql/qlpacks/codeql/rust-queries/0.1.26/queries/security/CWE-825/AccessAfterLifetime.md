# Access of a pointer after its lifetime has ended
Dereferencing a pointer after the lifetime of its target has ended causes undefined behavior. Memory may be corrupted, causing the program to crash or behave incorrectly, in some cases exposing the program to potential attacks.


## Recommendation
When dereferencing a pointer in `unsafe` code, take care that the pointer is still valid at the time it is dereferenced. Code may need to be rearranged or changed to extend lifetimes. If possible, rewrite the code using safe Rust types to avoid this kind of problem altogether.


## Example
In the following example, `val` is local to `get_pointer` so its lifetime ends when that function returns. However, a pointer to `val` is returned and dereferenced after that lifetime has ended, causing undefined behavior:


```rust

fn get_pointer() -> *const i64 {
	let val = 123;

	&val
} // lifetime of `val` ends here, the pointer becomes dangling

fn example() {
	let ptr = get_pointer();
	let dereferenced_ptr;

	// ...

	unsafe {
		dereferenced_ptr = *ptr; // BAD: dereferences `ptr` after the lifetime of `val` has ended
	}

	// ...
}

```
One way to fix this is to change the return type of the function from a pointer to a `Box`, which ensures that the value it points to remains on the heap for the lifetime of the `Box` itself. Note that there is no longer a need for an `unsafe` block as the code no longer handles pointers directly:


```rust

fn get_box() -> Box<i64> {
	let val = 123;

	Box::new(val) // copies `val` onto the heap, where it remains for the lifetime of the `Box`.
}

fn example() {
	let ptr = get_box();
	let dereferenced_ptr;

	// ...

	dereferenced_ptr = *ptr; // GOOD

	// ...
}

```

## References
* Rust Documentation: [Behavior considered undefined &gt;&gt; Dangling pointers](https://doc.rust-lang.org/reference/behavior-considered-undefined.html#dangling-pointers).
* Rust Documentation: [Module ptr - Safety](https://doc.rust-lang.org/std/ptr/index.html#safety).
* Massachusetts Institute of Technology: [Unsafe Rust - Dereferencing a Raw Pointer](https://web.mit.edu/rust-lang_v1.25/arch/amd64_ubuntu1404/share/doc/rust/html/book/second-edition/ch19-01-unsafe-rust.html#dereferencing-a-raw-pointer).
* Common Weakness Enumeration: [CWE-825](https://cwe.mitre.org/data/definitions/825.html).
