# Custom Authenticator

## Is There A Simple Example Project?

Yes, you can checkout out the [strongbox-authentication-example] project.

## What Dependencies Do I Need?

In your project you will need to add the following dependency:

```xml
<dependencies>
    <dependency>
        <groupId>org.carlspring.strongbox</groupId>
        <artifactId>strongbox-authentication-api</artifactId>
        <version>${version.strongbox}</version>
    </dependency>
</dependencies>
```

## What Do I Need To Implement?

1. Create an implementation of [AuthenticationProvider]. The purpose of this class is to process a specific 
[Authentication] implementation and return a fully authenticated object including credentials. You can find a simple 
example of this in the [EmptyAuthenticationProviderComponent].

2. Create an implementation of [Authenticator]. This is the core API interface that delivers [AuthenticationProvider]
 and a name used for recognition. You can find a simple example of this in the [EmptyAuthenticator].

## My Implementation Is Ready, Now What?

1. Build your code:

    ```
    mvn clean package
    ```

2. Copy the produced `jar` file to the `strongbox/webapp/WEB-INF/lib` directory under your Strongbox distribution.

## Final Notes

* Please remember that [Authenticator] implementations have to be Spring `@Components`. They are scanned by the Spring
  mechanisms to load fresh Application Context in the start time, or in the runtime (on reload request).
* There are already a large number of existing [AuthenticationProvider] implementations for various needs, which are ready for use. 

## See Also

* [Strongbox Authentication Example](https://github.com/strongbox/strongbox-authentication-example)
* [The strongbox‐authentication‐providers.xml File]
* [Spring JavaDocs: AuthenticationProvider](http://docs.spring.io/spring-security/site/docs/current/apidocs/org/springframework/security/authentication/AuthenticationProvider.html)


[strongbox-authentication-example]: https://github.com/strongbox/strongbox-authentication-example
[AuthenticationProvider]: https://github.com/spring-projects/spring-security/blob/master/core/src/main/java/org/springframework/security/authentication/AuthenticationProvider.java
[Authentication]: https://github.com/spring-projects/spring-security/blob/master/core/src/main/java/org/springframework/security/core/Authentication.java
[EmptyAuthenticationProviderComponent]: https://github.com/strongbox/strongbox-authentication-example/blob/master/src/main/java/org/carlspring/strongbox/authentication/impl/example/EmptyAuthenticationProviderComponent.java
[Authenticator]: https://github.com/strongbox/strongbox/blob/master/strongbox-authentication-api/src/main/java/org/carlspring/strongbox/authentication/api/Authenticator.java

TODO: fix links
