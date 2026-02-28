# Regular expression injection
Constructing a regular expression with unsanitized user input can be dangerous. A malicious user may be able to modify the meaning of the expression, causing it to match unexpected strings and construct large regular expressions by using counted repetitions.


## Recommendation
Before embedding user input into a regular expression, escape the input string using a function such as [regex::escape](https://docs.rs/regex/latest/regex/fn.escape.html) to escape meta-characters that have special meaning.

If purposefully supporting user supplied regular expressions, then use [RegexBuilder::size_limit](https://docs.rs/regex/latest/regex/struct.RegexBuilder.html#method.size_limit) to limit the pattern size so that it is no larger than necessary.


## Example
The following example constructs a regular expressions from the user input `key` without escaping it first.


```rust
use regex::Regex;

fn get_value<'h>(key: &str, property: &'h str) -> Option<&'h str> {
    // BAD: User provided `key` is interpolated into the regular expression.
    let pattern = format!(r"^property:{key}=(.*)$");
    let re = Regex::new(&pattern).unwrap();
    re.captures(property)?.get(1).map(|m| m.as_str())
}
```
The regular expression is intended to match strings starting with `"property"` such as `"property:foo=bar"`. However, a malicious user might inject the regular expression `".*^|key"` and unexpectedly cause strings such as `"key=secret"` to match.

If user input is used to construct a regular expression, it should be escaped first. This ensures that malicious users cannot insert characters that have special meanings in regular expressions.


```rust
use regex::{escape, Regex};

fn get_value<'h>(key: &str, property: &'h str) -> option<&'h str> {
    // GOOD: User input is escaped before being used in the regular expression.
    let escaped_key = escape(key);
    let pattern = format!(r"^property:{escaped_key}=(.*)$");
    let re = regex::new(&pattern).unwrap();
    re.captures(property)?.get(1).map(|m| m.as_str())
}
```

## References
* `regex` crate documentation: [Untrusted patterns](https://docs.rs/regex/latest/regex/index.html#untrusted-patterns).
* Common Weakness Enumeration: [CWE-20](https://cwe.mitre.org/data/definitions/20.html).
* Common Weakness Enumeration: [CWE-74](https://cwe.mitre.org/data/definitions/74.html).
