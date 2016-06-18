
# General

The logging in the application is set up using:
* `logback` (`logback-core`, `logback-classic`)
* `jcl-over-slf4j` (to control Jersey and Spring output)
* [`logback-configuration`](https://github.com/carlspring/logback-configuration)

# Dependencies

## Configuration

If you have `strongbox-commons` as a (direct, or transitive) dependency of your module, you will be able to use the logging, without having to specify the dependencies yourself. If, for one reason, or another, you do not want to have this dependency, you will need the following dependencies instead:

    <!-- Logging -->
    <dependency>
        <groupId>org.slf4j</groupId>
        <artifactId>jcl-over-slf4j</artifactId>
    </dependency>
    <dependency>
        <groupId>org.slf4j</groupId>
        <artifactId>jul-to-slf4j</artifactId>
    </dependency>
    <dependency>
        <groupId>ch.qos.logback</groupId>
        <artifactId>logback-classic</artifactId>
    </dependency>

## Dependency Conflicts

Dependencies which have transitive dependencies on different versions of the libraries below, will most-likely cause dependency conflicts:

* `log4j`
* `commons-logging`
* `commons-logging-api`

In order to exclude them as transitive dependencies, you will need to have something similar to this example:

    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-core</artifactId>
        <version>${version.spring}</version>
        
        <exclusions>
            <!-- Exclude Commons Logging -->
            <exclusion>
                <groupId>commons-logging</groupId>
                <artifactId>commons-logging</artifactId>
            </exclusion>
        </exclusions>
    </dependency>

# Logging Configuration File Location

The logging is controlled via the [`strongbox/strongbox-resources/strongbox-common-resources/src/main/resources/logback.xml`](https://github.com/strongbox/strongbox/blob/master/strongbox-resources/strongbox-common-resources/src/main/resources/logback.xml). This resource should be copied wherever necessary using:

    <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-dependency-plugin</artifactId>
        
        <executions>
            <execution>
                <id>unpack-resources-logging</id>
                <phase>process-resources</phase>
                <goals>
                    <goal>unpack</goal>
                </goals>
                <configuration>
                    <artifactItems>
                        <artifactItem>
                            <groupId>${project.groupId}</groupId>
                            <artifactId>strongbox-common-resources</artifactId>
                            <version>${project.version}</version>
                            <type>jar</type>
                            
                            <overWrite>true</overWrite>
                            <outputDirectory>${dir.strongbox.home}/etc</outputDirectory>
                            <includes>logback.xml</includes>
                        </artifactItem>
                    </artifactItems>
                </configuration>
            </execution>
        </executions>
    </plugin>


# Enabling Low-level Logging For Jersey

In order to enable the low-level debugging for Jersey requests, modify the following logging level of the org.glassfish.jersey package in the logback.xml as shown below:

    <logger name="org.glassfish.jersey">
        <level value="DEBUG"/>
    </logger>

Customized logging configuration (per project) should be avoided, but for debugging purposes, placing a copy of the above under `src/test/resources` would be acceptable.

# Configuring the Logging via The REST API

The logging can be configured via the REST API. We have created a separate project called [`logback-configuration`](https://github.com/carlspring/logback-configuration) for this purpose.

For details on how to configure the logging and resolve the log files via the REST API, please check the [here](http://strongbox.carlspring.org/docs/rest/api.html).
