# HTTP request type unprotected from CSRF
Cross-site request forgery (CSRF) is a type of vulnerability in which an attacker is able to force a user to carry out an action that the user did not intend.

The attacker tricks an authenticated user into submitting a request to the web application. Typically, this request will result in a state change on the server, such as changing the user's password. The request can be initiated when the user visits a site controlled by the attacker. If the web application relies only on cookies for authentication, or on other credentials that are automatically included in the request, then this request will appear as legitimate to the server.


## Recommendation
Make sure any requests that change application state are protected from CSRF. Some application frameworks provide default CSRF protection for unsafe HTTP request methods (such as `POST`) which may change the state of the application. Safe HTTP request methods (such as `GET`) should only perform read-only operations and should not be used for actions that change application state.

This query currently supports the Spring and Stapler web frameworks. Spring provides default CSRF protection for all unsafe HTTP methods whereas Stapler provides default CSRF protection for the `POST` method.


## Example
The following examples show Spring request handlers allowing safe HTTP request methods for state-changing actions. Since safe HTTP request methods do not have default CSRF protection in Spring, they should not be used when modifying application state. Instead, use one of the unsafe HTTP methods which Spring default-protects from CSRF.


```java
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

// BAD - a safe HTTP request like GET should not be used for a state-changing action
@RequestMapping(value="/transfer", method=RequestMethod.GET)
public boolean doTransfer(HttpServletRequest request, HttpServletResponse response){
  return transfer(request, response);
}

// BAD - no HTTP request type is specified, so safe HTTP requests are allowed
@RequestMapping(value="/delete")
public boolean doDelete(HttpServletRequest request, HttpServletResponse response){
  return delete(request, response);
}

```

```java
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.DeleteMapping;

// GOOD - use an unsafe HTTP request like POST
@RequestMapping(value="/transfer", method=RequestMethod.POST)
public boolean doTransfer(HttpServletRequest request, HttpServletResponse response){
  return transfer(request, response);
}

// GOOD - use an unsafe HTTP request like DELETE
@DeleteMapping(value="/delete")
public boolean doDelete(HttpServletRequest request, HttpServletResponse response){
  return delete(request, response);
}

```
The following examples show Stapler web methods allowing safe HTTP request methods for state-changing actions. Since safe HTTP request methods do not have default CSRF protection in Stapler, they should not be used when modifying application state. Instead, use the `POST` method which Stapler default-protects from CSRF.


```java
import org.kohsuke.stapler.verb.GET;

// BAD - a safe HTTP request like GET should not be used for a state-changing action
@GET
public HttpRedirect doTransfer() {
  return transfer();
}

// BAD - no HTTP request type is specified, so safe HTTP requests are allowed
public HttpRedirect doPost() {
  return post();
}

```

```java
import org.kohsuke.stapler.verb.POST;

// GOOD - use POST
@POST
public HttpRedirect doTransfer() {
  return transfer();
}

// GOOD - use POST
@POST
public HttpRedirect doPost() {
  return post();
}

```

## References
* OWASP: [Cross Site Request Forgery (CSRF)](https://www.owasp.org/index.php/Cross-Site_Request_Forgery_(CSRF)).
* Spring Security Reference: [ Cross Site Request Forgery (CSRF)](https://docs.spring.io/spring-security/reference/servlet/exploits/csrf.html).
* Jenkins Developer Documentation: [ Protecting from CSRF](https://www.jenkins.io/doc/developer/security/form-validation/#protecting-from-csrf).
* MDN web docs: [ HTTP request methods](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods).
* Common Weakness Enumeration: [CWE-352](https://cwe.mitre.org/data/definitions/352.html).
