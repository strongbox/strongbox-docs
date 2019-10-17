# NPM Layout Provider

## Introduction

The NPM layout provider allows storing artifacts using the NPM format.
The code is located under the [strongbox-storage-npm-layout-provider] module.

## Artifact Coordinates

This is the list of artifact coordinates supported by the provider:

| Coordinate   | Description                | Type      |
|:-------------|:---------------------------|:----------|
| `scope`      | The scope of the package   | Optional  |
| `name`       | The name of the package    | Mandatory |
| `version`    | The version of the package | Mandatory |

## User Agent

The accepted `User-Agent` headers supported must look like `User-Agent=npm/*`.

## Supported Commands

Following [CLI commands](https://docs.npmjs.com/cli/npm) supported:

- `npm publish`

- `npm install`

- `npm view` 

- `npm search`

- `npm adduser` 

### Classes of Interest

The following are some of the most important classes you will need to be familiar with in order to work on this layout provider:

| Coordinate   | Description |
|:-------------|:------------|
| [NpmArtifactCoordinates] | This is an implementation of `ArtifactCoordinates` for the NPM layout. Basically, there are no coordinates. |
| [NpmLayoutProvider] | This is the actual implementation of the NPM layout provider. |
| [NpmRepositoryFeatures] | This defines the custom layout provider features for the NPM layout provider. |
| [NpmRepositoryManagementStrategy] | This class is used to handle the initialization of NPM repositories. |
| [NpmArtifactController] | This is the NPM-specific implementation of the `BaseArtifactController`. |

## See Also
* [Writing a layout provider]
* [NPM Metadata]

[Writing a layout provider]: ./how-to-implement-your-own-repository-format.md
[strongbox-storage-npm-layout-provider]: https://github.com/strongbox/strongbox/tree/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-npm-layout-provider
[NpmArtifactCoordinates]: https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-npm-layout-provider/src/main/java/org/carlspring/strongbox/artifact/coordinates/NpmArtifactCoordinates.java
[NpmLayoutProvider]: https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-npm-layout-provider/src/main/java/org/carlspring/strongbox/providers/layout/NpmLayoutProvider.java
[NpmRepositoryFeatures]: https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-npm-layout-provider/src/main/java/org/carlspring/strongbox/repository/NpmRepositoryFeatures.java
[NpmRepositoryManagementStrategy]: https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-npm-layout-provider/src/main/java/org/carlspring/strongbox/repository/NpmRepositoryManagementStrategy.java
[NpmArtifactController]: https://github.com/strongbox/strongbox/blob/master/strongbox-web-core/src/main/java/org/carlspring/strongbox/controllers/npm/NpmArtifactController.java
[NPM Metadata]: ../metadata/npm-metadata.md
