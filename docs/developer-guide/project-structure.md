# Project structure

## Modules

### Core Modules

All the core modules are located under the [Strongbox] project. Each of these modules has a `README.md` file explaining 
briefly what kind of code contains. New modules should also follow the same format.

This is a brief breakdown of the modules:

* [strongbox-aql]  
    This is where the [Artifact Query Language (AQL)] code is located.
    
* [strongbox-client]     
    This is where the artifact client resides.

* [strongbox-commons]  
    This is where the most common code that is shared across modules resides.

* [strongbox-configuration]    
    Contains configuration parsing related code.

* [strongbox-cron]  

    * [strongbox-cron-api]  
        Contains the Cron API code, that is required by custom cron and controller implementations.

    * [strongbox-cron-tasks]   
        Contains the common built-in cron tasks.

* [strongbox-data-service]  
    Contains the base implementation of data service classes. Check the [Getting Started With Persistence] article for 
    more details.

* [strongbox-distribution]  
    This module produces the final distribution binaries for different platforms. The binaries are then made public 
    under the [releases][sb-gh-releases] section.

* [strongbox-event-api]    
    Contains our [Event API]. 

* [strongbox-resources]  

    * [strongbox-common-resources]    
        This is the place where common resources which can be used by multiple projects reside. The idea is not have to 
        duplicate things such as `logback*xml`, keystores and so on across the other modules. These resources are copied 
        using the `maven-dependency-plugin`.

    * [strongbox-storage-api-resources]    
        Contains the `strongbox.xml` configuration file.

* [strongbox-rest-client]    
    Contains the REST API client.

* [strongbox-security]    

    * [strongbox-authentication-api]    

    * [strongbox-authentication-providers]    

        * [strongbox-default-authentication-provider]    

        * [strongbox-ldap-authentication-provider]    

    * [strongbox-authentication-registry]    

    * [strongbox-authentication-support]  

    * [strongbox-security-api]  
        Contains various security and encryption related classes.

    * [strongbox-user-management]  

* [strongbox-storage]  
    Contains the code for the storage related modules.

    * [strongbox-storage-api]  
        Contains the the storage API.

    * [strongbox-storage-core]  
        Contains the core classes for the storage API.
        
    * [strongbox-storage-layout-providers]  

        * [strongbox-storage-maven-layout]  

            * [strongbox-maven-metadata-api]  
                This is the implementation of the support for the `maven-metadata.xml` format.

            * [strongbox-storage-maven-layout-provider]  
                This is the implementation of the [Maven Layout Provider]. It depends on the [strongbox-maven-metadata-api].

    * [strongbox-storage-npm-layout-provider]  
        This is the implementation of the [NPM layout provider]. It depends on the [strongbox-npm-metadata] project.

    * [strongbox-storage-nuget-layout-provider]  
        This is the implementation of the [Nuget layout provider].
        
    * [strongbox-storage-p2-layout-provider]  
        This is an incomplete early draft implementation of the P2 OSGi layout provider. This module needs a lot more 
        work, before the P2 layout provider could be usable.

    * [strongbox-storage-raw-layout-provider]  
        This is the implementation of the [Raw layout provider].
        
* [strongbox-testing]  
    Contains various very useful base classes for testing.

    * [strongbox-testing-core]  
        Contains common testing-related code.

    * [strongbox-testing-storage]  

    * [strongbox-testing-web]  
        Contains the common `restassured` configuration for controller tests.

* [strongbox-web-core]  
    This is the web module which contains all the controllers.

* [strongbox-web-forms]  
    This is the module that contains all the web forms. You might find the [Writing Web Form Tests] useful.

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

## See Also
* [Writing Tests](./writing-tests.md)
* [REST API](../user-guide/rest-api.md)


[Common links]: #
[maven-invoker-plugin]: http://maven.apache.org/plugins/maven-invoker-plugin/
[Strongbox]: https://github.com/strongbox/strongbox
[Strongbox organization]: https://github.com/strongbox
[LICENSE]: https://github.com/strongbox/strongbox/blob/master/LICENSE
[sb-gh-releases]: https://github.com/strongbox/strongbox/releases

[Internal doc links]: #
[Artifact Query Language (AQL)]: ../user-guide/artifact-query-language.md
[Getting Started With Persistence]: ./getting-started-with-persistence.md
[Event API]: ./using-the-event-api.md
[Maven Layout Provider]: ./layout-providers/maven-2-layout-provider.md
[NPM Layout Provider]: ./layout-providers/npm-layout-provider.md
[Nuget Layout Provider]: ./layout-providers/nuget-layout-provider.md
[Raw layout provider]: ./layout-providers/raw-layout-provider.md
[Writing Web Form Tests]: ./writing-web-form-tests.md

