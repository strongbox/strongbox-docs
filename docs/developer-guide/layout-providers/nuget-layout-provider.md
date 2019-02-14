# NuGet Layout Provider

## Introduction

Our support for NuGet is handled via the Nuget Layout provider.
We currently only support NuGet protocol version 2.0.  
  
The code for the NuGet layout provider is located under the [strongbox-storage-nuget-layout-provider] module.

## Artifact Coordinates

This is the list of artifact coordinates supported by the provider:

| Coordinate | Description | Type |
|:-----------|:------------|:-----|
| `id` | The name of the package | Mandatory |
| `version` | The version of the package | Mandatory |
| `extension` | The extension of the package | Mandatory |

## User Agent

The accepted `User-Agent` headers supported must look like `User-Agent=NuGet/*`.

## Custom Features

This layout provider has feeds.

## NuGet 2 Search Provider

The NuGet layout provider supports uses the [OrientDB (default)](../search-providers#orientdbsearchprovider).

# Supported Commands

Following [CLI commands](https://docs.microsoft.com/ru-ru/nuget/tools/nuget-exe-cli-reference#commands-and-applicability) supported:

- `nuget publish`
- `nuget delete`
- `nuget install`
- `nuget list`

## Classes of Interest

The following are some of the most important classes you will need to be familiar with in order to work on this layout provider:

| Class | Description |
|:-----------|:------------|
| [NugetArtifactCoordinates](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-nuget-layout-provider/src/main/java/org/carlspring/strongbox/artifact/coordinates/NugetArtifactCoordinates.java) | This is an implementation of `ArtifactCoordinates` for NuGet. |
| [NugetLayoutProvider](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-nuget-layout-provider/src/main/java/org/carlspring/strongbox/providers/layout/NugetLayoutProvider.java) | This is the actual implementation of the NuGet layout provider. |
| [NugetRepositoryFeatures](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-nuget-layout-provider/src/main/java/org/carlspring/strongbox/repository/NugetRepositoryFeatures.java) | This defines the custom layout provider features for NuGet (like, for example, feeds). |
| [NugetRepositoryManagementStrategy](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-nuget-layout-provider/src/main/java/org/carlspring/strongbox/repository/NugetRepositoryManagementStrategy.java) | This class is used to handle the initialization of NuGet repositories. |
| [NugetArtifactController](https://github.com/strongbox/strongbox/blob/master/strongbox-web-core/src/main/java/org/carlspring/strongbox/controllers/nuget/NugetArtifactController.java) | This is the NuGet-specific implementation of the `BaseArtifactController`. |

## See Also
* [Writing a layout provider]
* ["Hello, Strongbox!" Example Using NuGet and Mono](https://github.com/strongbox/strongbox-examples/tree/master/hello-strongbox-nuget-mono)
* ["Hello, Strongbox!" Example Using NuGet and Visual Studio](https://github.com/strongbox/strongbox-examples/tree/master/hello-strongbox-nuget-visual-studio)


[Writing a layout provider]: ./how-to-implement-your-own-repository-format.md
[strongbox-storage-nuget-layout-provider]: https://github.com/strongbox/strongbox/tree/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-nuget-layout-provider
[NugetArtifactCoordinates]: https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-nuget-layout-provider/src/main/java/org/carlspring/strongbox/artifact/coordinates/NugetArtifactCoordinates.java
[NugetLayoutProvider]: https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-nuget-layout-provider/src/main/java/org/carlspring/strongbox/providers/layout/NugetLayoutProvider.java
[NugetRepositoryFeatures]: https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-nuget-layout-provider/src/main/java/org/carlspring/strongbox/repository/NugetRepositoryFeatures.java
[NugetRepositoryManagementStrategy]: https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-nuget-layout-provider/src/main/java/org/carlspring/strongbox/repository/NugetRepositoryManagementStrategy.java
[NugetArtifactController]: https://github.com/strongbox/strongbox/blob/master/strongbox-web-core/src/main/java/org/carlspring/strongbox/controllers/nuget/NugetArtifactController.java
