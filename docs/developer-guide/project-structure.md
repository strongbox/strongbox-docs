# Project structure

## Modules

### Core Modules

All the core modules are located under the [Strongbox] project. 
Each of these modules has a `README.md` file explaining briefly what kind of code contains. 
New modules should also follow the same format.

This is a brief breakdown of the modules:

* [strongbox-client]/  
    This is where the artifact client resides.
* [strongbox-commons]/  
    This is where the most common code which is across other modules resides.
* [strongbox-event-api]/    
    Contains an event API.
* [strongbox-metadata-core]/  
    This contains the most commonly needed code related to Maven metadata.
* [strongbox-parent]  
    This is the Maven parent which is (and should be) inherited by all modules. It is the right (and only place) 
    to define versions for dependencies and plugins. Versions of dependencies should not be defined in any other 
    `pom.xml` files in order to ease the maintenance of these across the codebase.
* [strongbox-resources]/  
    This is the place where common resources which can be used by multiple projects reside. The idea is not have to duplicate 
    things such as `logback.xml`, `web.xml`, keystores and so on across the other modules. These resources are 
    copied using the `maven-dependency-plugin`.
    * [strongbox-common-resources]/  
        Contains `logback.xml` and keystores.
    * [strongbox-storage-resources]/  
        * [strongbox-storage-api-resources]/  
            Contains the `strongbox.xml` configuration file.
        * [strongbox-web-resources]/  
            Contains the `web.xml`and the Jetty configuration files.
* [strongbox-rest-client]/  
    Contains the REST API client.
* [strongbox-security-api]/  
    Contains various security and encryption related classes.
* [strongbox-storage]/  
    Contains the code for the storage related modules.
    * [strongbox-storage-api]/  
        Contains the most common code for storages (`Storage`, `Repository`, `*LocationResolver`, etc)
    * [strongbox-storage-indexing]/  
        Contains the Lucene indexing code.
    * [strongbox-storage-metadata]/  
        Contains a service wrapper and XML marshalling/unmarshalling for Maven metadata.
* [strongbox-testing]/  
    Contains various very useful base classes for testing
    * [strongbox-testing-core]/  
        Contains code for generation of valid Maven artifacts.
    * [strongbox-testing-web]/  
        Contains a dummy implementation of a Jersey application. Sometimes useful for lightweight tests.
* [strongbox-web-core]/  
    This is the web module which contains all the controllers.
    
### Additional Modules

All the [Strongbox] modules are organized under the [Strongbox organization].

### Creating New Modules/Projects

* Each new modules needs to extend the `strongbox-parent`, from where it should be extending the dependencies and the 
  configuration for Maven plugins. Modules should not contain any artifact or plugin versions.

* All modules need to have a `README.md` file describing in brief what the module is and give brief pointers 
  on what classes and tests are of primary interest.

* Each project in the [Strongbox organization] needs to have a copy of the [LICENSE] file.

---

## Integration Tests

### Web Integration Tests

The web integration tests are located in the [strongbox-web-integration-tests] project. 
They are using the [maven-invoker-plugin] to execute various tests 
against a Strongbox instance which is started for this purpose. These tests start Maven processes via the [maven-invoker-plugin]
and are literally mimicking Maven behaviour. The outcome of the tests is validated using Groovy scripts.

## Packaging Modules

For a much more lightweight build the modules which carry out the actual packaging into assemblies and distributions, 
these have been extracted into separate projects under the organization.

## Strongbox Distribution

The [strongbox-distribution](https://github.com/strongbox/strongbox/tree/master/strongbox-distribution) module produces 
the final binary distributions which are then made public under the [releases](https://github.com/strongbox/strongbox/releases) section.

## See Also
* [Writing Tests](./writing-tests.md)
* [REST API](../user-guide/rest-api.md)

[Strongbox]: https://github.com/strongbox/strongbox
[Strongbox organization]: https://github.com/strongbox
[strongbox-client]: https://github.com/strongbox/strongbox/tree/master/strongbox-client
[strongbox-commons]: https://github.com/strongbox/strongbox/tree/master/strongbox-commons
[strongbox-common-resources]: https://github.com/strongbox/strongbox/tree/master/strongbox-resources/strongbox-common-resources
[strongbox-event-api]: https://github.com/strongbox/strongbox/tree/master/strongbox-event-api
[strongbox-metadata-core]: https://github.com/strongbox/strongbox/tree/master/strongbox-metadata-core 
[strongbox-parent]: https://github.com/strongbox/strongbox-parent/tree/master
[strongbox-resources]: https://github.com/strongbox/strongbox/tree/master/strongbox-resources
[strongbox-rest-client]: https://github.com/strongbox/strongbox/tree/master/strongbox-rest-client
[strongbox-security-api]: https://github.com/strongbox/strongbox/tree/master/strongbox-security-api
[strongbox-storage]: https://github.com/strongbox/strongbox/tree/master/strongbox-storage
[strongbox-storage-api]: https://github.com/strongbox/strongbox/tree/master/strongbox-storage/strongbox-storage-api
[strongbox-storage-api-resources]: https://github.com/strongbox/strongbox/tree/master/strongbox-resources/strongbox-storage-resources/strongbox-storage-api-resources
[strongbox-storage-indexing]: https://github.com/strongbox/strongbox/tree/master/strongbox-storage/strongbox-storage-indexing
[strongbox-storage-metadata]: https://github.com/strongbox/strongbox/tree/master/strongbox-storage/strongbox-storage-metadata
[strongbox-storage-resources]: https://github.com/strongbox/strongbox/tree/master/strongbox-resources/strongbox-storage-resources
[strongbox-testing]: https://github.com/strongbox/strongbox/tree/master/strongbox-testing
[strongbox-testing-core]: https://github.com/strongbox/strongbox/tree/master/strongbox-testing/strongbox-testing-core
[strongbox-testing-web]: https://github.com/strongbox/strongbox/tree/master/strongbox-testing/strongbox-testing-web
[strongbox-web-core]: https://github.com/strongbox/strongbox/tree/master/strongbox-web-core
[strongbox-web-integration-tests]: https://github.com/strongbox/strongbox-web-integration-tests
[strongbox-web-resources]: https://github.com/strongbox/strongbox/tree/master/strongbox-resources/strongbox-web-resources
[LICENSE]: https://github.com/strongbox/strongbox/blob/master/LICENSE

[maven-invoker-plugin]: http://maven.apache.org/plugins/maven-invoker-plugin/
