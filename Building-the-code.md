# Pre-requisites:
You will need to have:
* Maven >= 3.3.9
* Java 1.8
* Please, place this [[settings.xml|resources/maven/settings.xml]] file under your `~/.m2` directory.

#Building
Try building the [strongbox](https://github.com/strongbox/strongbox) code:

    mvn clean install

If this doesn't work out of the box, then you might have to build and install the following projects first (using `mvn clean install`):
- [unboundid-maven-plugin](https://github.com/carlspring/unboundid-maven-plugin)
- [little-proxy-maven-plugin](https://github.com/carlspring/little-proxy-maven-plugin)
- [orientdb-maven-plugin](https://github.com/carlspring/orientdb-maven-plugin)
- [logback-configuration](https://github.com/carlspring/logback-configuration)
