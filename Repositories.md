# Types

## Hosted

Hosted repositories are a place where you can store artifacts.

## Proxy

**Note: Proxy repositories are not yet implemented.**

Proxy repositories serve artifacts which are resolved from remote repositories and cached for local resolution.

It is not possible to store artifacts in these repositories.

## Group

A repository group is a special kind of repository which aggregates a list of repositories and serves it's contents under the same URL. 

It is not possible to store artifacts in these repositories, they only serve them artifacts available via the repositories they are set up to serve.

Group repositories can contain other nested group repositories.

## Virtual

**Note: Virtual repositories are not yet implemented.**

Virtual repositories provide a bridge between different layout formats.

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