[Project module links]: #
[strongbox-aql]: https://github.com/strongbox/strongbox/tree/master/strongbox-aql
[strongbox-authentication-api]: https://github.com/strongbox/strongbox/tree/master/strongbox-security/strongbox-authentication-api
[strongbox-authentication-providers]: https://github.com/strongbox/strongbox/tree/master/strongbox-security/strongbox-authentication-providers
[strongbox-default-authentication-provider]: https://github.com/strongbox/strongbox/tree/master/strongbox-security/strongbox-authentication-providers/strongbox-default-authentication-provider
[strongbox-ldap-authentication-provider]: https://github.com/strongbox/strongbox/tree/master/strongbox-security/strongbox-authentication-providers/strongbox-ldap-authentication-provider
[strongbox-authentication-registry]: https://github.com/strongbox/strongbox/tree/master/strongbox-security/strongbox-authentication-registry
[strongbox-authentication-support]: https://github.com/strongbox/strongbox/tree/master/strongbox-security/strongbox-authentication-support
[strongbox-client]: https://github.com/strongbox/strongbox/tree/master/strongbox-client
[strongbox-commons]: https://github.com/strongbox/strongbox/tree/master/strongbox-commons
[strongbox-common-resources]: https://github.com/strongbox/strongbox/tree/master/strongbox-resources/strongbox-common-resources
[strongbox-configuration]: https://github.com/strongbox/strongbox/tree/master/strongbox-configuration   
[strongbox-cron]: https://github.com/strongbox/strongbox/tree/master/strongbox-cron
[strongbox-cron-api]: https://github.com/strongbox/strongbox/tree/master/strongbox-cron/strongbox-cron-api
[strongbox-cron-tasks]: https://github.com/strongbox/strongbox/tree/master/strongbox-cron/strongbox-cron-tasks
[strongbox-data-service]: https://github.com/strongbox/strongbox/tree/master/strongbox-data-service  
[strongbox-distribution]: https://github.com/strongbox/strongbox/tree/master/strongbox-distribution
[strongbox-event-api]: https://github.com/strongbox/strongbox/tree/master/strongbox-event-api
[strongbox-metadata-core]: https://github.com/strongbox/strongbox/tree/master/strongbox-metadata-core 
[strongbox-parent]: https://github.com/strongbox/strongbox-parent/tree/master
[strongbox-resources]: https://github.com/strongbox/strongbox/tree/master/strongbox-resources
[strongbox-rest-client]: https://github.com/strongbox/strongbox/tree/master/strongbox-rest-client
[strongbox-security]: https://github.com/strongbox/strongbox/tree/master/strongbox-security
[strongbox-security-api]: https://github.com/strongbox/strongbox/tree/master/strongbox-security/strongbox-security-api
[strongbox-storage]: https://github.com/strongbox/strongbox/tree/master/strongbox-storage
[strongbox-storage-api]: https://github.com/strongbox/strongbox/tree/master/strongbox-storage/strongbox-storage-api
[strongbox-storage-api-resources]: https://github.com/strongbox/strongbox/tree/master/strongbox-resources/strongbox-storage-api-resources
[strongbox-storage-core]: https://github.com/strongbox/strongbox/tree/master/strongbox-storage/strongbox-storage-core
[strongbox-storage-layout-providers]: https://github.com/strongbox/strongbox/tree/master/strongbox-storage/strongbox-storage-layout-providers
[strongbox-storage-maven-layout]: https://github.com/strongbox/strongbox/tree/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-maven-layout
[strongbox-maven-metadata-api]: https://github.com/strongbox/strongbox/tree/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-maven-layout/strongbox-maven-metadata-api
[strongbox-storage-maven-layout-provider]: https://github.com/strongbox/strongbox/tree/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-maven-layout/strongbox-storage-maven-layout-provider
[strongbox-storage-npm-layout-provider]: https://github.com/strongbox/strongbox/tree/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-npm-layout-provider
[strongbox-npm-metadata]: https://github.com/strongbox/strongbox-npm-metadata
[strongbox-storage-nuget-layout-provider]: https://github.com/strongbox/strongbox/tree/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-nuget-layout-provider
[strongbox-storage-p2-layout-provider]: https://github.com/strongbox/strongbox/tree/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-p2-layout-provider
[strongbox-storage-raw-layout-provider]: https://github.com/strongbox/strongbox/tree/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-raw-layout-provider
[strongbox-storage-metadata]: https://github.com/strongbox/strongbox/tree/master/strongbox-storage/strongbox-storage-metadata
[strongbox-storage-resources]: https://github.com/strongbox/strongbox/tree/master/strongbox-resources/strongbox-storage-resources
[strongbox-testing]: https://github.com/strongbox/strongbox/tree/master/strongbox-testing
[strongbox-testing-core]: https://github.com/strongbox/strongbox/tree/master/strongbox-testing/strongbox-testing-core
[strongbox-testing-storage]: https://github.com/strongbox/strongbox/tree/master/strongbox-testing/strongbox-testing-storage
[strongbox-testing-web]: https://github.com/strongbox/strongbox/tree/master/strongbox-testing/strongbox-testing-web
[strongbox-user-management]: https://github.com/strongbox/strongbox/tree/master/strongbox-security/strongbox-user-management
[strongbox-web-core]: https://github.com/strongbox/strongbox/tree/master/strongbox-web-core
[strongbox-web-integration-tests]: https://github.com/strongbox/strongbox-web-integration-tests
[strongbox-web-resources]: https://github.com/strongbox/strongbox/tree/master/strongbox-resources/strongbox-web-resources
[strongbox-web-forms]: https://github.com/strongbox/strongbox/tree/master/strongbox-web-forms
