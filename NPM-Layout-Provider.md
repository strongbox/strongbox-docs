# WARNING
This feature is currently highly experimental, under active development and it's implementation may change without warning. If you would like to try it out and find issues, please report them on the issue tracker. At the moment, only hosted repositories have been tested; proxy and group NPM repositories are still not implemented.

# General
The NPM layout provider allows storing artifacts using the NPM format.

# Notes

## Artifact Coordinates

This is the list of artifact coordinates supported by the provider:

| Coordinate   | Description                | Type      |
|:-------------|:---------------------------|:----------|
| `scope`      | The scope of the package   | Optional  |
| `name`       | The name of the package    | Mandatory |
| `version`    | The version of the package | Mandatory |

## User Agent

The accepted `User-Agent` headers supported must look like `User-Agent=npm/*`.

# Supported Commands

Following CLI commands supported:
- `$npm publish`
- `$npm install`
- `$npm view` 

# Information For Developers

The code for the NPM layout provider is located under the [strongbox-storage-npm-layout-provider](https://github.com/strongbox/strongbox/tree/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-npm-layout-provider) module.

## Classes of Interest

The following are some of the most important classes you will need to be familiar with in order to work on this layout provider:

| Coordinate   | Description |
|:-------------|:------------|
| [NpmArtifactCoordinates](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-npm-layout-provider/src/main/java/org/carlspring/strongbox/artifact/coordinates/NpmArtifactCoordinates.java) | This is an implementation of `ArtifactCoordinates` for the NPM layout. Basically, there are no coordinates. |
| [NpmLayoutProvider](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-npm-layout-provider/src/main/java/org/carlspring/strongbox/providers/layout/NpmLayoutProvider.java) | This is the actual implementation of the NPM layout provider. |
| [NpmRepositoryFeatures](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-npm-layout-provider/src/main/java/org/carlspring/strongbox/repository/NpmRepositoryFeatures.java) | This defines the custom layout provider features for the NPM layout provider. |
| [NpmRepositoryManagementStrategy](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-npm-layout-provider/src/main/java/org/carlspring/strongbox/repository/NpmRepositoryManagementStrategy.java) | This class is used to handle the initialization of NPM repositories. |
| [NpmArtifactController](https://github.com/strongbox/strongbox/blob/master/strongbox-web-core/src/main/java/org/carlspring/strongbox/controllers/npm/NpmArtifactController.java) | This is the NPM-specific implementation of the `BaseArtifactController`. |

# See Also
* [[How To Implement Your Own Repository Format]]
