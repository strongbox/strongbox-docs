# Types

## Hosted

Hosted repositories are a place where you can store artifacts.

## Proxy

**Note: Proxy repositories are not yet fully implemented.**

Proxy repositories serve artifacts which are resolved from remote repositories and cached for local resolution.

These repositories are a cache for proxied external repositories and the cache may have an expiration. It's therefore important to keep in mind that these caches can be wiped at any time.

When a proxy repository is initially created, it's empty. Due to this, before an initial cache is built, these repositories can be a bit slow at the beginning. However, over a reasonably short amount time they become a lot faster, as the artifacts which are already cached are served from the local file system, instead of being re-requested over the network.

It is not possible to deploy artifacts to these repositories.

## Group

A repository group is a special kind of repository which aggregates a list of repositories and serves it's contents under the same URL. 

It is not possible to deploy artifacts to these repositories, they only serve them artifacts available via the repositories they are set up to serve.

Group repositories can contain other nested group repositories.

Group repositories allow you to:
* Define the ordering of the repositories they serve
* Define routing rules

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

Repositories of this kind will allow artifacts of both SNAPSHOT and release versions.