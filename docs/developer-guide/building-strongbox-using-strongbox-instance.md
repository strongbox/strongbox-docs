{% set localSettingsXml = "~/.m2/settings-local.xml" %}

# Building Strongbox using a Strongbox Instance

We like our dog food and we try it all the time! :smiley:

Working on Strongbox features is fun, but has a hidden issue - you can unintentionally break things.
Even though we try to have our code covered with lots of test cases - a moment comes when you need to test things manually to make sure your changes are not affecting other features or performance. Doing a build of @strongbox/strongbox using a Strongbox instance is as "real world" environment as it can get and this article goes into details how to do the testing.

## Starting a Strongbox Instance

Before you start testing, you will need to have a running Strongbox instance. 

You can start Strongbox in two ways - via `spring-boot` and from `strongbox-distribution`. In most cases, during the 
development phase you will mainly start an instance via `spring-boot`. However once you are done with your task you 
should always ensure the `strongbox-distribution` package works as expected. 

``` linenums="1" tab="Strongbox via spring-boot"
git clone {{repo_url}}
mvn clean install -DskipTests
cd strongbox-web-core
mvn spring-boot:run
```

``` linenums="1" tab="Strongbox from strongbox-distribution"
git clone {{repo_url}}
mvn clean install -DskipTests
cd strongbox-distribution/target
tar -zxf *gz
cd strongbox-distribution-*/strongbox-*/
./bin/strongbox console
```

## Building and Deploying using Strongbox

Following the steps below should result in successful result:

1. [Did you pay attention?][Strongbox Instance]
2. Configure your `settings.xml` to point to the local [Strongbox Instance]:

    ``` tab="Download"
    # Linux / MacOS
    curl -o {{localSettingsXml}} \ 
            {{resources}}/maven/settings-local.xml
       
    # Windows
    curl -o %HOMEPATH%\.m2\settings-local.xml ^
            {{resources}}/maven/settings-local.xml
    ``` 

    ``` tab="Raw/Copy" 
    --8<-- "{{resourcesPath}}/maven/settings-local.xml"
    ``` 

3. Make a clean clone of @strongbox/strongbox into a separate path (i.e. `strongbox-tmp`)
4. Build Strongbox using a Strongbox instance:
```
$ cd strongbox-tmp
$ mvn clean install -DskipTests -s {{localSettingsXml}}
... (should start downloading artifacts from localhost:48080
[INFO] Scanning for projects...
Downloading from strongbox: http://localhost:48080/storages/public/maven-group/org/carlspring/strongbox/strongbox-parent/1.0-SNAPSHOT/maven-metadata.xml
Downloaded from strongbox: http://localhost:48080/storages/public/maven-group/org/carlspring/strongbox/strongbox-parent/1.0-SNAPSHOT/maven-metadata.xml (617 B at 1.7 kB/s)
...
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
```

5. Deploy into Strongbox
```
$ mvn clean deploy \
    -s {{localSettingsXml}}
    -DaltDeploymentRepository=snapshots::default::http://localhost:48080/storages/storage0/snapshots/ \
    -DskipTests \
    -fn 

...
[INFO] --- maven-install-plugin:2.4:install (default-install) @ strongbox-masterbuild ---
[INFO] Installing /java/strongbox-tmp/pom.xml to /java/strongbox-tmp/.m2/repository-strongbox-local/org/carlspring/strongbox/strongbox-masterbuild/1.0-SNAPSHOT/strongbox-masterbuild-1.0-SNAPSHOT.pom
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
...
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
```

<!-- links -->
[Strongbox Instance]: #starting-a-strongbox-instance
