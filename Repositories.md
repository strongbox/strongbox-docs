# General

Similarly to sources and version control, artifact repositories are a place to store the compiled code. This reduces build times, as storing binaries in a central place removes the need to constantly recompile them. Version control, on the other hand is not an appropriate place to store binaries, as it causes source repositories to grow quite quickly and thus makes them gradually slower.

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

Maven 2.x/3.x repositories are fully supported.

## Nuget

Nuget repository layout is currently under active development.

# Policies

Repository policies define the type of artifact versions which will be handled by the respective repository.

## Snapshot

Repositories of this kind will only allow artifacts with snapshot versions (`1.1-SNAPSHOT`,`1.2-SNAPSHOT`, etc) to be deployed.

## Release

Repositories of this kind will only allow artifacts with fixed/released versions (`1.1`, `1.2`, etc) to be deployed.

## Mixed

Repositories of this kind will allow artifacts of both snapshot and release versions. This is usually used for group repositories, as they might contain both snapshot and release repositories.

# See Also
- [Maven: Introduction to Repositories](http://maven.apache.org/guides/introduction/introduction-to-repositories.html)
