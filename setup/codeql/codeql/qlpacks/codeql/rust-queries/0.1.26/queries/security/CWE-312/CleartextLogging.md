# Cleartext logging of sensitive information
Sensitive user data and system information that is logged could be exposed to an attacker when it is displayed. Also, external processes often store the standard output and standard error streams of an application, which will include logged sensitive information.


## Recommendation
Do not log sensitive data. If it is necessary to log sensitive data, encrypt it before logging.


## Example
The following example code logs user credentials (in this case, their password) in plaintext:


```rust
let password = "P@ssw0rd";
info!("User password changed to {password}");

```
Instead, you should encrypt the credentials, or better still, omit them entirely:


```rust
let password = "P@ssw0rd";
info!("User password changed");

```

## References
* M. Dowd, J. McDonald and J. Schuhm, *The Art of Software Security Assessment*, 1st Edition, Chapter 2 - 'Common Vulnerabilities of Encryption', p. 43. Addison Wesley, 2006.
* M. Howard and D. LeBlanc, *Writing Secure Code*, 2nd Edition, Chapter 9 - 'Protecting Secret Data', p. 299. Microsoft, 2002.
* OWASP: [Logging Cheat Sheet - Data to exclude](https://cheatsheetseries.owasp.org/cheatsheets/Logging_Cheat_Sheet.html#data-to-exclude).
* Common Weakness Enumeration: [CWE-312](https://cwe.mitre.org/data/definitions/312.html).
* Common Weakness Enumeration: [CWE-359](https://cwe.mitre.org/data/definitions/359.html).
* Common Weakness Enumeration: [CWE-532](https://cwe.mitre.org/data/definitions/532.html).
