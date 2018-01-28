# General
We like our dog food and we try it all the time! :)

There will be many cases where you need to test things against either a full-blown Strongbox, or the `strongbox-web-core`. The following article shows you how to do so.

# Pre-requisites

You will need to use the following Maven `settings.xml` file:

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

This `settings.xml` file will ensure that all required artifacts, plugins and extensions are resolved via Strongbox. In addition, it will override Maven Central as a fallback repository, so everything required will indeed be resolved through `http://localhost:48080/storages/public/public-group/` which is a group repository that includes all the hosted repositories in Strongbox, as well as all defined proxy repositories.

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
[INFO] Strongbox: Data Service ............................ SUCCESS [01:48 min]
[INFO] Strongbox: Commons ................................. SUCCESS [ 51.775 s]
[INFO] Strongbox: Configuration ........................... SUCCESS [  4.934 s]
[INFO] Strongbox: Metadata [Maven API] .................... SUCCESS [ 10.933 s]
[INFO] Strongbox: Event API ............................... SUCCESS [  4.988 s]
[INFO] Strongbox: Authentication API ...................... SUCCESS [  4.741 s]
[INFO] Strongbox: Client .................................. SUCCESS [  8.716 s]
[INFO] Strongbox: Testing [Core] .......................... SUCCESS [ 16.140 s]
[INFO] Strongbox: Security API ............................ SUCCESS [ 44.736 s]
[INFO] Strongbox: User Management ......................... SUCCESS [  7.977 s]
[INFO] Strongbox: Authentication Provider [Default] ....... SUCCESS [  4.807 s]
[INFO] Strongbox: Authentication Support .................. SUCCESS [  6.141 s]
[INFO] Strongbox: Authentication Provider [LDAP] .......... SUCCESS [ 29.332 s]
[INFO] Strongbox: Authentication Providers ................ SUCCESS [  1.791 s]
[INFO] Strongbox: Authentication Registry ................. SUCCESS [ 11.226 s]
[INFO] Strongbox: Security ................................ SUCCESS [  1.786 s]
[INFO] Strongbox: Storage [Core] .......................... SUCCESS [ 23.480 s]
[INFO] Strongbox: Testing [Storage] ....................... SUCCESS [  4.830 s]
[INFO] Strongbox: Storage [API] ........................... SUCCESS [ 14.594 s]
[INFO] Strongbox: Cron [API] .............................. SUCCESS [ 28.265 s]
[INFO] Strongbox: Cron [Tasks] ............................ SUCCESS [  8.158 s]
[INFO] Strongbox: REST Client ............................. SUCCESS [  8.867 s]
[INFO] Strongbox: Storage [Maven Layout Provider] ......... SUCCESS [  7.605 s]
[INFO] Strongbox: Storage [Nuget Layout Provider] ......... SUCCESS [ 11.199 s]
[INFO] Strongbox: Testing [Web] ........................... SUCCESS [  6.022 s]
[INFO] Strongbox: Testing ................................. SUCCESS [  2.093 s]
[INFO] Strongbox: Storage [NPM Layout Provider] ........... SUCCESS [01:59 min]
[INFO] Strongbox: Storage [Raw Layout Provider] ........... SUCCESS [  6.072 s]
[INFO] Strongbox: Storage [P2 Layout Provider] ............ SUCCESS [  6.011 s]
[INFO] Strongbox: Web Core ................................ SUCCESS [ 21.675 s]
[INFO] Strongbox: Cron [REST] ............................. SUCCESS [  6.175 s]
[INFO] Strongbox: Cron .................................... SUCCESS [  1.781 s]
[INFO] Strongbox: Storage Layout Providers ................ SUCCESS [  1.831 s]
[INFO] Strongbox: Storage ................................. SUCCESS [  1.801 s]
[INFO] Strongbox: Masterbuild ............................. SUCCESS [  1.795 s]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 13:37 min
[INFO] Finished at: 2018-01-28T06:04:10+00:00
[INFO] Final Memory: 125M/1133M
[INFO] ------------------------------------------------------------------------
```


# Building Strongbox Against Strongbox
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
[INFO] Strongbox: Data Service ............................ SUCCESS [01:48 min]
[INFO] Strongbox: Commons ................................. SUCCESS [ 51.775 s]
[INFO] Strongbox: Configuration ........................... SUCCESS [  4.934 s]
[INFO] Strongbox: Metadata [Maven API] .................... SUCCESS [ 10.933 s]
[INFO] Strongbox: Event API ............................... SUCCESS [  4.988 s]
[INFO] Strongbox: Authentication API ...................... SUCCESS [  4.741 s]
[INFO] Strongbox: Client .................................. SUCCESS [  8.716 s]
[INFO] Strongbox: Testing [Core] .......................... SUCCESS [ 16.140 s]
[INFO] Strongbox: Security API ............................ SUCCESS [ 44.736 s]
[INFO] Strongbox: User Management ......................... SUCCESS [  7.977 s]
[INFO] Strongbox: Authentication Provider [Default] ....... SUCCESS [  4.807 s]
[INFO] Strongbox: Authentication Support .................. SUCCESS [  6.141 s]
[INFO] Strongbox: Authentication Provider [LDAP] .......... SUCCESS [ 29.332 s]
[INFO] Strongbox: Authentication Providers ................ SUCCESS [  1.791 s]
[INFO] Strongbox: Authentication Registry ................. SUCCESS [ 11.226 s]
[INFO] Strongbox: Security ................................ SUCCESS [  1.786 s]
[INFO] Strongbox: Storage [Core] .......................... SUCCESS [ 23.480 s]
[INFO] Strongbox: Testing [Storage] ....................... SUCCESS [  4.830 s]
[INFO] Strongbox: Storage [API] ........................... SUCCESS [ 14.594 s]
[INFO] Strongbox: Cron [API] .............................. SUCCESS [ 28.265 s]
[INFO] Strongbox: Cron [Tasks] ............................ SUCCESS [  8.158 s]
[INFO] Strongbox: REST Client ............................. SUCCESS [  8.867 s]
[INFO] Strongbox: Storage [Maven Layout Provider] ......... SUCCESS [  7.605 s]
[INFO] Strongbox: Storage [Nuget Layout Provider] ......... SUCCESS [ 11.199 s]
[INFO] Strongbox: Testing [Web] ........................... SUCCESS [  6.022 s]
[INFO] Strongbox: Testing ................................. SUCCESS [  2.093 s]
[INFO] Strongbox: Storage [NPM Layout Provider] ........... SUCCESS [01:59 min]
[INFO] Strongbox: Storage [Raw Layout Provider] ........... SUCCESS [  6.072 s]
[INFO] Strongbox: Storage [P2 Layout Provider] ............ SUCCESS [  6.011 s]
[INFO] Strongbox: Web Core ................................ SUCCESS [ 21.675 s]
[INFO] Strongbox: Cron [REST] ............................. SUCCESS [  6.175 s]
[INFO] Strongbox: Cron .................................... SUCCESS [  1.781 s]
[INFO] Strongbox: Storage Layout Providers ................ SUCCESS [  1.831 s]
[INFO] Strongbox: Storage ................................. SUCCESS [  1.801 s]
[INFO] Strongbox: Masterbuild ............................. SUCCESS [  1.795 s]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 13:37 min
[INFO] Finished at: 2018-01-28T06:04:10+00:00
[INFO] Final Memory: 125M/1133M
[INFO] ------------------------------------------------------------------------
```

