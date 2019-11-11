# Artifact Coordinates

## Introduction

Artifact coordinates are an abstraction which allows you to identify an artifact (regardless of the type of artifact -- Maven, Ant, Nuget, RPM, etc).

Coordinates could, for example be things like:

* `groupId`
* `artifactId`
* `version`
* `type`
* `classifier`

The above is an example for Maven, however, the idea of coordinates, is to provide a more generic way to identify artifacts.

## Information For Developers

As the different repository formats have different coordinate systems, there needs to be a separate implementation of 
the [ArtifactCoordinates] per repository layout, (best achieved by extending the [AbstractArtifactCoordinates]).

### Mandatory Coordinates

As a bare minimum, each implementation needs to provide the following two mandatory fields:

* `id`
* `version`

The `id` would be the name/id of the artifact, whereas, the `version` would describe the version.

### Built-in Implementations

Strongbox comes with the following built-in implementations:

* [MavenArtifactCoordinates](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-maven-layout/strongbox-storage-maven-layout-provider/src/main/java/org/carlspring/strongbox/artifact/coordinates/MavenArtifactCoordinates.java)
* [NpmArtifactCoordinates](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-npm-layout-provider/src/main/java/org/carlspring/strongbox/artifact/coordinates/NpmArtifactCoordinates.java)
* [NugetArtifactCoordinates](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-nuget-layout-provider/src/main/java/org/carlspring/strongbox/artifact/coordinates/NugetArtifactCoordinates.java)
* [RawArtifactCoordinates](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-api/src/main/java/org/carlspring/strongbox/artifact/coordinates/RawArtifactCoordinates.java) (used by the [Raw Layout Provider])


[ArtifactCoordinates]: https://github.com/strongbox/strongbox/tree/master/strongbox-storage/strongbox-storage-api/src/main/java/org/carlspring/strongbox/artifact/coordinates/ArtifactCoordinates.java
[AbstractArtifactCoordinates]: https://github.com/strongbox/strongbox/tree/master/strongbox-storage/strongbox-storage-api/src/main/java/org/carlspring/strongbox/artifact/coordinates/AbstractArtifactCoordinates.java
[Raw Layout Provider]: https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-raw-layout-provider/src/main/java/org/carlspring/strongbox/providers/layout/RawLayoutProvider.java
