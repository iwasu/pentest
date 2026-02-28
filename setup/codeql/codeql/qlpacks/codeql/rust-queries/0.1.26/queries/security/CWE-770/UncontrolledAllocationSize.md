# Uncontrolled allocation size
Allocating memory with a size based on user input may allow arbitrary amounts of memory to be allocated, leading to a crash or a denial-of-service (DoS) attack.

If the user input is multiplied by a constant, such as the size of a type, the result may overflow. In a build with the `--release` flag, Rust performs two's complement wrapping, with the result that less memory than expected may be allocated. This can lead to buffer overflow incidents.


## Recommendation
Implement a guard to limit the amount of memory that is allocated, and reject the request if the guard is not met. Ensure that any multiplications in the calculation cannot overflow, either by guarding their inputs, or using a multiplication routine such as `checked_mul` that does not wrap around.


## Example
In the following example, an arbitrary amount of memory is allocated based on user input. In addition, due to the multiplication operation, the result may overflow if a very large value is provided. This may lead to less memory being allocated than expected by other parts of the program.


```rust

fn allocate_buffer(user_input: String) -> Result<*mut u8, Error> {
    let num_bytes = user_input.parse::<usize>()? * std::mem::size_of::<u64>();

    let layout = std::alloc::Layout::from_size_align(num_bytes, 1).unwrap();
    unsafe {
        let buffer = std::alloc::alloc(layout); // BAD: uncontrolled allocation size

        Ok(buffer)
    }
}

```
In the fixed example, the user input is checked against a maximum value. If the check fails, an error is returned, and both the multiplication and allocation do not take place.


```rust

const BUFFER_LIMIT: usize = 10 * 1024;

fn allocate_buffer(user_input: String) -> Result<*mut u8, Error> {
    let size = user_input.parse::<usize>()?;
    if size > BUFFER_LIMIT {
        return Err("Size exceeds limit".into());
    }
    let num_bytes = size * std::mem::size_of::<u64>();

    let layout = std::alloc::Layout::from_size_align(num_bytes, 1).unwrap();
    unsafe {
        let buffer = std::alloc::alloc(layout); // GOOD

        Ok(buffer)
    }
}

```

## References
* The Rust Programming Language: [Data Types - Integer Overflow](https://doc.rust-lang.org/book/ch03-02-data-types.html#integer-overflow).
* Common Weakness Enumeration: [CWE-770](https://cwe.mitre.org/data/definitions/770.html).
* Common Weakness Enumeration: [CWE-789](https://cwe.mitre.org/data/definitions/789.html).
