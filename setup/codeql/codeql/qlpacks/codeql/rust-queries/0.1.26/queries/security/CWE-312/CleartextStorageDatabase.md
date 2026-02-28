# Cleartext storage of sensitive information in a database
Sensitive information that is stored unencrypted in a database is accessible to an attacker who gains access to that database. For example, the information could be accessed by any process or user in a rooted device, or exposed through another vulnerability.


## Recommendation
Either encrypt the entire database, or ensure that each piece of sensitive information is encrypted before being stored. In general, decrypt sensitive information only at the point where it is necessary for it to be used in cleartext. Avoid storing sensitive information at all if you do not need to keep it.


## Example
The following example stores sensitive information into a database without encryption, using the SQLx library:


```rust
let query = "INSERT INTO PAYMENTDETAILS(ID, CARDNUM) VALUES(?, ?)";
let result = sqlx::query(query)
	.bind(id)
	.bind(credit_card_number) // BAD: Cleartext storage of sensitive data in the database
	.execute(pool)
	.await?;

```
This is insecure because the sensitive data is stored in cleartext, making it accessible to anyone with access to the database.

To fix this, we can either encrypt the entire database or encrypt just the sensitive data before it is stored. Take care to select a secure modern encryption algorithm and put suitable key management practices into place. In the following example, we have encrypted the sensitive data using 256-bit AES before storing it in the database:


```rust
fn encrypt(text: String, encryption_key: &aes_gcm::Key<Aes256Gcm>) -> String {
    // encrypt text -> ciphertext
    let cipher = Aes256Gcm::new(&encryption_key);
    let nonce = Aes256Gcm::generate_nonce(&mut OsRng);
    let ciphertext = cipher.encrypt(&nonce, text.as_ref()).unwrap();

    // append (nonce, ciphertext)
    let mut combined = nonce.to_vec();
    combined.extend(ciphertext);

    // encode to base64 string
    BASE64_STANDARD.encode(combined)
}

fn decrypt(data: String, encryption_key: &aes_gcm::Key<Aes256Gcm>) -> String {
    let cipher = Aes256Gcm::new(&encryption_key);

    // decode base64 string
    let decoded = BASE64_STANDARD.decode(data).unwrap();

    // split into (nonce, ciphertext)
    let nonce_size = <Aes256Gcm as AeadCore>::NonceSize::to_usize();
    let (nonce, ciphertext) = decoded.split_at(nonce_size);

    // decrypt ciphertext -> plaintext
    let plaintext = cipher.decrypt(nonce.into(), ciphertext).unwrap();
    String::from_utf8(plaintext).unwrap()
}

...

let encryption_key = Aes256Gcm::generate_key(OsRng);

...

let query = "INSERT INTO PAYMENTDETAILS(ID, CARDNUM) VALUES(?, ?)";
let result = sqlx::query(query)
	.bind(id)
	.bind(encrypt(credit_card_number, &encryption_key)) // GOOD: Encrypted storage of sensitive data in the database
	.execute(pool)
	.await?;

```

## References
* OWASP Top 10:2021: [A02:2021 - Cryptographic Failures](https://owasp.org/Top10/A02_2021-Cryptographic_Failures/).
* OWASP: [Key Management Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Key_Management_Cheat_Sheet.html).
* Common Weakness Enumeration: [CWE-312](https://cwe.mitre.org/data/definitions/312.html).
