# General

This resource file describes the configuration of the strongbox authenticators which are a flexible way to configure authentication providers for strongbox distribution.

The property controlling this file is `authentication.providers.xml`. The default location for this resource is `etc/conf/strongbox-authentication-providers.xml`.

The cases in which this file is required are:
* During the very first server launch to provide the initial strongbox authenticators list
  * Upon the first launch, this resource is loaded from the `etc/conf/strongbox-authentication-providers.xml` location as the default resource.
  * If the `authentication.providers.xml` property has been specified, then the path to that resource will be used instead.
* During reload strongbox authenticators request
  * REST API allows to reload the initial configuration
     * Reload allows to completely change the authenticators hierarchy and authentication options

# File structure

See an example [here](https://github.com/strongbox/strongbox/blob/master/strongbox-user-management/src/main/resources/etc/conf/strongbox-authentication-providers.xml)

This is a custom Spring context XML file where the following things are important:

* `authenticators` list bean
  * enumerates all fully qualified names of the authenticator classes that your strongbox distribution will support
  * authenticator classes should be `@Component`-annotated classes
  * authenticator classes should be listed in an expected order
    * if an authenticator listed higher in the list cannot authenticate you, the next one in the list should attempt to do so and so on, until the last one either succeeds, or fails
* `<context:component-scan base-package="x.y.z,a.b.c" />` lists all packages that will be scanned, looking for any `@Component`-annotated classes, and those classes will be registered as Spring bean definitions within the application context
  * every authenticator package listed in the `authenticators` list bean should be placed in `base-package` attribute for `@Component`-scanning

# What you can do using this file

* you can decide which authenticators will take a part in authenticating users
* you can use officially supported authenticators 
* you can register your own authenticator here
* you can move authenticators up or down in the authentication chain

# See Also

* [[How To Implement A Custom Authenticator]]
* [[REST API]]
