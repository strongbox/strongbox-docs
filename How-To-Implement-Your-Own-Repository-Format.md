
# Overview

The following is a simplified illustration of how things are implemented:

[ ![Strongbox Repository, Layout and Storage Provider Implementation](https://github.com/strongbox/strongbox/wiki/resources%2Fimages%2FStrongbox%20Repository%2C%20Layout%20and%20Storage%20Provider%20Implementation.png) ](https://github.com/strongbox/strongbox/wiki/resources%2Fimages%2FStrongbox%20Repository%2C%20Layout%20and%20Storage%20Provider%20Implementation.png)


# Concept overview

The illustration below is a top level overview of how artifact management is implemented in Strongbox within different [[Storages]], [[Repositories]] and [[Layout providers]]:

[![Strongbox Repository, Layout and Storage Provider Implementation](https://github.com/strongbox/strongbox/wiki/resources/images/layout/Strongbox%20Repository%20Layout%20-%20Concept.png)](https://github.com/strongbox/strongbox/wiki/resources/images/layout/Strongbox%20Repository%20Layout%20-%20Concept.png)

The main thing here is that Strongbox has three layers and each layer decorates the underlying layer with logic that it's responsible for.

# Implementation

We can say that artifacts are just regular files, so our implementation is mainly based on the common JDK File I/O (Featuring NIO.2) entities. 

This is how it looks like:

[![Strongbox Repository, Layout and Storage Provider Entities](https://github.com/strongbox/strongbox/wiki/resources/images/layout/Strongbox%20Repository%20Layout%20-%20Classes.png)](https://github.com/strongbox/strongbox/wiki/resources/images/layout/Strongbox%20Repository%20Layout%20-%20Classes.png)

# Repository Providers

Repository providers provide implementations for the different types of repositories. These are:
* [Hosted](Repositories#hosted)
* [Proxy](Repositories#proxy)
* [Group](Repositories#group)
* [Virtual](Repositories#virtual)

## Implementing a `RepositoryProvider`

* Create a class that extends `AbstractRepositoryProvider` and implement the required methods of the `RepositoryProvider`.
* Register the class with the `RepositoryProviderRegistry` by implementing the `register()` method.

### Notes

* `RepositoryProvider` implementations have `getInputStream` and `getOutputStream` methods which normally delegate to the associated layout provider. However, in certain cases such as the `GroupRepoisotryProvider` and `ProxyRepositoryProvider` classes, these methods are overridden completely.

## The `RepositoryProviderRegistry`

All implementations of the `RepositoryProvider` need to be registered with the `RepositoryProviderRegistry`. This registry provides a way to list and resolve the available implementations.

# Repository Layout Providers

## Implementing a `RepositoryLayoutProvider`

* Create a class that extends `AbstractRepositoryLayoutProvider` and implement the required methods of the `RepositoryLayoutProvider`.
* Register the class with the `RepositoryLayoutProviderRegistry` by implementing the `register()` method.

## The `LayoutRegistryProvider`

All implementations of the `LayoutRegistryProvider` need to be registered with the `LayoutProviderRegistry`. This registry provides a way to list and resolve the available implementations.

# Storage Providers

## Implementing a `StorageProvider`

The purpose of storage providers is to expose methods for the underlying storage system. Such storage systems could, for example, be:
* The file system
* A blob store (database, Hadoop, etc.)
* [Amazon S3](http://docs.aws.amazon.com/AmazonS3/latest/dev/Welcome.html)
* [Google Cloud Storage](https://cloud.google.com/storage/)

## Implementation

* Create a class that extends `AbstractStorageProvider` and implement the required methods of the `StorageProvider`.
* Register the class with the `StorageProviderRegistry` by implementing the `register()` method.

### Notes

* Do not create instances of `File`-s in repository/artifact-related code outside the `StorageProvider` implementation. Use the appropriate `getFileImplementation` method for this instead. 
* Do not create instances of `FileInputStream`-s in repository/artifact-related code outside the `StorageProvider` implementation. Use the appropriate `getInputStreamImplementation` method for this instead. 

## The `StorageProviderRegistry`

All implementations of the `StorageProvider` need to be registered with the `StorageProviderRegistry`. This registry provides a way to list and resolve the available implementations. The `StorageProviderRegistry` is used by the following classes:
* `ArtifactResolutionServiceImpl` - for resolving artifacts
* `ArtifactManagementServiceImpl` - for managing artifacts

# Artifact Coordinates

Each layout provider implementation needs to have it's own implementation of the [[artifact coordinates]].

These are the minimal requirements that each layout provider needs to meet: 
- Every **ArtifactCoordinates** implementation should have **Id** and **Version**
- **Id**:**Version** pair should be unique per repository
- There should be a transitive function to get **ArtifactCoordinates** from **Path** and vice versa

