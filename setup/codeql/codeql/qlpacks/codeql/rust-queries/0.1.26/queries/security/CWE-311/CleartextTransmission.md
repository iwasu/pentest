# Cleartext transmission of sensitive information
Sensitive information that is transmitted without encryption may be accessible to an attacker.


## Recommendation
Ensure that sensitive information is always encrypted before being transmitted over the network. In general, decrypt sensitive information only at the point where it is necessary for it to be used in cleartext. Avoid transmitting sensitive information when it is not necessary to.


## Example
The following example shows three cases of transmitting information. In the 'BAD' case, the transmitted data is sensitive (a credit card number) and is included as cleartext in the URL. URLs are often logged or otherwise visible in cleartext, and should not contain sensitive information.

In the 'GOOD' cases, the data is either not sensitive, or is protected with encryption. When encryption is used, ensure that you select a secure modern encryption algorithm, and put suitable key management practices into place.


```rust
func getData() {
	// ...

	// GOOD: not sensitive information
	let body = reqwest::get("https://example.com/song/{faveSong}").await?.text().await?;

	// BAD: sensitive information sent in cleartext in the URL
	let body = reqwest::get(format!("https://example.com/card/{creditCardNo}")).await?.text().await?;

	// GOOD: encrypted sensitive information sent in the URL
	let encryptedPassword = encrypt(password, encryptionKey);
	let body = reqwest::get(format!("https://example.com/card/{creditCardNo}")).await?.text().await?;

	// ...
}

```

## References
* OWASP Top 10:2021: [A02:2021 - Cryptographic Failures](https://owasp.org/Top10/A02_2021-Cryptographic_Failures/).
* OWASP: [Key Management Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Key_Management_Cheat_Sheet.html).
* Common Weakness Enumeration: [CWE-319](https://cwe.mitre.org/data/definitions/319.html).
