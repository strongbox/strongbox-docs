# Concept
The goal of probably every Concept is to provide a flexible rails for all possible cases within subject area you have. We tried to build such "rails" in Strongbox to make development process nice and painless. :)

The illustration below is a top level overview of how artifact management is implemented in Strongbox within different [[Storages]], [[Repositories]] and [[Layout Providers]]:

[![Strongbox Repository, Layout and Storage Provider Implementation](https://github.com/strongbox/strongbox/wiki/resources/images/layout/Strongbox%20Repository%20Layout%20-%20Concept.png)](https://github.com/strongbox/strongbox/wiki/resources/images/layout/Strongbox%20Repository%20Layout%20-%20Concept.png)

The main thing here is that Strongbox has three layers and each layer decorates the underlying layer with logic that it's responsible for.

Following layer implementations possible:

| Repository                      | Layout | Storage      |
| --------------------------------|:------:| ------------:|
| [Hosted](Repositories#hosted)   | Maven  | File System  |
| [Proxy](Repositories#proxy)     | Nuget  | AWS          |
| [Group](Repositories#group)     | Npm    | Google Cloud |
| [Virtual](Repositories#virtual) | Raw    | Azure        |

All the layers are loosely coupled so implementations do not depends on each other. With **Decorator Pattern** concept you can have any layer implementation combinations you want: `Hosted`+`Maven`+`File System`, `Group`+`Npm`+`AWS` etc. 

# Layout Implementation

We can say that artifacts are just regular files, so our implementation is mainly based on the common [JDK File I/O (Featuring NIO.2)](https://docs.oracle.com/javase/tutorial/essential/io/fileio.html) entities. 

This is how it looks like:

[![Strongbox Repository, Layout and Storage Provider Entities](https://github.com/strongbox/strongbox/wiki/resources/images/layout/Strongbox%20Repository%20Layout%20-%20Classes.png)](https://github.com/strongbox/strongbox/wiki/resources/images/layout/Strongbox%20Repository%20Layout%20-%20Classes.png)

Within this guide you will need to implement following entities:
- `ConcreteLayoutFileSystemProvider`
- `ConcreteLayoutFileSystem`
- `LayoutProvider`
- `ArtifactCoordinates`

## Artifact Coordinates

Each Layout should identify artifacts somehow, and we have [[Artifact Coordinates]] responsible for this in Strongbox. 

These are the minimal requirements for [ArtifactCoordinates](https://github.com/strongbox/strongbox/blob/master/strongbox-commons/src/main/java/org/carlspring/strongbox/artifact/coordinates/ArtifactCoordinates.java) implementation: 
- Every `ArtifactCoordinates` implementation should have `Id` and `Version`
- Every `Id` and `Version` pair should be unique per repository
- There should be a transitive function to get `ArtifactCoordinates` from `Path` and vice-versa

### Notes
* every Layout implementation should be placed in separate module
* there should be Unit Test for `ArtifactCoordinates` implementation
* there should be Layout specific **Artifact Generator** implemented which will be used for test purpose

## Artifact Controller

Once there is Strongbox module with `ArtifactCoorsinates` we can start implementing protocol specific API.
Most of the build and artifact management tools using HTTP to interact with their endpoints and in Strongbox we have [Spring MVC](https://docs.spring.io/spring/docs/current/spring-framework-reference/web.html) responsible for this. There is [BaseArtifactController](https://github.com/strongbox/strongbox/blob/master/strongbox-web-core/src/main/java/org/carlspring/strongbox/controllers/BaseArtifactController.java) which should be extended with protocol specific API methods (download, upload etc.).

### Notes
* there should be REST Assured based Unit Test to check that artifact download/upload handled with `HTTP 200` response code


## Layout specific I/O extension
To make Layout usable for real there should be some Layout specific I/O, such as Streams (`InputStream`, `OutputStream`) and **File System** related entities (`FileSystemProvider`, `FileSystem`, `LayoutProvider`).

Below is the set of base classes which need to be extended:
- `LayoutFileSystem`
- `LayoutFileSystemProvider`
- `AbstractLayoutProvider`

Almost all components in Strongbox managed by Spring IoC container, the same goes for the for Layout related components and there should be following factories to put everything into context:
- `LayoutFileSystemProviderFactory`
- `LayoutFileSystemFactory`

## Put it all together
Strongbox have plugable Layouts, so once you have all extension points impelemted it should work "Out-Of-The-Box".
Below you can see how general flow goes by the artifact download example:

[![Strongbox Repository, Layout and Storage Provider Entities](https://github.com/strongbox/strongbox/wiki/resources/images/layout/Strongbox%20Repository%20Layout%20-%20Flow.png)](https://github.com/strongbox/strongbox/wiki/resources/images/layout/Strongbox%20Repository%20Layout%20-%20Flow.png)