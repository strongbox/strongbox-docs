# Maven Layout Provider

## Introduction

Our support for Maven is handled via the Maven 2 Layout provider.
The code is located under the [strongbox-storage-maven-layout-provider] module.
  
We support Maven versions 2.x and higher.  
We do not support Maven versions 1.x, nor have virtual repositories that can do this conversion.

## What does "Maven 2" actually refer to?

This layout provider supports Maven versions 2.x and higher. Collectively, these versions are referred to as "Maven 2.0",
so that there could be a distinction between the early days Maven -- 1.x, which reached an [end of life in June 2007] 
and was re-written from scratch and replaced by Maven 2.x.  
  
One of the main difference between Maven 1.x and 2.x is that Maven dropped the Ant-style (Jelly) declaration of tasks 
to be executed in favour of proper Maven plugins written in Java.  
  
Our implementation of the Maven 2 layout provider does not support Maven 1.x versions, since they have long reached 
an end-of-life.

## Artifact Coordinates

This is the list of artifact coordinates supported by the provider:

| Coordinate   | Description | Type |
|:-------------|:------------|:-----|
| `groupId`    | The group (package name) of the package | Mandatory |
| `artifactId` | The name of the package | Mandatory |
| `version`    | The version of the package | Mandatory |
| `extension`  | The extension of the package | Optional; defaults to `jar` |
| `classifier` | The classifier of the package | Optional |

## User Agent

The accepted `User-Agent` headers supported must look like `User-Agent=Maven/*`.

## Custom Features

This layout provider also indexes the artifacts using the Lucene-based [Maven Indexer] as explained below.

## Maven 2 Search Providers

The Maven 2 layout provider uses the [OrientDB (default)](../search-providers#orientdbsearchprovider).

## Classes of Interest

The following are some of the more important classes you will need to be familiar with in order to work on this layout provider:

| Coordinate   | Description |
|:-------------|:------------|
| [MavenArtifactCoordinates] | This is an implementation of `ArtifactCoordinates` for Maven. |
| [Maven2LayoutProvider]| This is the actual implementation of the Maven 2 layout provider. |
| [MavenRepositoryFeatures]| This defines the custom layout provider features for Maven 2 (like the [Maven Indexer]). |
| [MavenRepositoryManagementStrategy] | This class is used to handle the initialization of Maven 2 repositories. |
| [ArtifactIndexesServiceImpl] | This service class is used to manage [Maven Indexer]-related tasks. |
| [MavenIndexerSearchProvider] | This is an implementation of the [Maven Indexer] [search provider]. |
| [ArtifactMetadataServiceImpl] | This service is used to manage [Maven Metadata]. |
| [MavenArtifactController] | This is the Maven 2-specific implementation of the `BaseArtifactController`. |

## See Also
* [Maven Indexer]
* [Maven Metadata]
* [Writing a layout provider]
* ["Hello, Strongbox!" Example Using Maven](https://github.com/strongbox/strongbox-examples/tree/master/hello-strongbox-maven) 


[end of life in June 2007]: https://maven.apache.org/maven-1.x-eol.html
[Writing a layout provider]: ./how-to-implement-your-own-repository-format.md
[strongbox-storage-maven-layout-provider]: https://github.com/strongbox/strongbox/tree/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-maven-layout/strongbox-storage-maven-layout-provider
[MavenArtifactCoordinates]: https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-maven-layout/strongbox-storage-maven-layout-provider/src/main/java/org/carlspring/strongbox/artifact/coordinates/MavenArtifactCoordinates.java
[Maven2LayoutProvider]: https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-maven-layout/strongbox-storage-maven-layout-provider/src/main/java/org/carlspring/strongbox/providers/layout/Maven2LayoutProvider.java
[MavenRepositoryFeatures]: https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-maven-layout/strongbox-storage-maven-layout-provider/src/main/java/org/carlspring/strongbox/repository/MavenRepositoryFeatures.java
[MavenRepositoryManagementStrategy]: https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-maven-layout/strongbox-storage-maven-layout-provider/src/main/java/org/carlspring/strongbox/repository/MavenRepositoryManagementStrategy.java
[ArtifactIndexesServiceImpl]: https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-maven-layout/strongbox-storage-maven-layout-provider/src/main/java/org/carlspring/strongbox/services/impl/ArtifactIndexesServiceImpl.java
[MavenIndexerSearchProvider]: https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-maven-layout/strongbox-storage-maven-layout-provider/src/main/java/org/carlspring/strongbox/providers/search/MavenIndexerSearchProvider.java
[ArtifactMetadataServiceImpl]: https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-maven-layout/strongbox-storage-maven-layout-provider/src/main/java/org/carlspring/strongbox/services/impl/ArtifactMetadataServiceImpl.java
[MavenArtifactController]: https://github.com/strongbox/strongbox/blob/e8beb1f7b97483355f55045c8947decdc1b1c26b/strongbox-web-core/src/main/java/org/carlspring/strongbox/controllers/layout/maven/MavenArtifactController.java
[Maven Metadata]: ../metadata/maven-metadata.md
[Maven Indexer]: ../maven-indexer.md
[search provider]: ../search-providers.md
