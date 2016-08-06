
# Repository Providers

Repository providers provide implementations for the different types of repositories. These are:
* [Hosted](Repositories#hosted)
* [Proxy](Repositories#proxy)
* [Group](Repositories#group)
* [Virtual](Repositories#virtual)

## Implementing a `RepositoryProvider`

* Create a class that extends `AbstractRepositoryProvider` and implement the required methods of the `RepositoryProvider`.
* Register the class with the `RepositoryProviderRegistry` by implementing the `register()` method.

## The `RepositoryProviderRegistry`

All implementations of the `RepositoryProvider` need to be registered with the `RepositoryProviderRegistry`. This registry provides a way to list and resolve the available implementations.

# Repository Layouts

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

All implementations of the `StorageProviderRegistry` need to be registered with the `StorageProviderRegistry`. This registry provides a way to list and resolve the available implementations. The `StorageProviderRegistry` is used by the following classes:
* `ArtifactResolutionServiceImpl` - for resolving artifacts
* `ArtifactManagementServiceImpl` - for managing artifacts
