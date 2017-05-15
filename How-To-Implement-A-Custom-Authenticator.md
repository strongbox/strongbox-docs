# Is There A Simple Example Project?

Yes, you can checkout out the [strongbox-authentication-example](https://github.com/strongbox/strongbox-authentication-example) project.

# What Dependencies Do I Need?

In your project you will need to add the following dependency:

     <dependencies>
         <dependency>
             <groupId>org.carlspring.strongbox</groupId>
             <artifactId>strongbox-authentication-api</artifactId>
             <version>${version.strongbox}</version>
         </dependency>
     </dependencies>

# What Do I Need To Implement?

1. Create an implementation of [`Authentication`](https://github.com/spring-projects/spring-security/blob/master/core/src/main/java/org/springframework/security/core/Authentication.java) or use one of its well known implementations like [`UsernamePasswordAuthenticationToken`](https://github.com/spring-projects/spring-security/blob/master/core/src/main/java/org/springframework/security/authentication/UsernamePasswordAuthenticationToken.java). You can find a simple example of this in the [`EmptyAuthentication`](https://github.com/carlspring/strongbox-authentication-example/blob/master/src/main/java/org/carlspring/strongbox/authentication/impl/example/EmptyAuthentication.java) class of the [strongbox-authentication-example](https://github.com/strongbox/strongbox-authentication-example). 

2. Create an implementation of [`AuthenticationSupplier`](https://github.com/strongbox/strongbox/blob/master/strongbox-authentication-api/src/main/java/org/carlspring/strongbox/authentication/api/AuthenticationSupplier.java). Its implementation is supposed to deliver an [`Authentication`](https://github.com/spring-projects/spring-security/blob/master/core/src/main/java/org/springframework/security/core/Authentication.java) instance from the currently served HTTP request. You can find a simple example of this in the [`EmptyAuthenticationSupplierComponent`](https://github.com/strongbox/strongbox-authentication-example/blob/master/src/main/java/org/carlspring/strongbox/authentication/impl/example/EmptyAuthenticationSupplierComponent.java).

3. Create an implementation of [`AuthenticationProvider`](https://github.com/spring-projects/spring-security/blob/master/core/src/main/java/org/springframework/security/authentication/AuthenticationProvider.java). The purpose of this class is to process a specific [`Authentication`](https://github.com/spring-projects/spring-security/blob/master/core/src/main/java/org/springframework/security/core/Authentication.java) implementation and return a fully authenticated object including credentials. You can find a simple example of this in the [`EmptyAuthenticationProviderComponent`](https://github.com/strongbox/strongbox-authentication-example/blob/master/src/main/java/org/carlspring/strongbox/authentication/impl/example/EmptyAuthenticationProviderComponent.java).

4. Create an implementation of [`Authenticator`](https://github.com/strongbox/strongbox/blob/master/strongbox-authentication-api/src/main/java/org/carlspring/strongbox/authentication/api/Authenticator.java). This is the core API interface that delivers [`AuthenticationSupplier`](https://github.com/strongbox/strongbox/blob/master/strongbox-authentication-api/src/main/java/org/carlspring/strongbox/authentication/api/AuthenticationSupplier.java), [`AuthenticationProvider`](https://github.com/spring-projects/spring-security/blob/master/core/src/main/java/org/springframework/security/authentication/AuthenticationProvider.java) and a name used for recognition. You can find a simple example of this in the [`EmptyAuthenticator`](https://github.com/strongbox/strongbox-authentication-example/blob/master/src/main/java/org/carlspring/strongbox/authentication/impl/example/EmptyAuthenticator.java).

# Why Is There A Separation Between `AuthenticationSupplier` and `AuthenticationProvider`?

There are already a large number of existing [`AuthenticationProvider`](http://docs.spring.io/spring-security/site/docs/current/apidocs/org/springframework/security/authentication/AuthenticationProvider.html) implementations for various needs, which are ready for use. The role of the [`AuthenticationSupplier`](https://github.com/strongbox/strongbox/blob/master/strongbox-authentication-api/src/main/java/org/carlspring/strongbox/authentication/api/AuthenticationSupplier.java) is quite different.

# My Implementation Is Ready. What now?

1. Build your code:

```
mvn clean package
```

2. Transfer your `jar` file to the `strongbox/webapp/WEB-INF/lib` directory under the `strongbox` home directory in your strongbox distribution.

# Final notes

Please remember that [`Authenticator`](https://github.com/strongbox/strongbox/blob/master/strongbox-authentication-api/src/main/java/org/carlspring/strongbox/authentication/api/Authenticator.java) implementations have to be Spring `@Components`. They are scanned by the Spring mechanisms to load fresh Application Context in the start time, or in the runtime (on reload request).
