# Writing tests

## Basic rules

* Use [JUnit 5] as testing framework (both unit and integration tests).
* All code must be accompanied with sufficiently thorough test cases which validate the functionality.
* If tests are failing, they are a top priority.
* Pull requests will not be merged, if there are failing tests.
* Pull requests will not be merged, if they mark tests as `@Disabled`, without prior explanation of the cause and approval from the reviewer/team.
* If you need to create a repository for your test and it needs to use the [Maven 2 Layout Provider], please make sure you're only enabling indexing, if really necessary, as this can be quite expensive in terms of resources.
* All tests **MUST be idempotent**, which means that we should be able to execute them multiple times from the console or an IDE and the outcome should not depend on how many times the test has been executed.
* Use [rest-assured](https://github.com/rest-assured/rest-assured/wiki/GettingStarted#spring-mock-mvc) for testing REST API. Don't try to re-invent the wheel and inherit all rest-assured initialization stuff from `RestAssuredBaseTest`. Mark your test as `@IntegrationTest` and take a look at the existing examples (sub-classes of `RestAssuredBaseTest`). If you would like to have some initialization method with `@BeforeEach` annotation, please make sure that you also invoke `super.init()` as a first line in such methods.
* Don't use the REST API calls for testing your service class methods, test them directly using RestAssured.
* Tests that need to execute operations against a repository, should create the repository on the fly in order to guarantee test resource isolation.
  * The naming convention for such repositories is as follows: given a class name of `MavenMetadataForReleasesTest`, the respective repository should be called `mmfrt-releases`.

## Test resources

* Test cases should be self-sufficient and not rely on data, or resources produced by other tests, or the outcome of other tests in any other way.
* Every test case should generate all the resources it requires in each of its respective test methods.
* Do not name test resources with common dummy names such as `foo.txt`, `bar.zip`, `blah.jar` and etc, as this might cause resource collisions and issues, in case someone else decided to use such a name (if you spot any such resources, please raise an issue/pull, as this is bad practice).

## Test Repositories

As mentoned above every test should have isolated and self-sufficient resources, this requirment can be achieved with `@TestRepository` annotation. This annotation provides isolated Test Repository which can be used as sandbox for purposes of your test method.

Usage Example:

```
@ExtendWith(RepositoryManagementTestExecutionListener.class)
@Test
public void testWithRepository(@TestRepository(storage = "storage0",
                                               repository = "repo1",
                                               layout = MavenArtifactCoordinates.LAYOUT_NAME) 
                               Repository repository)
{
    System.out.println(repository.getId());
}
```

Test Repository injected as test method parameter with help of `RepositoryManagementTestExecutionListener`. The important feature here is synchronization between concurrent test executions, so even if there will be other repositories with the same name within other tests then it will be synchronized by Repository ID and will not affect on each other.
The other feature is that Test Repository will be removed and cleaned up after test execution, just like it was created before test execution from scratch.

Below is the main configuration parameters that avaliable:

- with `storage` and `repository` you can specifiy Storage and Repository ID to use
- with `layout` you can set the Layout to use (ex. `MavenArtifactCoordinates.LAYOUT_NAME`, `NpmArtifactCoordinates.LAYOUT_NAME`, `NugetArtifactCoordinates.LAYOUT_NAME` etc.)
- with `setup` parameter you can customize the Test Repository initialization with `RepositorySetup` strategy, for example there is `MavenIndexedRepositorySetup` for Indexed Maven Repositories.
- for debug purpose there is a `cleanup` flag (`true` by default), you can disable Test Reoisutory clean up with set it to `false`

By default `TestRepository` provides [Hosted](https://strongbox.github.io/knowledge-base/repositories.html#hosted) repository, other Repository Types also avaliable. 

### Proxy Repositories

[Proxy](https://strongbox.github.io/knowledge-base/repositories.html#proxy) reposiotry support provided with `@TestRepository.Remote` annotation.
Example:

```
@ExtendWith(RepositoryManagementTestExecutionListener.class)
@Test
public void testWithProxyRepository(@TestRepository.Remote(url = "http://repo1.maven.org/maven2/")
                                    @MavenRepositroy(repository = "repo1") 
                                    Repository repository)
{
    System.out.println(repository.getId());
}
```

### Group Repositories

[Group](https://strongbox.github.io/knowledge-base/repositories.html#group) reposiotry support provided with `@TestRepository.Group` annotation.
Example:

```
@ExtendWith(RepositoryManagementTestExecutionListener.class)
@Test
public void testWithGroupRepository(@MavenRepositroy(repository = "group-member-repo1") 
                                    Repository repository1,
                                    @MavenRepositroy(repository = "group-member-repo2") 
                                    Repository repository2,
                                    @MavenRepositroy(repository = "group-member-repo3") 
                                    Repository repository3,
                                    @Group({"group-member-repo1", "group-member-repo2", "group-member-repo3"})
                                    @MavenRepositroy(repository = "repo1") 
                                    Repository groupRepository)
{
    System.out.println(groupRepository.getId());
}
```

[Routing Rules](https://strongbox.github.io/user-guide/artifact-routing-rules.html) configuration also avaliable with `@TestRepository.Group.Rule` annotation.

## Test Artifacts

The is a generic [ArtifactGenerator](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-api/src/test/java/org/carlspring/strongbox/artifact/generator/ArtifactGenerator.java) interface which provides various methods for generating Test Artifacts.

You can use this interface implementations standalone like below:

``` 
ArtifactGenerator mavenArtifactGenerator = new MavenArtifactGenerator(Paths.get("."));
mavenArtifactGenerator.generateArtifact("org.carlspring.test:test-artifact", "1.2.4", 1024):
```

The above example will generate **test-artifact-1.2.4.jar**, **test-artifact-1.2.4.jar.md5** , **test-artifact-1.2.4.jar.sha1** and **test-artifact-1.2.4.pom** files.

The other way to generate artifacts within your test method is `@TestArtifact` annotation.

Example:


```
@ExtendWith(ArtifactManagementTestExecutionListener.class)
@Test
public void testWithArtifact(@TestArtifact(resource = "org/carlspring/strongbox/test/test-artifact/1.0/test-artifact-1.0.jar",
                                           generator = MavenArtifactGenerator.class)
                             Path artifact1,
                             @TestArtifact(id = "org.carlspring.strongbox.test:another-test-artifact",
                                           versions = "1.1",
                                           generator = MavenArtifactGenerator.class)
                             Path artifact2)
{
...
}
```

This will also genrate jar, checksums and pom and inject the `java.nio.file.Path` instance, pointing to jar artifact, as test method parameter. Having the artifact `Path` you can easily get the **md5** following way:

```
Path artifact1Md5 = artifact1.resolveSbilling(artifact1.getFileName() + ".md5");
```
Test artifacts also synchronized between concurrent test executions, same way as Test Repository.

Note that above examples will just generate Test Artifacts without deploing to any repository, generated files will be placed in test method related temporary folder.

### Deploy Test Artifacts into Test Repository

It's also possible to inject deployed artifacts:

```
@ExtendWith({ RepositoryManagementTestExecutionListener.class,
              ArtifactManagementTestExecutionListener.class })
@Test
public void testArtifact(@MavenRepository(repository = "r1")
                         Repository r1,
                         @MavenArtifact(repository = "r1",
                                        id = "org.carlspring.strongbox.test:another-test-artifact",
                                        versions = {"1.1", "1.2"})
                         List<Path> repositoryArtifacs)
{
...
}
```

With `repository` attribute the Test Artifacts `repositoryArtifacts` will be deployed into Test Repository `r1`, other generated files (checksums, poms etc.) will also be deployed. The above example also shows the case when multiply artifact versions generated, so the `List` contains ordered artifact versions:

```
Path v1_1Artifact = repositoryArtifacs.get(0);
Path v1_2Artifact = repositoryArtifacs.get(1);
```

### Layout specific Test Artifacts

It is possible to customize the Test Artifact generation with `ArtifactGeneratorStrategy`. For example there is `MavenArtifactGeneratorStrategy` implementation and `@MavenTestArtifact` annotation which allows to generate Maven sprcific artifacts like classifiers and plugins.


### Life Hacks to make Artifacts testing easier

Below is the tips to help wiring nice tests

#### Shortcut annotations

You can use Shortcut annotations defined directly wihitn your test class with `@AliasFor` annotation:

```
public class NiceArtifactAndRepositoryTest 
{
    
    @Test
    @ExtendWith({ RepositoryManagementTestExecutionListener.class, ArtifactManagementTestExecutionListener.class })
    public void testOne(@MavenRepository(repository = REPOSITORY_SNAPSHOTS, policy = RepositoryPolicyEnum.SNAPSHOT) Repository repository,
                        @MavenSnapshotArtifactsWithClassifiers(id = "org.carlspring.strongbox.test:snapshot-artifact") Path snapshotArtifacts)
    {
    ...
    }

    @Test
    @ExtendWith({ RepositoryManagementTestExecutionListener.class, ArtifactManagementTestExecutionListener.class })
    public void testTwo(@MavenRepository(repository = REPOSITORY_SNAPSHOTS, policy = RepositoryPolicyEnum.SNAPSHOT) Repository repository,
                        @MavenSnapshotArtifactsWithClassifiers(id = "org.carlspring.strongbox.test:another-snapshot-artifact") Path snapshotArtifacts)
    {
    ...
    }
    
    
    @Target({ ElementType.PARAMETER, ElementType.ANNOTATION_TYPE })
    @Retention(RetentionPolicy.RUNTIME)
    @Documented
    @MavenTestArtifact(repository = REPOSITORY_SNAPSHOTS, classifiers = { "javadoc",
                                                                          "sources",
                                                                          "source-release" })
    private static @interface MavenSnapshotArtifactsWithClassifiers
    {

        @AliasFor(annotation = MavenTestArtifact.class)
        String id();
        
        @AliasFor(annotation = MavenTestArtifact.class)
        String[] versions() default {"2.0-20180328.195810-1", "2.0-20180328.195810-2", "2.0-20180328.195810-3"};

    }
    
    
} 
```

Above example shows how to reduce boilerplate code with predefined `@MavenSnapshotArtifactsWithClassifiers` annotation, so test methods can reuse it to define Test Artifacts with common configuration parameters.

#### NullLayoutProvider

It is possible to use `NullLayoutProvider` to write generic tests in modules where other specific layouts not avaliable.

### Adding Artifacts To The Maven Index

For test cases where you need to generate artifacts and add them to the index, please have a look at the [TestCaseWithArtifactGenerationWithIndexing](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-indexing/src/test/java/org/carlspring/strongbox/testing/TestCaseWithArtifactGenerationWithIndexing.java) class.

Please, note that the above class is not currently something you can extend outside the scope of the `strongbox-storage-indexing` module.

## Integration Tests

Some of the tests don't need to be running all the time during development. We've marked these as integration tests in order to make the build times much more reasonable.

These tests are executed using the `maven-failsafe-plugin`. The default configurations for the `maven-surefire-plugin` and `maven-failsafe-plugin` are located in the [`strongbox/strongbox-parent/pom.xml`](https://github.com/strongbox/strongbox-parent/blob/master/pom.xml) file.

All these tests are executed in our Jenkins instance for all branches and pull requests.

### Naming Integration Tests

The integration tests in the project should end with a `*TestIT` name suffix.

### Executing Integration Tests

The integration tests can be invoked, by triggering the Maven profile that executes them by passing in `-Dintegration.tests` property.

## Web Form Tests

The web forms model classes inside the [strongbox-web-forms] module are validated inside its corresponding form. 
It is needed to test them in order to ensure that every validation is correct. Please check the guide on [Writing Web Form Tests].

## Testing REST calls

### How to write your own integration test

Here is sequence of actions for anyone who would like to write it's own REST API test.
* Extend `RestAssuredBaseTest` class
* Put `@IntegrationTest` and `@ExtendWith(SpringExtension.class)` on top of your class
* Review existing examples (subclasses of `RestAssuredBaseTest`)

### How to use rest-assured

Here is the simplest example that will send HTTP GET request to the `/greeting` endpoint:

    given().when()
           .get("/greeting")
           .then()
           .statusCode(200);

**Note:** You should have `import static com.jayway.restassured.module.mockmvc.RestAssuredMockMvc.*;` in your test.

### Where it differs from stock version of rest-assured

Instead of `given()` please use `givenLocal()` of `RestAssuredBaseTest`.

### Do I need to extend `RestAssuredArtifactClient` or write my own methods in unit tests?

Basically, **_no_**. The only reason to extend that class is when you would like to reuse something between several unit tests (to avoid code duplication).

### References

Please review this excellent article. It contains a lot of cool examples: [unit-testing-spring-mvc-controllers-with-rest-assured](https://blog.jayway.com/2014/01/14/unit-testing-spring-mvc-controllers-with-rest-assured/)

If you still have any questions please review original [usage wiki page by rest-assured](https://github.com/rest-assured/rest-assured/wiki/usage).

## Spring Test tips

### Spring Test Context caching

Spring provides a support for Test Context caching (see [here](https://docs.spring.io/spring/docs/current/spring-framework-reference/html/integration-testing.html#testcontext-ctx-management-caching)). Using single Test Context per maven module is preferable. Expand, adjust existing test context rather than create new one.

### `@PostConstruct` and `@PreDestroy` pitfalls

* `@PostConstruct` method on any application component configured in the `ApplicationContext` is getting called while Spring actually creates new Test Context
* `@PostConstruct` within an actual test class will be executed before any `@BeforeEach` method of the underlying test
* `@PreDestroy` method on any application component configured in the `ApplicationContext` is getting called when _all_ tests are finished (because of the Spring Test Context caching feature), when JVM exits
* `@PreDestroy` within an actual test class will _never_ be executed

## How Do The Tests Run In Jenkins?

For details on how the build and tests are executed in Jenkins, you can check the project's [Jenkinsfile](https://github.com/strongbox/strongbox/blob/master/Jenkinsfile) file. Also, all Strongbox sub-projects that are running in Jenkins will have such a file, so it could be used as a reference of how things are built and tested.

## See Also

* [Spring: Integration Testing Reference](https://docs.spring.io/spring/docs/current/spring-framework-reference/html/integration-testing.html#integration-testing-annotations-standard)

[strongbox-web-forms]: https://github.com/strongbox/strongbox/tree/master/strongbox-web-forms
[JUnit 5]: ./junit-user-guide.md
[Writing Web Form Tests]: ./writing-web-form-tests.md
[Maven 2 Layout Provider]: ./layout-providers/maven-2-layout-provider.md 
