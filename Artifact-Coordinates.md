
# General

Artifact coordinates help you to identify an artifact (regardless of the type of artifact -- Maven, Ant, Nuget, RPM, etc).

Coordinates could, for example be things like:
* `groupId`
* `artifactId`
* `version`
* `type`
* `classifier`

# Information For Developers

As the different repository formats have different coordinate systems, there needs to be a separate implementation of the [`org.carlspring.strongbox.artifact.coordinates.ArtifactCoordinates`](https://github.com/strongbox/strongbox/tree/master/strongbox-commons/src/main/java/org/carlspring/strongbox/artifact/coordinates/ArtifactCoordinates.java) per repository layout.
