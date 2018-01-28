# General
We like our dog food and we try it all the time! :)

There will be many cases where you need to test things against either a full-blown Strongbox, or the `strongbox-web-core`. The following article shows you how to do so.

# Pre-requisites

You will need to use the following Maven settings file (that we've called `settings-strongbox-localhost` and placed under `~/.m2/settings-strongbox-localhost`):

```
<?xml version="1.0" encoding="UTF-8"?>
<settings>

    <mirrors>
        <mirror>
            <id>strongbox</id>
            <name>strongbox</name>
            <url>http://localhost:48080/storages/public/public-group/</url>
            <mirrorOf>*</mirrorOf>
        </mirror>
    </mirrors>

    <profiles>
        <profile>
            <id>carlspring-repositories</id>

            <activation>
                <activeByDefault>true</activeByDefault>
            </activation>

            <repositories>
                <repository>
                    <id>strongbox</id>
                    <name>strongbox</name>
                    <url>http://localhost:48080/storages/public/public-group/</url>
                    <layout>default</layout>
                </repository>
            </repositories>
            <pluginRepositories>
                <pluginRepository>
                    <id>strongbox</id>
                    <name>strongbox</name>
                    <url>http://localhost:48080/storages/public/public-group/</url>
                    <layout>default</layout>
                </pluginRepository>
            </pluginRepositories>
        </profile>
    </profiles>

    <servers>
        <server>
           <id>releases</id>
           <username>admin</username>
           <password>password</password>
        </server>
        <server>
           <id>snapshots</id>
           <username>admin</username>
           <password>password</password>
        </server>
    </servers>
</settings>
```

This settings file will ensure that all required artifacts, plugins and extensions are resolved via the running instance of Strongbox. In addition, it will override Maven Central as a fallback repository, so everything required will indeed be resolved through `http://localhost:48080/storages/public/public-group/` which is a group repository that includes all the hosted repositories in Strongbox, as well as all defined proxy repositories.

# Building Strongbox Against The `strongbox-web-core`

1. Checkout and build the `strongbox` project (either with `mvn clean install`, or `mvn clean install -DskipTests`, based on your needs)
2. In the `strongbox-web-core` module, execute the following in order to start Strongbox inside a Jetty instance waiting for connections:
```
mvn clean package -Pjetty-block
```
3. In a separately checked out `strongbox` project execute:
```
carlspring@carlspring:/java/opensource/carlspring/strongbox-proxy-testing> mvn --settings ~/.m2/settings-strongbox-localhost.xml -Dmaven.repo.local=.m2/repository clean deploy -DaltDeploymentRepository=snapshots::default::http://localhost:48080/storages/storage0/snapshots/ -DskipTests -fn
...
[INFO] --- maven-install-plugin:2.4:install (default-install) @ strongbox-masterbuild ---
[INFO] Installing /java/opensource/carlspring/strongbox-proxy-testing/pom.xml to /java/opensource/carlspring/strongbox-proxy-testing/.m2/repository/org/carlspring/strongbox/strongbox-masterbuild/1.0-SNAPSHOT/strongbox-masterbuild-1.0-SNAPSHOT.pom
[INFO] 
[INFO] --- maven-deploy-plugin:2.7:deploy (default-deploy) @ strongbox-masterbuild ---
[INFO] Using alternate deployment repository snapshots::default::http://localhost:48080/storages/storage0/snapshots/
Downloading: http://localhost:48080/storages/storage0/snapshots/org/carlspring/strongbox/strongbox-masterbuild/1.0-SNAPSHOT/maven-metadata.xml
Uploading: http://localhost:48080/storages/storage0/snapshots/org/carlspring/strongbox/strongbox-masterbuild/1.0-SNAPSHOT/strongbox-masterbuild-1.0-20180128.060409-1.pom
Uploaded: http://localhost:48080/storages/storage0/snapshots/org/carlspring/strongbox/strongbox-masterbuild/1.0-SNAPSHOT/strongbox-masterbuild-1.0-20180128.060409-1.pom (4 KB at 5.6 KB/sec)
Downloading: http://localhost:48080/storages/storage0/snapshots/org/carlspring/strongbox/strongbox-masterbuild/maven-metadata.xml
Uploading: http://localhost:48080/storages/storage0/snapshots/org/carlspring/strongbox/strongbox-masterbuild/1.0-SNAPSHOT/maven-metadata.xml
Uploaded: http://localhost:48080/storages/storage0/snapshots/org/carlspring/strongbox/strongbox-masterbuild/1.0-SNAPSHOT/maven-metadata.xml (618 B at 1.2 KB/sec)
Uploading: http://localhost:48080/storages/storage0/snapshots/org/carlspring/strongbox/strongbox-masterbuild/maven-metadata.xml
Uploaded: http://localhost:48080/storages/storage0/snapshots/org/carlspring/strongbox/strongbox-masterbuild/maven-metadata.xml (303 B at 0.6 KB/sec)
[INFO] ------------------------------------------------------------------------
[INFO] Reactor Summary:
[INFO] 
[INFO] Strongbox: Parent .................................. SUCCESS [01:03 min]
[INFO] Strongbox: Resources [Common] ...................... SUCCESS [01:59 min]
[INFO] Strongbox: Resources [Storage API] ................. SUCCESS [  4.608 s]
[INFO] Strongbox: Resources [Web] ......................... SUCCESS [ 25.098 s]
[INFO] Strongbox: Resources ............................... SUCCESS [  1.816 s]
...
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 13:37 min
[INFO] Finished at: 2018-01-28T06:04:10+00:00
[INFO] Final Memory: 125M/1133M
[INFO] ------------------------------------------------------------------------
```

# Building Strongbox Against Strongbox
1. Build `strongbox` like this:
```
mvn clean install
```
2. Build `strongbox-webapp` like this:
```
mvn clean install
```
3. Build `strongbox-assembly` and start the `strongbox-distribution` like this:
```
carlspring@carlspring:/java/opensource/carlspring/strongbox-assembly> ./build-and-start 
```
4. Build the `strongbox` project against itself like this:
```
carlspring@carlspring:/java/opensource/carlspring/strongbox-proxy-testing> mvn --settings ~/.m2/settings-strongbox-localhost.xml -Dmaven.repo.local=.m2/repository clean deploy -DaltDeploymentRepository=snapshots::default::http://localhost:48080/storages/storage0/snapshots/ -DskipTests -fn
...
[INFO] --- maven-install-plugin:2.4:install (default-install) @ strongbox-masterbuild ---
[INFO] Installing /java/opensource/carlspring/strongbox-proxy-testing/pom.xml to /java/opensource/carlspring/strongbox-proxy-testing/.m2/repository/org/carlspring/strongbox/strongbox-masterbuild/1.0-SNAPSHOT/strongbox-masterbuild-1.0-SNAPSHOT.pom
[INFO] 
[INFO] --- maven-deploy-plugin:2.7:deploy (default-deploy) @ strongbox-masterbuild ---
[INFO] Using alternate deployment repository snapshots::default::http://localhost:48080/storages/storage0/snapshots/
Downloading: http://localhost:48080/storages/storage0/snapshots/org/carlspring/strongbox/strongbox-masterbuild/1.0-SNAPSHOT/maven-metadata.xml
Uploading: http://localhost:48080/storages/storage0/snapshots/org/carlspring/strongbox/strongbox-masterbuild/1.0-SNAPSHOT/strongbox-masterbuild-1.0-20180128.060409-1.pom
Uploaded: http://localhost:48080/storages/storage0/snapshots/org/carlspring/strongbox/strongbox-masterbuild/1.0-SNAPSHOT/strongbox-masterbuild-1.0-20180128.060409-1.pom (4 KB at 5.6 KB/sec)
Downloading: http://localhost:48080/storages/storage0/snapshots/org/carlspring/strongbox/strongbox-masterbuild/maven-metadata.xml
Uploading: http://localhost:48080/storages/storage0/snapshots/org/carlspring/strongbox/strongbox-masterbuild/1.0-SNAPSHOT/maven-metadata.xml
Uploaded: http://localhost:48080/storages/storage0/snapshots/org/carlspring/strongbox/strongbox-masterbuild/1.0-SNAPSHOT/maven-metadata.xml (618 B at 1.2 KB/sec)
Uploading: http://localhost:48080/storages/storage0/snapshots/org/carlspring/strongbox/strongbox-masterbuild/maven-metadata.xml
Uploaded: http://localhost:48080/storages/storage0/snapshots/org/carlspring/strongbox/strongbox-masterbuild/maven-metadata.xml (303 B at 0.6 KB/sec)
[INFO] ------------------------------------------------------------------------
[INFO] Reactor Summary:
[INFO] 
[INFO] Strongbox: Parent .................................. SUCCESS [01:03 min]
[INFO] Strongbox: Resources [Common] ...................... SUCCESS [01:59 min]
[INFO] Strongbox: Resources [Storage API] ................. SUCCESS [  4.608 s]
[INFO] Strongbox: Resources [Web] ......................... SUCCESS [ 25.098 s]
[INFO] Strongbox: Resources ............................... SUCCESS [  1.816 s]
...
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 13:37 min
[INFO] Finished at: 2018-01-28T06:04:10+00:00
[INFO] Final Memory: 125M/1133M
[INFO] ------------------------------------------------------------------------
```
