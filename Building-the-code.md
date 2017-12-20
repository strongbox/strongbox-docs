# Pre-requisites:
You will need to have:
* Maven >= 3.3.9
* Java 1.8
* Please, place this [[settings.xml|resources/maven/settings.xml]] file under your `~/.m2` directory.

# Building
Try building the [Strongbox](https://github.com/strongbox/strongbox) code:

    mvn clean install

If (and only if) this doesn't work out of the box, then you might have to build and install the following projects first (using `mvn clean install`) in the order they are listed below:
- [unboundid-maven-plugin](https://github.com/carlspring/unboundid-maven-plugin)
- [little-proxy-maven-plugin](https://github.com/carlspring/little-proxy-maven-plugin)
- [maven-commons](https://github.com/carlspring/maven-commons/)
- [commons-io](https://github.com/carlspring/commons-io/)
- [commons-http](https://github.com/carlspring/commons-http/)
- [logback-configuration](https://github.com/carlspring/logback-configuration)

## Building and capturing the stdout and stderr to a log file

To build and redirect all the output to a file, run:

    mvn clean install -DskipTests > build.log 2>&1

To build and redirect all the output to a file, and tail the log in real-time, run:

    mvn clean install -DskipTests > build.log 2>&1 | tail -n 500 -f build.log

# Tests

## Skipping tests

To skip the Maven tests and just build and install the code, run:

    mvn clean install -DskipTests

## Executing a particular test

To execute a particular tests, run:

    mvn clean install -Dtest=MyTest

To execute a test method of a test, run:

    mvn clean install -Dtest=MyTest#testMyMethod

## Executing the tests in remote debug mode

To execute the tests in remote debug mode, run:

    mvn clean install \
        -Dmaven.surefire.debug="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=9001 -Xnoagent"

## Executing the tests like they are run in Jenkins

Jenkins runs the tests in invoking a few Maven profiles, so that, for example, random ports can be allocated for the various plugins that open ports (such as the `jetty-maven-plugin`, `little-proxy-maven-plugin`, `orientdb-maven-plugin` and `unboundid-maven-plugin`, for example).

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

# Jetty

## Running Jetty and the tests in remote debug mode

To execute the tests in remote debug mode, run:

    MAVEN_OPTS="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=9001 -Xnoagent" \
    mvn clean install \
        -Dmaven.surefire.debug="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=9001 -Xnoagent"

This will require you to connect with the remote debugger twice - once to the JVM running the `jetty-maven-plugin` and once for the Maven Surefire tests.

## Running Jetty in blocked mode

Sometimes you may have to run Jetty and manually invoke some manual tests. To do this run:

    cd strongbox-web-core
    mvn clean package -Djetty.block

# Keeping Forks in Sync

First, you need to have added the original remote (this is a one time only set up task):

    git remote add strongbox https://github.com/strongbox/strongbox.git

Then in order to sync your fork with the original remote, execute the following:

    git fetch strongbox
    git checkout master		
    git merge strongbox/master

# See Also
* [Git Tips](https://github.com/git-tips/tips)
