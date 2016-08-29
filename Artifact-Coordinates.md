
# General

Artifact coordinates are an abstraction which allows you to identify an artifact (regardless of the type of artifact -- Maven, Ant, Nuget, RPM, etc).

Coordinates could, for example be things like:
* `groupId`
* `artifactId`
* `version`
* `type`
* `classifier`

The above is an example for Maven, however, the idea of coordinates, is to provide a more generic way to identify artifacts.

# Information For Developers

As the different repository formats have different coordinate systems, there needs to be a separate implementation of the [`ArtifactCoordinates`](https://github.com/strongbox/strongbox/tree/master/strongbox-commons/src/main/java/org/carlspring/strongbox/artifact/coordinates/ArtifactCoordinates.java) per repository layout, (best achieved by extending the [`AbstractArtifactCoordinates`](https://github.com/strongbox/strongbox/tree/master/strongbox-commons/src/main/java/org/carlspring/strongbox/artifact/coordinates/AbstractArtifactCoordinates.java)).
