# JUnit User Guide

## Intro

JUnit is one of the most popular unit-testing frameworks in the Java ecosystem. JUnit 5, which is the next generation 
of JUnit, promises to be a programmer-friendly testing framework for Java 8. More info on the [official user guide](https://junit.org/junit5/docs/current/user-guide/).

## Architecture

There are 3 separated modules:

JUnit 5 = JUnit Platform + JUnit Jupiter + JUnit Vintage

### JUnit Platform

Foundation for launching testing frameworks on the JVM. Defines the TestEngine API for developing a testing framework 
that runs on the platform.

### JUnit Jupiter

Includes new programming model and extension model for writing tests and extensions in JUnit 5 such as new assertions, 
new annotations, Java 8 Lambda Expressions, etc.

### JUnit Vintage

Supports running JUnit 3 and JUnit 4 based tests on the JUnit 5 platform.

## Supported Java Versions
JUnit 5 requires Java 8 (or higher) at runtime. However, you can still test code that has been compiled with previous 
versions of the JDK.

## Strongbox base classes
This project uses multiple base classes depending on the funcionality to test.

### Integration tests
`@IntegrationTest` is a helper meta annotation for all rest-assured based tests. Specifies tests that require web server 
and remote HTTP protocol.

```java
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@SpringBootTest(classes = { StrongboxSpringBootApplication.class,
                            MockedRemoteRepositoriesHeartbeatConfig.class,
                            IntegrationTest.TestConfig.class,
                            RestAssuredConfig.class})
@WebAppConfiguration("classpath:")
@WithUserDetails(value = "admin")
@ActiveProfiles(profiles = "test")
@TestExecutionListeners(listeners = { RestAssuredTestExecutionListener.class,
                                      CacheManagerTestExecutionListener.class }, 
                        mergeMode = TestExecutionListeners.MergeMode.MERGE_WITH_DEFAULTS)
public @interface IntegrationTest
{
}
```

An example using this annotation would be:

```java
@IntegrationTest
@ExtendWith(SpringExtension.class)
public class PingControllerTest
        extends MavenRestAssuredBaseTest
{

    @Override
    @BeforeEach
    public void init()
            throws Exception
    {
        super.init();
        setContextBaseUrl(getContextBaseUrl() + "/api/ping");
    }

    @Test
    public void testShouldReturnPongText()
    {

        given().header(HttpHeaders.ACCEPT, MediaType.TEXT_PLAIN_VALUE)
               .when()
               .get(getContextBaseUrl())
               .peek()
               .then()
               .statusCode(HttpStatus.OK.value())
               .body(equalTo("pong"));
    }
}
```

### Layout providers tests
We also can test and validate REST services depending on the layout provider. A few base classes with useful methods 
can be extended, for example:

* `MavenRestAssuredBaseTest` for Maven-based tests.
* `NpmRestAssuredBaseTest` for npm-based tests.
* `NugetRestAssuredBaseTest` for NuGet-based tests.

## Annotations

| Annotation      | Feature description |
|:--------------- | ------------------- |
| `@Test`         | Declares a test method | 
| `@BeforeAll`    | Denotes that the annotated method will be executed before all test methods in the current class | 
| `@AfterAll`     | Denotes that the annotated method will be executed after all test methods in the current class |
| `@BeforeEach`   | Denotes that the annotated method will be executed before each test method |
| `@AfterEach`    | Denotes that the annotated method will be executed after each test method |	
| `@Disable`      | Disable a test method or a test class |	
| `@TestFactory`  | Denotes a method is a test factory for dynamic tests |	
| `@Nested`       | Denotes that the annotated class is a nested, non-static test class |	
| `@Tag`          | Declare tags for filtering tests |	
| `@ExtendWith`   | Register custom extensions |	
| `@RepeatedTest` &nbsp; | Repeated Tests |	

## Assertions

JUnit Jupiter comes with many of the assertion methods that JUnit 4 has and adds a few that lend themselves well to 
being used with Java 8 lambdas. All JUnit Jupiter assertions are static methods in the `org.junit.jupiter.api.Assertions` class.

We have to know a few basic rules:

* If we want to specify a custom error message that is shown when our assertion fails, we have to pass this message as the **last** method parameter of the invoked assertion method.
* If we want to compare two values (or objects), we have to pass these values (or objects) to the invoked assertion method in this order: the expected value (or object) and the actual value (or object).

| Assertion     | Condition     | 
| ------------- | ------------- |
| `fail` | Fails a test with the given failure message |
| `assertTrue` | If we want to verify that a boolean value is true |
| `assertSame` | If we want to ensure that two objects refer to the same object |
| `assertNull` | If we want to verify that an object is null |
| `assertNotSame` | If we want to ensure that two objects don't refer to the same object |
| `assertNotEquals` | If we want to verify that the expected value (or object) is not equal to the actual value (or object) |
| `assertNotNull` | If we want to verify that an object is not null |
| `assertFalse`| If we want to verify that a boolean value is false |
| `assertEquals` | If we want to verify that the expected value (or object) is equal to the actual value (or object) |
| `assertArrayEquals` &nbsp; &nbsp; | If we want to verify that two arrays are equal |
| `assertAll`| If we have to write an assertion for a state that requires multiple assertions |
| `assertThrows` | If we want to write assertions for the exceptions thrown by the system |

### Difference  in the position of optional assertion message parameter
The optional assertion message is the last parameter applied for all assertion methods support it.

`assertEquals(48080, configuration.getPort(), "Incorrect port number!");`

### Lambda expressions

Assert methods in JUnit 5 can be used with Java 8 Lambdas.
For example:

```java
assertThrows(VersionValidationException.class, () -> {
    validator.validate(repository, coordinates);
});
```

## Tagging and Filtering

Use `@Tag` annotation for tagging and filtering:

```java 
public class BrowseControllerTest
        extends MavenRestAssuredBaseTest
{
    @Test
    @Tag("development")
    @Tag("production")
    void testGetStorages(TestInfo testInfo) { //run in all environments
    }
}
 
public class TrashControllerTest
        extends MavenRestAssuredBaseTest
{
    @Test
    @Tag("development")
    void testForceDeleteArtifactAllowed(TestInfo testInfo) {
    }
}
 
``` 

### Create test plans

You can use `@IncludeTags` annotations in your test plan to filter tests or include tests.
```java 
@IntegrationTest
@ExtendWith(SpringExtension.class)
@SelectPackages("org.carlspring.strongbox.controllers")
@IncludeTags("production")
public class ProductionControllerTest
        extends MavenRestAssuredBaseTest
{
}
``` 

## Parameterized Tests
JUnit 5 supports parameterized tests by default. This feature allows us to run a test multiple times with different arguments.

For example, let’s see the following test:
```java
@ParameterizedTest
@ValueSource(strings = { "plain",
                         "SSL",
                         "tls" })
void testSmtpConfigurationFormValid(String connection)
{
    // given
    SmtpConfigurationForm smtpConfigurationForm = new SmtpConfigurationForm();
    smtpConfigurationForm.setHost("localhost");
    smtpConfigurationForm.setPort(25);
    smtpConfigurationForm.setConnection(connection);

    // when
    Set<ConstraintViolation<SmtpConfigurationForm>> violations = validator.validate(smtpConfigurationForm);

    // then
    assertTrue(violations.isEmpty(), "Violations are not empty!");
}
``` 

The `@ParameterizedTest` and `@ValueSource` annotations make the test can run with each value provided by the 
`@ValueSource` annotation. For instance, the console launcher will print output similar to the following:

``` 
testSmtpConfigurationFormValid(String) ✔
├─ [1] plain ✔
└─ [2] SSL ✔
└─ [3] tls ✔
``` 

Besides the `@ValueSource`, JUnit 5 provides many kinds of sources can be used with Parameterized Tests such as:

* `@CsvFileSource`: lets us use CSV files from the classpath. Each line from a CSV file results in one invocation of the parameterized test.
* `@MethodSource`: allows us to refer to one or multiple methods of the test class. Each method must return a Stream, an Iterable, an Iterator, or an array of arguments.
* `@ArgumentsSource`: can be used to specify a custom, reusable ArgumentsProvider.
* `@EnumSource`: provides a convenient way to use Enum constants.

## Repeated Tests
A new feature in JUnit 5 which allows us to repeat a test in a specified number of times is Repeated Tests. Let’s see an example which declares a test that will be repeated in 100 times:

```java
@RepeatedTest(100)
void repeatedTest() {
    // ...
}
``` 

## Dynamic Tests
JUnit 5 introduces the concept of Dynamic Tests which are tests that can be generated at runtime by a factory method. 
Let’s see an example which we generate 2 tests at runtime:

```java
@TestFactory
Collection<DynamicTest> dynamicTestsFromCollection() {
    return Arrays.asList(
        dynamicTest("1st dynamic test", () -> assertTrue(true)),
        dynamicTest("2nd dynamic test", () -> assertEquals(4, 2 * 2))
    );
}
``` 
