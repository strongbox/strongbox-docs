# Pre-requisites:
You will need to have:
* Maven >= 3.3.9
* Java 1.8
* Please, place this [[settings.xml|resources/maven/settings.xml]] file under your `~/.m2` directory.

# Building
Try building the [Strongbox](https://github.com/strongbox/strongbox) code:

    mvn clean install

If this doesn't work out of the box, then you might have to build and install the following projects first (using `mvn clean install`) in the order they are listed below:
- [unboundid-maven-plugin](https://github.com/carlspring/unboundid-maven-plugin)
- [little-proxy-maven-plugin](https://github.com/carlspring/little-proxy-maven-plugin)
- [orientdb-maven-plugin](https://github.com/carlspring/orientdb-maven-plugin)
- [commons-io](https://github.com/carlspring/commons-io/)
- [commons-http](https://github.com/carlspring/commons-http/)
- [logback-configuration](https://github.com/carlspring/logback-configuration)

# Tests

## Skipping tests

To skip the Maven tests and just build and install the code, run:

    mvn clean install -DskipTests

## Executing a particular test

To execute a particular tests, run:

    mvn clean install -Dtest=MyTest

To execute a test method of a test, run:

    mvn clean install -Dtest=MyTest#testMyMethod

## Executing the tests like they are run in Jenkins

Jenkins runs the tests in invoking a few Maven profiles, so that, for example, random ports can be allocated for the various plugins that open ports (such as the `jetty-maven-plugin`, `little-proxy-maven-plugin`, `orientdb-maven-plugin` and `unboundid-maven-plugin`, for example).

    mvn clean install \
        -Preserve-ports,run-it-tests,!set-default-ports \
        -Dmaven.test.failure.ignore=false

# Jetty

## Running Jetty in blocked mode

Sometimes you may have to run Jetty and manually invoke some manual tests. To do this run:

    cd strongbox-web-core
    mvn clean package -Djetty.block

