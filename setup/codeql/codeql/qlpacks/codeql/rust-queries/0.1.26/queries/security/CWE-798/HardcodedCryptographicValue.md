# Hard-coded cryptographic value
Hard-coded passwords, keys, initialization vectors, and salts should not be used for cryptographic operations.

* Attackers can easily recover hard-coded values if they have access to the source code or compiled executable.
* Some hard-coded values are easily guessable.
* Use of hard-coded values may leave cryptographic operations vulnerable to dictionary attacks, rainbow tables, and other forms of cryptanalysis.

## Recommendation
Use randomly generated key material, initialization vectors, and salts. Use strong passwords that are not hard-coded.


## Example
The following example shows instantiating a cipher with hard-coded key material, making the encrypted data vulnerable to recovery.


```rust
let key: [u8;32] = [0;32]; // BAD: Using hard-coded keys for encryption
let cipher = Aes256Gcm::new(&key.into());

```
In the fixed code below, the key material is randomly generated and not hard-coded, which protects the encrypted data against recovery. A real application would also need a strategy for secure key management after the key has been generated.


```rust
let key = Aes256Gcm::generate_key(aes_gcm::aead::OsRng); // GOOD: Using randomly generated keys for encryption
let cipher = Aes256Gcm::new(&key);

```

## References
* OWASP: [Use of hard-coded password](https://www.owasp.org/index.php/Use_of_hard-coded_password).
* OWASP: [Key Management Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Key_Management_Cheat_Sheet.html).
* O'Reilly: [Using Salts, Nonces, and Initialization Vectors](https://www.oreilly.com/library/view/secure-programming-cookbook/0596003943/ch04s09.html).
* Common Weakness Enumeration: [CWE-259](https://cwe.mitre.org/data/definitions/259.html).
* Common Weakness Enumeration: [CWE-321](https://cwe.mitre.org/data/definitions/321.html).
* Common Weakness Enumeration: [CWE-798](https://cwe.mitre.org/data/definitions/798.html).
* Common Weakness Enumeration: [CWE-1204](https://cwe.mitre.org/data/definitions/1204.html).
