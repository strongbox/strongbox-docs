# Writing Web Integration Tests

This article illustrates how to use our web integration test infrastructure and develop tests for it.

## Introduction

The [strongbox-web-integration-tests](https://github.com/strongbox/strongbox-web-integration-tests) project contains various integration tests for the Strongbox project and the different repository layout formats supported by it. We use Maven to for the build, which in term starts a Strongbox instance and executes Groovy-based tests against it.

The following build tools have Groovy-based integration tests:

* Gradle
* Maven (these tests are using the [maven-invoker-plugin](https://maven.apache.org/plugins/maven-invoker-plugin/) that starts Maven during the build and runs various build operations)
* NPM
* NuGet
* Raw
* PyPi (`pip`, `twine`)
* SBT

Each of the modules in the project is built as a Maven project and:

* Starts the Strongbox Spring Boot application
* Runs the Groovy tests against the Strongbox Spring Boot application

The code used to start the Spring Boot application is either retrieved from our repository, or, if you've made local modifications, it uses them directly from your local Maven cache.

This project is often referred to as `s-w-i-t` for brevity.

## Writing Web Integration Tests

Let's take an example of `PyPi layout provider` and the `pip` tool to explain how to write web integration tests.

* Create a new module in [strongbox-web-integration-tests](https://github.com/strongbox/strongbox-web-integration-tests) for layout provider to be tested.
* Create a base test class like [PypiWebIntegrationTest](https://github.com/strongbox/strongbox-web-integration-tests/blob/master/pypi/src/it/PypiWebIntegrationTest.groovy) having common methods which should be used by all the tests.
* For each test case a new [package](https://github.com/strongbox/strongbox-web-integration-tests/blob/master/pypi/src/it/common-flows/pip-package-upload-test) should be created so that the test could be executed in isolation without affecting other tests.
* The package should have all the files and folders required by the tool used for test (In Python's case, these would be `setup.cfg`, `setup.py` for `pip`).
* Below are the steps which should be followed for tests:
  * Create a groovy based [test class](https://github.com/strongbox/strongbox-web-integration-tests/blob/master/pypi/src/it/common-flows/test-pypi-common-flows.groovy) for the test cases.
  * Import Base test class.
    ```java
    def baseScript = new GroovyScriptEngine("$project.basedir/src/it").with
    { 
        loadScriptByName('PypiWebIntegrationTest.groovy') 
    }
    ```
  * Determine Operation system and decide command to be run based on OS.
  * Execute the command and verify/assert the result.
    ```java
    // Assert directory exists for package uploaded
    Path packageDirectoryPath = uploadPackageDirectoryPath.resolve("dist");
    boolean pathExists = Files.isDirectory(packageDirectoryPath,
                                           LinkOption.NOFOLLOW_LINKS);
    
    assert pathExists == true
              
    // upload python package using pip command
    runCommand(uploadPackageDirectoryPath, packageUploadCommand)
              
    def commandOutput
    // Install uploaded python package using pip command and assert success
    def uploadedPackageName = "pip_upload_test"
    commandOutput = runCommand(uploadPackageDirectoryPath, pipInstallPackageCommand + " " + uploadedPackageName)
    assert commandOutput.contains("Successfully installed " + uploadedPackageName.replace("_" , "-") + "-1.0")
    ``` 
      
## Running Tests

The Web Integration tests can be run using both Maven and Docker.

Typically, you would use Maven to run the tests from one sub-module, (unless you have all the possible tools that are required for executing the tests, for example, Gradle, NuGet, NPM already installed, which is usually not the case). This is why re recommend running the tests using Docker, as the Docker images are pre-configured with everything you will need to run the tests in the exact same way they would run on our CI server (Jenkins).

### Using Maven

Each module has a `pom.xml` file. Go to the respective module (for example. `cd pypi`) and execute the `mvn clean install` command. This will launch the Strongbox application instance and will execute web integration tests against it.

### Using Docker

To make development and testing easier, we've created Docker images for all of the tools we are testing against, so that 
you don't have to go through the process of installing them manually.

For this to work, you need to have installed `docker` and `docker-compose` on your machine.

Afterwards, just go to the respective sub-project (i.e. `cd maven`) and execute `docker-compose up`.

Each module has a `docker-compose.yml` file.

You can run all the tests (for all modules) like this:

```
for tool in `ls -ap | grep \/ | grep -v -e "\."`; do cd ${tool} && docker-compose up & cd -; done
```

Alternatively, you can go to respective tool’s module that you're interested in and execute the following command:

```
docker-compose up
```

This will automatically build the code using Maven after spinning up a Docker container with a Strongbox application instance  and will run the web integration tests against it and then switch it off when it's done.


```yaml
version: '3'
services:
  strongbox-web-integration-tests-pypi:
    image: strongboxci/alpine:jdk8-mvn3.6-pip19.3
    volumes:
      - $HOME/.m2/repository:/home/jenkins/.m2/repository
      - ../:/workspace
    working_dir: /workspace/pypi
    command: mvn clean install -U
```

### Windows Notes

If you are using Windows, you need to install all of the [tools](#tools) below and make them available in your `PATH`.
[Nuget](https://dist.nuget.org/win-x86-commandline/v3.4.4/nuget.exe) requires `.Net Framework v4` and you need to 
set the `NUGET_V3_EXEC` environment variable to point to the executable `c:/path/to/nuget.exe`.

Alternatively, you can use `docker-compose up`, if you have Docker and `docker-compose` installed.

### Linux Notes

If you are using linux, you need to install all of the [tools](#tools) below and make them available in your `PATH`.
To run Nuget tests here you will need `mono` to be installed. 
There were many problems with the compatibility of `nuget.exe` and `mono` versions, and the sutable combination is the following:

- Mono JIT compiler version 5.2.0.215 (tarball Mon Aug 14 15:46:23 UTC 2017)
- `nuget.exe` [v3.4.4](https://dist.nuget.org/win-x86-commandline/v3.4.4/nuget.exe)
- `NUGET_V3_EXEC` need to be set with value `mono \path\to\nuget.exe`

Alternatively, you can use `docker-compose up`, if you have Docker and `docker-compose` installed.

# Tools

We are using `Maven 3.6.3` and `JDK 1.8` to execute the tests for the respective tool.

* [Gradle 5.6](https://gradle.org/releases/)
* [Maven 3.6.3](http://maven.apache.org/download.cgi)
* [NuGet 3.4.4](https://www.nuget.org/packages/NuGet.CommandLine/3.4.4-rtm-final)
* [NPM (NodeJS 12](https://nodejs.org/en/download/releases/)
* [Pip 19.3](https://pypi.org/project/pip/)
* [SBT 1.1.0](https://www.scala-sbt.org/download.html)
