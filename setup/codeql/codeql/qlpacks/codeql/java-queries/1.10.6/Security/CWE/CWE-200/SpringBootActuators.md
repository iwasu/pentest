# Exposed Spring Boot actuators
Spring Boot includes features called actuators that let you monitor and interact with your web application. Exposing unprotected actuator endpoints can lead to information disclosure or even to remote code execution.


## Recommendation
Since actuator endpoints may contain sensitive information, carefully consider when to expose them, and secure them as you would any sensitive URL. Actuators are secured by default when using Spring Security without a custom configuration. If you wish to define a custom security configuration, consider only allowing users with certain roles to access these endpoints.


## Example
In the first example, the custom security configuration allows unauthenticated access to all actuator endpoints. This may lead to sensitive information disclosure and should be avoided.

In the second example, only users with `ENDPOINT_ADMIN` role are allowed to access the actuator endpoints.


```java
@Configuration(proxyBeanMethods = false)
public class CustomSecurityConfiguration {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        // BAD: Unauthenticated access to Spring Boot actuator endpoints is allowed
        http.securityMatcher(EndpointRequest.toAnyEndpoint());
        http.authorizeHttpRequests((requests) -> requests.anyRequest().permitAll());
        return http.build();
    }

}

@Configuration(proxyBeanMethods = false)
public class CustomSecurityConfiguration {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        // GOOD: only users with ENDPOINT_ADMIN role are allowed to access the actuator endpoints
        http.securityMatcher(EndpointRequest.toAnyEndpoint());
        http.authorizeHttpRequests((requests) -> requests.anyRequest().hasRole("ENDPOINT_ADMIN"));
        return http.build();
    }

}

```

## References
* Spring Boot Reference Documentation: [Endpoints](https://docs.spring.io/spring-boot/reference/actuator/endpoints.html).
* Common Weakness Enumeration: [CWE-200](https://cwe.mitre.org/data/definitions/200.html).
