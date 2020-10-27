# Building the code

!!! tip "Before continuing, please make sure you've read the [Getting Started](./getting-started.md) section."

## Building strongbox

Running the commands below should be enough to end with a successful build:

```linenums="1"
git clone https://github.com/strongbox/strongbox
cd strongbox
mvn clean install
```

!!! warning "When you have properly setup your [settings.xml](./getting-started.md) file, you should not need to run any of the steps below."

In case our artifact repository manager is not working (which happens very rarely), you might have to build and install the following projects using `mvn clean install` in the order they are listed below before building Strongbox:

1. [unboundid-maven-plugin](https://github.com/carlspring/unboundid-maven-plugin)

2. [little-proxy-maven-plugin](https://github.com/carlspring/little-proxy-maven-plugin)

3. [maven-commons](https://github.com/carlspring/maven-commons/)

4. [commons-io](https://github.com/carlspring/commons-io/)

5. [commons-http](https://github.com/carlspring/commons-http/)

6. [logback-configuration](https://github.com/carlspring/logback-configuration)

## Tests

### Skipping tests

To skip the Maven tests and just build and install the code, run:

    mvn clean install -DskipTests

### Executing a particular test

To execute a particular tests, run:

    mvn clean install -Dtest=MyTest

To execute a test method of a test, run:


    mvn clean install -Dtest=MyTest#testMyMethod

### Executing the tests in remote debug mode

To execute the tests in remote debug mode, run:

    mvn clean install \
        -Dmaven.surefire.debug="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=9001 -Xnoagent"

### Executing the tests like they are run in Jenkins

Jenkins runs the tests by invoking a few Maven profiles, so that, for example, random ports can be allocated for the
various plugins that open ports (such as the `little-proxy-maven-plugin` and `unboundid-maven-plugin`, for example).

    mvn clean install \
        -Preserve-ports,run-it-tests,!set-default-ports \
        -Dmaven.test.failure.ignore=false

## Common Build problems

### Busy 2424 Port

If you see something like this:

    WARNING Port 0.0.0.0:2424 busy, trying the next available... [OServerNetworkListener]
    SEVERE  Unable to listen for connections using the configured ports '2424-2424' on host '0.0.0.0' [OServerNetworkListener]
    ERROR Failed to execute goal org.apache.maven.plugins:maven-surefire-plugin:2.12.4:test (default-test)

Then please make sure that:

* You don't have any other build already running

* You don't have any other test in progress (e.g. halted by debugger process)

The reason for this failure is that OrientDB can't start, if another OrientDB process is running an listening on the same port.

### Filename too long (Windows 7 and 10)

If you are getting one of these errors:

1.  
    ```
    error: unable to create file strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-maven-layout/strongbox-maven-metadata-api/src/main/java/org/carlspring/strongbox/storage/metadata/comparators/MetadataVersionComparator.java: Filename too long
    ```

2.  

    ```
    package org.carlspring.strongbox.x.y.z does not exist
    ```


Then you are likely hitting a well-known issue with long paths under Windows.
Executing command below should fix the issue:

```
git config --system core.longpaths true
```

At this point, you should be able to `git clone` the project properly under Windows and procceed with the build.

### Windows 10

If some tests on the `master` or other stable branch fail, please consider running terminal as an administrator.

## Spring Boot

### Running Spring Boot

Sometimes you may have to run Jetty and manually invoke some manual tests. To do this run:

    cd strongbox-web-core/
    mvn spring-boot:run

## Keeping Forks in Sync

First, you need to have added the original remote (this is a one time only set up task):

    git remote add strongbox https://github.com/strongbox/strongbox.git

Then in order to sync your fork with the original remote, execute the following:

    git fetch strongbox
    git checkout master
    git merge strongbox/master

## See Also

* [Building Strongbox Against Strongbox](./building-strongbox-using-strongbox-instance.md)

* [Git Tips](https://github.com/git-tips/tips)
