# General

This resource file describes the configuration of the server.

The property controlling this file is `repository.config.xml`. The default location for this resource is `etc/conf/strongbox.xml`.

The cases in which this file is required are:
* During the very first server launch when there is no data in the database
 * Upon the first launch, this resource is loaded from the classpath as the default resource.
 * If the `repository.config.xml` property has been specified, then the path to that resource will be used instead.
* For a configuration import from another server
* For a configuration export of the server

# Information for Developers

The following classes are related to various aspects of the configuration:

| Class Name  | Description | 
|:------------|-------------|
| [`org.carlspring.strongbox.configuration.Configuration`](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-api/src/main/java/org/carlspring/strongbox/configuration/Configuration.java) | Represents to configuration in a serializable form. |
| [`org.carlspring.strongbox.configuration.ConfigurationManager`](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-api/src/main/java/org/carlspring/strongbox/configuration/ConfigurationManager.java) | Utility class for handling serialization and deserialization in XML form. | 
| [`org.carlspring.strongbox.configuration.ConfigurationRepository`](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-api/src/main/java/org/carlspring/strongbox/configuration/ConfigurationRepository.java) | Repository class for handling CRUD operations against OrientDB. |
