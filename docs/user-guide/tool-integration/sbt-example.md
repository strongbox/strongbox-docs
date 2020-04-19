# SBT

This is an example of how to use SBT with the Strongbox artifact repository manager.

## Pre-requisites

* [Installed and configured a Strongbox Distribution](../getting-started.md)
* Java Development Kit (JDK) version 1.8.x
* [SBT](https://www.scala-sbt.org/) version 1.3 or higher

## Example project

The "Hello, World!" sample application for this can be found [here][hello-strongbox-sbt].

## Configuration

### The `build.sbt` file

This file is used to define your project's information about things like your dependencies, which repositories to use to resolve and deploy artifacts, which plugins to use, etc.The [Strongbox SBT Example] contains sample [build.sbt] file with pre-defined configuration.

The key things that each project needs to have are:

* `organization` - a logical prefix where other similar projects reside.
* `name` - the artifact's name.
* `version` - the version of the artifact.
* `publishMavenStyle := true` - used to specify that the remote repository's layout format is Maven-based.
* `credentials` - defines your credentials for the remote repositories.
* `resolvers` - defines where to resolve the dependencies from (if this is not specified, or the required artifacts cannot be located in the remote, SBT will attempt to resolve it from it's built-in default list of remotes).
* `publishTo` - defines where to deploy the artifact(s) produced by this build to.

### The `repositories` file

This file lists the remote repositories (and their layouts) to use when resolving artifacts.

It is perhaps most-practical and portable to include the [repositories] file as part of your project.

For more details check the ["See also"] section below.

### The credentials

These are plain-text. One way to do it is by specifying these as system properties such as `-Dstrongbox.username=maven 
-Dstrongbox.password=password` and reading them in from the `build.sbt` script.

For more details check the ["See also"] section below.

## How to deploy

Execute the following command to build and deploy into Strongbox:

    sbt compile publish

??? info "Example output"

    ```
    carlspring@linux-70e2:/home/carlspring/strongbox-examples/hello-strongbox-sbt> sbt
    [info] Set current project to hello-strongbox-sbt (in build file:/home/carlspring/strongbox-examples/hello-strongbox-sbt/)
    > compile
    [success] Total time: 0 s, completed Apr 30, 2016 4:54:22 AM
    > run
    [info] Running Main 
    Hello, Strongbox!
    [success] Total time: 0 s, completed Apr 30, 2016 4:54:23 AM
    > publish
    [info] Wrote /home/carlspring/strongbox-examples/hello-strongbox-sbt/target/scala-2.10/hello-strongbox-sbt_2.10-1.0-SNAPSHOT.pom
    [info] :: delivering :: org.carlspring.strongbox.examples#hello-strongbox-sbt_2.10;1.0-SNAPSHOT :: 1.0-SNAPSHOT :: integration :: Sat Apr 30 04:54:30 BST 2016
    [info] 	delivering ivy file to /home/carlspring/strongbox-examples/hello-strongbox-sbt/target/scala-2.10/ivy-1.0-SNAPSHOT.xml
    [info] 	published hello-strongbox-sbt_2.10 to http://localhost:48080/storages/storage0/snapshots/org/carlspring/strongbox/examples/hello-strongbox-sbt_2.10/1.0-SNAPSHOT/hello-strongbox-sbt_2.10-1.0-SNAPSHOT.pom
    [info] 	published hello-strongbox-sbt_2.10 to http://localhost:48080/storages/storage0/snapshots/org/carlspring/strongbox/examples/hello-strongbox-sbt_2.10/1.0-SNAPSHOT/hello-strongbox-sbt_2.10-1.0-SNAPSHOT.jar
    [info] 	published hello-strongbox-sbt_2.10 to http://localhost:48080/storages/storage0/snapshots/org/carlspring/strongbox/examples/hello-strongbox-sbt_2.10/1.0-SNAPSHOT/hello-strongbox-sbt_2.10-1.0-SNAPSHOT-sources.jar
    [info] 	published hello-strongbox-sbt_2.10 to http://localhost:48080/storages/storage0/snapshots/org/carlspring/strongbox/examples/hello-strongbox-sbt_2.10/1.0-SNAPSHOT/hello-strongbox-sbt_2.10-1.0-SNAPSHOT-javadoc.jar
    [success] Total time: 2 s, completed Apr 30, 2016 4:54:30 AM
    ```

# See also

* [SBT: Publishing](http://www.scala-sbt.org/0.13/docs/Publishing.html)
* [SBT: Repositories](http://www.scala-sbt.org/0.13/docs/Proxy-Repositories.html)
* [SBT: Metadata](http://www.scala-sbt.org/0.13/docs/Howto-Project-Metadata.html)

[Strongbox SBT Example]: https://github.com/strongbox/strongbox-examples/tree/master/hello-strongbox-sbt
[build.sbt]: https://github.com/strongbox/strongbox-examples/blob/master/hello-strongbox-sbt/build.sbt
[repositories]: https://github.com/strongbox/strongbox-examples/blob/master/hello-strongbox-sbt/repositories
["See also"]: #see-also
[hello-strongbox-sbt]: https://github.com/strongbox/strongbox-examples/tree/master/hello-strongbox-sbt
