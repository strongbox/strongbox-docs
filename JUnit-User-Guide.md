# General
JUnit 5, which is the next generation of JUnit, promises to be a programmer-friendly testing framework for Java 8. More info on the [official user guide](https://junit.org/junit5/docs/current/user-guide/).

# Architecture
There are 3 separated modules:

JUnit 5 = JUnit Platform + JUnit Jupiter + JUnit Vintage

### JUnit Platform

Foundation for launching testing frameworks on the JVM. Defines the TestEngine API for developing a testing framework that runs on the platform.

### JUnit Jupiter

Includes new programming model and extension model for writing tests and extensions in JUnit 5 such as new assertions, new annotations, Java 8 Lambda Expressions, etc.

### JUnit Vintage

Supports running JUnit 3 and JUnit 4 based tests on the JUnit 5 platform.

# Supported Java Versions
JUnit 5 requires Java 8 (or higher) at runtime. However, you can still test code that has been compiled with previous versions of the JDK.

# Annotations
| Feature description  | Annotation |
| ------------- | ------------- |
| Declares a test method | `@Test` |
| Denotes that the annotated method will be executed before all test methods in the current class | `@BeforeAll` |
| Denotes that the annotated method will be executed after all test methods in the current class | `@AfterAll` |
| Denotes that the annotated method will be executed before each test method | `@BeforeEach` |
| Denotes that the annotated method will be executed after each test method | `@AfterEach` |	
| Disable a test method or a test class | `@Disable` |	
| Denotes a method is a test factory for dynamic tests | `@TestFactory` |	
| Denotes that the annotated class is a nested, non-static test class |	`@Nested` |	
| Declare tags for filtering tests | `@Tag` |	
| Register custom extensions | `@ExtendWith` |	
| Repeated Tests | `@RepeatedTest` |	

# Assertions
JUnit Jupiter comes with many of the assertion methods that JUnit 4 has and adds a few that lend themselves well to being used with Java 8 lambdas. All JUnit Jupiter assertions are static methods in the `org.junit.jupiter.api.Assertions` class.

We have to know a few basic rules:

* If we want to specify a custom error message that is shown when our assertion fails, we have to pass this message as the **last** method parameter of the invoked assertion method.
* If we want to compare two values (or objects), we have to pass these values (or objects) to the invoked assertion method in this order: the expected value (or object) and the actual value (or object).

| Condition | Assertion
| ------------- | ------------- |
| Fails a test with the given failure message | `fail`|
| If we want to verify that a boolean value is true | `assertTrue` |
| If we want to ensure that two objects refer to the same object | `assertSame` | |
| If we want to verify that an object is null | `assertNull` |
| If we want to ensure that two objects don't refer to the same object | `assertNotSame` |
| If we want to verify that the expected value (or object) is not equal to the actual value (or object) | `assertNotEquals` |
| If we want to verify that an object is not null | `assertNotNull` |
| If we want to verify that a boolean value is false | `assertFalse`|
| If we want to verify that the expected value (or object) is equal to the actual value (or object) | `assertEquals` |
| If we want to verify that two arrays are equal | `assertArrayEquals` |
| If we have to write an assertion for a state that requires multiple assertions | `assertAll`|
| If we want to write assertions for the exceptions thrown by the system | `assertThrows` |

