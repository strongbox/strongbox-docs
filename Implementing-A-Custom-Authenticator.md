# Do we have some simple example ?

Sure, follow this link: https://github.com/strongbox/strongbox-authentication-example

# How to start ?

* Create new maven project with `<dependency>` to the latest possible _strongbox-authentication-api_ version, see an example of [pom.xml](https://github.com/carlspring/strongbox-authentication-example/blob/master/pom.xml)
* If you can't find any official _strongbox-authentication-api_ version, it means that strongbox hasn't been globally released yet and you need to build the code alone (see https://github.com/strongbox/strongbox/wiki/Building-the-code)

# What then ?

1. Create an implementation of [Authentication.java](https://github.com/spring-projects/spring-security/blob/master/core/src/main/java/org/springframework/security/core/Authentication.java) or use one of its well known implementations like [UsernamePasswordAuthenticationToken.java](https://github.com/spring-projects/spring-security/blob/master/core/src/main/java/org/springframework/security/authentication/UsernamePasswordAuthenticationToken.java). See simple example at [EmptyAuthentication.java](https://github.com/carlspring/strongbox-authentication-example/blob/master/src/main/java/org/carlspring/strongbox/authentication/impl/example/EmptyAuthentication.java). 

2. Create an implementation of [AuthenticationSupplier.java](https://github.com/strongbox/strongbox/blob/master/strongbox-authentication-api/src/main/java/org/carlspring/strongbox/authentication/api/AuthenticationSupplier.java). Its implementation is supposed to deliver an [Authentication.java](https://github.com/spring-projects/spring-security/blob/master/core/src/main/java/org/springframework/security/core/Authentication.java) instance from the currently served HTTP request. See simple example at [EmptyAuthenticationSupplierComponent.java](https://github.com/strongbox/strongbox-authentication-example/blob/master/src/main/java/org/carlspring/strongbox/authentication/impl/example/EmptyAuthenticationSupplierComponent.java).

3. Create an implementation of [AuthenticationProvider.java](https://github.com/spring-projects/spring-security/blob/master/core/src/main/java/org/springframework/security/authentication/AuthenticationProvider.java). The purpose of this class is to process a specific [Authentication.java](https://github.com/spring-projects/spring-security/blob/master/core/src/main/java/org/springframework/security/core/Authentication.java) implementation and return a fully authenticated object including credentials. See simple example at [EmptyAuthenticationProviderComponent.java](https://github.com/strongbox/strongbox-authentication-example/blob/master/src/main/java/org/carlspring/strongbox/authentication/impl/example/EmptyAuthenticationProviderComponent.java).

4. Create an implementation of [Authenticator.java](https://github.com/strongbox/strongbox/blob/master/strongbox-authentication-api/src/main/java/org/carlspring/strongbox/authentication/api/Authenticator.java). This is the core API interface that delivers [AuthenticationSupplier.java](https://github.com/strongbox/strongbox/blob/master/strongbox-authentication-api/src/main/java/org/carlspring/strongbox/authentication/api/AuthenticationSupplier.java), [AuthenticationProvider.java](https://github.com/spring-projects/spring-security/blob/master/core/src/main/java/org/springframework/security/authentication/AuthenticationProvider.java) and a name used for recognition. See simple example at [EmptyAuthenticator.java](https://github.com/strongbox/strongbox-authentication-example/blob/master/src/main/java/org/carlspring/strongbox/authentication/impl/example/EmptyAuthenticator.java).

# Why is there a separation between AuthenticationSupplier and AuthenticationProvider ?

Because there is a large number of `AuthenticationProviders` (http://docs.spring.io/spring-security/site/docs/current/apidocs/org/springframework/security/authentication/AuthenticationProvider.html) for your needs, ready to use. The role of the [AuthenticationSupplier.java](https://github.com/strongbox/strongbox/blob/master/strongbox-authentication-api/src/main/java/org/carlspring/strongbox/authentication/api/AuthenticationSupplier.java) is quite different.

# Final note

Please remember that [Authenticator.java](https://github.com/strongbox/strongbox/blob/master/strongbox-authentication-api/src/main/java/org/carlspring/strongbox/authentication/api/Authenticator.java) implementations have to be Spring `@Components`. They are scanned by the Spring mechanisms to load fresh Application Context in the start time, or in the runtime (on reload request).