# Ant and Ivy

This is an example of how to use the Strongbox artifact repository manager with Ant and Ivy.

## Pre-requisites

* [Installed and configured a Strongbox Distribution](../getting-started.md)
* Java Development Kit (JDK) version 1.8.x
* [Ant](https://ant.apache.org/) version 1.9.14 or higher
* [Ivy](https://ant.apache.org/ivy/)

## Example project

The "Hello, Strongbox!" example project can be found [here][hello-strongbox-ant-ivy].

## Configuration

Ensure you have configured the following environment variables in order to be able to use Ivy with Strongbox:

* Define an `IVY_HOME` variable pointing to the base directory of your Ivy installation.
* Set your `PATH`/`CLASSPATH` variable to include `$IVY_HOME/ivy-${IVY_VERSION}.jar`.

### The `build.xml` file

This is the Ant build script which compiles the code, produces a `jar` artifact and publishes (deploys) it to the Strongbox artifact repository.

### The `ivysettings.xml` file

This is where you define things like:
- `resolvers` : The repositories from which to resolve artifacta
- `publications` : Which artifacts to publish (deploy) to Strongbox

### The `ivy.xml` file

This is where you define:
* Your artifact's coordinates (via the `<info/>` tag)
* Your dependencies (via the `<dependencies/>` tag)

### The `credentials.properties` file

This file should be located under your `~/.ivy` directory and not be part of the project under version control. It contains the credentials for the repository to which you will be deploying.

## How to deploy

Execute the following command to build and deploy into Strongbox:

    ant build deploy

??? info "Example output"

    ```
    carlspring@linux-70e2:/home/carlspring/strongbox-examples/hello-strongbox-ant-ivy> ant publish-snapshot
    Buildfile: /home/carlspring/strongbox-examples/hello-strongbox-ant-ivy/build.xml
    
    clean:
       [delete] Deleting directory /home/carlspring/strongbox-examples/hello-strongbox-ant-ivy/target
    
    init-ivy:
    
    resolve:
    [ivy:resolve] :: Apache Ivy 2.4.0 - 20141213170938 :: http://ant.apache.org/ivy/ ::
    [ivy:resolve] :: loading settings :: file = /home/carlspring/strongbox-examples/hello-strongbox-ant-ivy/ivysettings.xml
    [ivy:resolve] :: resolving dependencies :: org.carlspring.strongbox.examples#hello-strongbox-ant-ivy;working@localhost
    [ivy:resolve] 	confs: [default]
    [ivy:resolve] 	found junit#junit;4.11 in maven-central
    [ivy:resolve] 	found org.hamcrest#hamcrest-core;1.3 in maven-central
    [ivy:resolve] :: resolution report :: resolve 76ms :: artifacts dl 3ms
    	---------------------------------------------------------------------
    	|                  |            modules            ||   artifacts   |
    	|       conf       | number| search|dwnlded|evicted|| number|dwnlded|
    	---------------------------------------------------------------------
    	|      default     |   2   |   0   |   0   |   0   ||   2   |   0   |
    	---------------------------------------------------------------------
    
    compile:
        [mkdir] Created dir: /home/carlspring/strongbox-examples/hello-strongbox-ant-ivy/target/classes
        [javac] /home/carlspring/strongbox-examples/hello-strongbox-ant-ivy/build.xml:26: warning: 'includeantruntime' was not set, defaulting to build.sysclasspath=last; set to false for repeatable builds
        [javac] Compiling 1 source file to /home/carlspring/strongbox-examples/hello-strongbox-ant-ivy/target/classes
    
    jar:
          [jar] Building jar: /home/carlspring/strongbox-examples/hello-strongbox-ant-ivy/target/hello-strongbox-ant-ivy.jar
    
    publish-snapshot:
    [ivy:deliver] :: delivering :: org.carlspring.strongbox.examples#hello-strongbox-ant-ivy;working@localhost :: 1.0-SNAPSHOT :: integration :: Wed May 18 23:16:32 BST 2016
    [ivy:deliver] 	delivering ivy file to /home/carlspring/strongbox-examples/hello-strongbox-ant-ivy/target/ivy.xml
    [ivy:publish] :: publishing :: org.carlspring.strongbox.examples#hello-strongbox-ant-ivy
    [ivy:publish] 	published hello-strongbox-ant-ivy to http://localhost:48080/storages/storage0/snapshots/org/carlspring/strongbox/examples/hello-strongbox-ant-ivy/1.0-SNAPSHOT/hello-strongbox-ant-ivy-1.0-SNAPSHOT.jar
    [ivy:publish] 	published hello-strongbox-ant-ivy to http://localhost:48080/storages/storage0/snapshots/org/carlspring/strongbox/examples/hello-strongbox-ant-ivy/1.0-SNAPSHOT/hello-strongbox-ant-ivy-1.0-SNAPSHOT.pom
         [echo] Deployed version 1.0-SNAPSHOT.

    BUILD SUCCESSFUL
    Total time: 1 second
    ```

## See also
* A [useful link][ivy-useful-link] regarding `pom.xml` file treatment.
* [Ivy: makepom][ivy-makepom] documentation.


[ivy-makepom]: http://ant.apache.org/ivy/history/2.4.0/use/makepom.html
[ivy-useful-link]: https://theholyjava.wordpress.com/2011/01/26/using-ivy-with-pom-xml/
[hello-strongbox-ant-ivy]: https://github.com/strongbox/strongbox-examples/tree/master/hello-strongbox-ant-ivy
