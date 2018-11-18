# General

## Basic rules
* All code must be accompanied with sufficiently thorough test cases which validate the functionality.
* If tests are failing, they are a top priority.
* Pull requests will not be merged, if there are failing tests.
* Pull requests will not be merged, if they mark tests as `@Disabled`, without prior explanation of the cause and approval from the reviewer/team.
* If you need to create a repository for your test and it needs to use the [[Maven 2 Layout Provider]], please make sure you're only enabling indexing, if really necessary, as this can be quite expensive in terms of resources.
* Put `@Rollback(false)` if you want to persist something during the test execution. It will tell Spring to not to call `rollback()` on this class method transactions.
* All tests **MUST be idempotent**, which means that we should be able to execute them multiple times from the console or an IDE and the outcome should not depend on how many times the test has been executed.
* Use [rest-assured](https://github.com/rest-assured/rest-assured/wiki/GettingStarted#spring-mock-mvc) for testing REST API. Don't try to re-invent the wheel and inherit all rest-assured initialization stuff from `RestAssuredBaseTest`. Mark your test as `@IntegrationTest` and take a look at the existing examples (sub-classes of `RestAssuredBaseTest`). If you would like to have some initialization method with `@BeforeEach` annotation, please make sure that you also invoke `super.init()` as a first line in such methods.
* Don't use the REST API calls for testing your service class methods, test them directly using RestAssured.
* Tests that need to execute operations against a repository, should create the repository on the fly in order to guarantee test resource isolation.
  * Such cases should also implement the following methods in order to make sure that there are no stale resources from previous invocations:
    * `public static Set<MutableRepository> getRepositoriesToClean()`
    * `public void removeRepositories()`
  * The naming convention for such repositories is as follows: given a class name of `MavenMetadataForReleasesTest`, the respective repository should be called `mmfrt-releases`.

## Test resources
* Test cases should be self-sufficient and not rely on data, or resources produced by other tests, or the outcome of other tests in any other way.
* Every test case should generate all the resources it requires in each of its respective test methods.
* Do not name test resources with common dummy names such as `foo.txt`, `bar.zip`, `blah.jar` and etc, as this might cause resource collisions and issues, in case someone else decided to use such a name (if you spot any such resources, please raise an issue/pull, as this is bad practice).

# Artifact-related Tests

For artifact-related test you could create instance of `TestCaseWithArtifactGeneration` in your unit test or reuse one from `RestAssuredBaseTest`. Just delegate your call to super class field.

## Generating Artifacts

The [ArtifactGenerator](https://github.com/strongbox/strongbox/blob/master/strongbox-testing/strongbox-testing-core/src/main/java/org/carlspring/strongbox/artifact/generator/ArtifactGenerator.java) class provides various methods for generating valid Maven test artifacts.

To generate an artifact, you can use the following code:

    generateArtifact(REPOSITORY_BASEDIR_RELEASES.getAbsolutePath(),
                     "org.carlspring.strongbox.resolve.only:foo",
                     new String[]{ "1.1" }); // Used by testResolveViaProxy()

If you're generating this from your test's `setUp` method, please, make sure that:
* The artifact generation part is only invoked once
* For each artifact you add a comment explaining which test method is using this resource

## Adding Artifacts To The Maven Index

For test cases where you need to generate artifacts and add them to the index, please have a look at the [TestCaseWithArtifactGenerationWithIndexing](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-indexing/src/test/java/org/carlspring/strongbox/testing/TestCaseWithArtifactGenerationWithIndexing.java) class.

Please, note that the above class is not currently something you can extend outside the scope of the `strongbox-storage-indexing` module.

# Integration Tests

Some of the tests don't need to be running all the time during development. We've marked these as integration tests in order to make the build times much more reasonable.

These tests are executed using the `maven-failsafe-plugin`. The default configurations for the `maven-surefire-plugin` and `maven-failsafe-plugin` are located in the [`strongbox/strongbox-parent/pom.xml`](https://github.com/strongbox/strongbox/blob/master/strongbox-parent/pom.xml) file.

All these tests are executed in our Jenkins instance for all branches and pull requests.

## Naming Integration Tests

The integration tests in the project should end with a `*TestIT` name suffix.

## Executing Integration Tests

The integration tests can be invoked, by triggering the Maven profile that executes them by passing in `-Dintegration.tests` property.

# Testing REST calls

## How to write your own integration test

Here is sequence of actions for anyone who would like to write it's own REST API test.
* Extend `RestAssuredBaseTest` class
* Put `@IntegrationTest` and `@ExtendWith(SpringExtension.class)` on top of your class
* Review existing examples (subclasses of `RestAssuredBaseTest`)

## How to use rest-assured

Here is the simplest example that will send HTTP GET request to the `/greeting` endpoint:

    given().when()
           .get("/greeting")
           .then()
           .statusCode(200);

**Note:** You should have `import static com.jayway.restassured.module.mockmvc.RestAssuredMockMvc.*;` in your test.

## Where it differs from stock version of rest-assured

Instead of `given()` please use `givenLocal()` of `RestAssuredBaseTest`.

## Do I need to extend `RestAssuredArtifactClient` or write my own methods in unit tests?

Basically, **_no_**. The only reason to extend that class is when you would like to reuse something between several unit tests (to avoid code duplication).

## References

Please review this excellent article. It contains a lot of cool examples: [unit-testing-spring-mvc-controllers-with-rest-assured](https://blog.jayway.com/2014/01/14/unit-testing-spring-mvc-controllers-with-rest-assured/)

If you still have any questions please review original [usage wiki page by rest-assured](https://github.com/rest-assured/rest-assured/wiki/usage).

# Spring Test tips

## Spring Test Context caching

Spring provides a support for Test Context caching (see [here](https://docs.spring.io/spring/docs/current/spring-framework-reference/html/integration-testing.html#testcontext-ctx-management-caching)). Using single Test Context per maven module is preferable. Expand, adjust existing test context rather than create new one.

## `@PostConstruct` and `@PreDestroy` pitfalls

* `@PostConstruct` method on any application component configured in the `ApplicationContext` is getting called while Spring actually creates new Test Context
* `@PostConstruct` within an actual test class will be executed before any `@BeforeEach` method of the underlying test
* `@PreDestroy` method on any application component configured in the `ApplicationContext` is getting called when _all_ tests are finished (because of the Spring Test Context caching feature), when JVM exits
* `@PreDestroy` within an actual test class will _never_ be executed

# How Do The Tests Run In Jenkins?

For details on how the build and tests are executed in Jenkins, you can check the project's [`Jenkinsfile`](https://github.com/strongbox/strongbox/blob/master/Jenkinsfile) file. Also, all Strongbox sub-projects that are running in Jenkins will have such a file, so it could be used as a reference of how things are built and tested.

# See Also
* [Spring: Integration Testing Reference](https://docs.spring.io/spring/docs/current/spring-framework-reference/html/integration-testing.html#integration-testing-annotations-standard)