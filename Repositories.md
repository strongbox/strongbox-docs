# Types

## Hosted

Hosted repositories allow deployment of artifacts.

## Proxy

Proxy repositories serve artifacts which are resolved from remote repositories and cached for local resolution.

## Group

A repository group is a special kind of repository which aggregates a list of repositories and serves it's contents under the same URL. 

## Virtual

Virtual repositories are not yet implemented.

# Layouts

## Maven 2.x/3.x

This is currently the only supported layout.

# Policies

Repository policies define the type of artifact versions which will be handled by the respective repository.

## Snapshot

Repositories of this kind will only allow artifacts with SNAPSHOT versions to be deployed.

## Release

Repositories of this kind will only allow artifacts with fixed/released versions to be deployed.

## Mixed

Repositories of this kind will only allow artifacts of both SNAPSHOT and release versions.
