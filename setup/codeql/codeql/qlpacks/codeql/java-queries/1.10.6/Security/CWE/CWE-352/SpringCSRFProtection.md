# Disabled Spring CSRF protection
Cross-site request forgery (CSRF) is a type of vulnerability in which an attacker is able to force a user to carry out an action that the user did not intend.

The attacker tricks an authenticated user into submitting a request to the web application. Typically, this request will result in a state change on the server, such as changing the user's password. The request can be initiated when the user visits a site controlled by the attacker. If the web application relies only on cookies for authentication, or on other credentials that are automatically included in the request, then this request will appear as legitimate to the server.


## Recommendation
When you use Spring, Cross-Site Request Forgery (CSRF) protection is enabled by default. Spring's recommendation is to use CSRF protection for any request that could be processed by a browser client by normal users.


## Example
The following example shows the Spring Java configuration with CSRF protection disabled. This type of configuration should only be used if you are creating a service that is used only by non-browser clients.


```java
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@EnableWebSecurity
@Configuration
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
  @Override
  protected void configure(HttpSecurity http) throws Exception {
    http
      .csrf(csrf ->
        // BAD - CSRF protection shouldn't be disabled
        csrf.disable() 
      );
  }
}

```

## References
* OWASP: [Cross Site Request Forgery (CSRF)](https://www.owasp.org/index.php/Cross-Site_Request_Forgery_(CSRF)).
* Spring Security Reference: [ Cross Site Request Forgery (CSRF) ](https://docs.spring.io/spring-security/reference/servlet/exploits/csrf.html).
* Common Weakness Enumeration: [CWE-352](https://cwe.mitre.org/data/definitions/352.html).
