# General

This resource file describes the configuration of the strongbox authenticators.

The property controlling this file is `authentication.providers.xml`. The default location for this resource is `etc/conf/strongbox-authentication-providers.xml`.

The cases in which this file is required are:
* During the very first server launch to provide the initial strongbox authenticators list
 * Upon the first launch, this resource is loaded from the classpath as the default resource.
 * If the `authentication.providers.xml` property has been specified, then the path to that resource will be used instead.

# File structure

See an example at: https://github.com/strongbox/strongbox/blob/master/strongbox-user-management/src/main/resources/etc/conf/strongbox-authentication-providers.xml

As you can see, it's a custom Spring context xml file where two things are important:

* `authenticators` list bean
  * enumerates all fully qualified names of the authenticator classes that your strongbox distribution will support. authenticator classes should be 
  * order matters 
* `<context:component-scan base-package="x.y.z,a.b.c" />` lists all packages that will be scanned, looking for any @Component-annotated classes, and those classes will be registered as Spring bean definitions within the application context

# Reload

https://github.com/strongbox/strongbox/wiki/REST-API