# Concept overview

Below is the top level illustration of how artifact management implemented in Strongbox within different Storages, Repositories and Layouts:


[![Strongbox Repository, Layout and Storage Provider Implementation](https://github.com/strongbox/strongbox/wiki/resources/images/layout/Strongbox%20Repository%20Layout%20-%20Concept.png)](https://github.com/strongbox/strongbox/wiki/resources/images/layout/Strongbox%20Repository%20Layout%20-%20Concept.png)

The main thing here is that Strongbox have three layers and each layer decorate the below layer with logic it responsible for.

# Implementation

We can say that Artifacts are just files so implementation mainly based on common JDK File I/O (Featuring NIO.2) entities. 

This is how it looks like:

[![Strongbox Repository, Layout and Storage Provider Entities](https://github.com/strongbox/strongbox/wiki/resources/images/layout/Strongbox%20Repository%20Layout%20-%20Classes.png)](https://github.com/strongbox/strongbox/wiki/resources/images/layout/Strongbox%20Repository%20Layout%20-%20Classes.png)

## Artifact Coordinates

Every Layout should identify artifacts somehow, and we have `ArtifactCoordinates` responsible for this in Strongbox. 