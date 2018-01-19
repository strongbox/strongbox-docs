# WARNING
This feature is currently highly experimental, under active development and it's implementation may change without warning. If you would like to try it out and find issues, please report the,=m on the issue tracker. At the moment, only hosted repositories have been tested; proxy and group raw repositories are still not implemented.

# General
The Raw layout provider allows storing artifacts that have no particular strict format.

# Notes

## Artifact Coordinates

This is the list of artifact coordinates supported by the provider:

| Coordinate   | Description             | Type      |
|:-------------|:------------------------|:----------|
| `path`       | The path of the package | Mandatory |

## User Agent

The accepted `User-Agent` headers supported must look like `User-Agent=Raw/*`.

# Information For Developers

The code for the Raw layout provider is located under the [strongbox-storage-raw-layout-provider](https://github.com/strongbox/strongbox/tree/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-raw-layout-provider) module.

## Classes of Interest

The following are some of the most important classes you will need to be familiar with in order to work on this layout provider:

| Coordinate   | Description |
|:-------------|:------------|
| [NullArtifactCoordinates](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-raw-layout-provider/src/main/java/org/carlspring/strongbox/artifact/coordinates/NullArtifactCoordinates.java) | This is an implementation of `ArtifactCoordinates` for the Raw layout. Basically, there are no coordinates. |
| [RawLayoutProvider](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-raw-layout-provider/src/main/java/org/carlspring/strongbox/providers/layout/RawLayoutProvider.java) | This is the actual implementation of the Raw layout provider. |
| [RawRepositoryFeatures](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-raw-layout-provider/src/main/java/org/carlspring/strongbox/repository/RawRepositoryFeatures.java) | This defines the custom layout provider features for the Raw layout provider. |
| [RawRepositoryManagementStrategy](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-raw-layout-provider/src/main/java/org/carlspring/strongbox/repository/RawRepositoryManagementStrategy.java) | This class is used to handle the initialization of Raw repositories. |
| [RawArtifactController](https://github.com/strongbox/strongbox/blob/master/strongbox-web-core/src/main/java/org/carlspring/strongbox/controllers/raw/RawArtifactController.java) | This is the Raw-specific implementation of the `BaseArtifactController`. |

# See Also
* [[How To Implement Your Own Repository Format]]
