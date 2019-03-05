# General

Similarly to sources and version control, artifact repositories are a place to store the compiled code. 
This reduces build times, as storing binaries in a central place removes the need to constantly recompile them. 
Version control, on the other hand is not an appropriate place to store binaries, as it causes source repositories 
to grow quite quickly and thus makes them gradually slower.

<div id="hosted"></div>

## Types

<div id="proxy"></div>

??? info "[Hosted](#hosted)" 

    Hosted repositories are a place where you can deploy your artifacts.

<div id="group"></div>

??? info "[Proxy](#proxy)"

    Proxy repositories serve artifacts which are resolved from remote repositories and cached for local resolution.
    
    These repositories are a cache for proxied external repositories and the cache may have an expiration. 
    It's therefore important to keep in mind that these caches can be wiped at any time.
    
    When a proxy repository is initially created, it's empty. Due to this, before an initial cache is built, 
    these repositories can be a bit slow at the beginning. However, over a reasonably short amount time they 
    become a lot faster, as the artifacts which are already cached are served from the local file system, 
    instead of being re-requested over the network.
    
    It is not possible to deploy artifacts to these repositories.

??? info "[Group](#group)"

    A repository group is a special kind of repository which aggregates a list of repositories and serves 
    it's contents under the same URL. 
    
    It is not possible to deploy artifacts to these repositories, they only serve them artifacts available 
    via the repositories they are set up to serve.
    
    Group repositories can contain other nested group repositories.
    
    Group repositories allow you to:
    
    * Define the ordering of the repositories they serve
    * Define [artifact routing rules][artifact-routing-rules]

??? info "Virtual"

    **Note: Virtual repositories are not yet implemented.**
    
    Virtual repositories provide a bridge between different layout formats.


## Layouts

Layouts is what different types of repositories are called (i.e. Maven layout repository, NPM layout repository, etc)

??? success "Maven 2.x / 3.x"

    Maven 2.x/3.x repositories are fully supported. We support hosted, proxy and group repositories. 
    You can check [here][integrating-build-tools] and [here][hello-maven] for an example quick start project.
    
    (TODO: fix link)


??? success "NPM"

    The NPM repository layout is currently under active development.   
    It currently sufficiently functions in hosted, proxy and group repositories.  
    Please, feel free to report issues on our issue tracker. Patches are always welcome!

??? success "Nuget"

    We support Nuget (protocol v2) for hosted, proxy and group repositories.  
    You can check [here][hello-nuget] for an example quick start project.

??? success "Raw"

    For the cases where repositories with an undefined structure are required, the Raw repositories could be used. 
    We support hosted, proxy and group repositories.


## Policies

Repository policies define the type of artifact versions which will be handled by the respective repository.

??? success "Snapshot"

    Repositories of this kind will only allow artifacts with snapshot versions (`1.1-SNAPSHOT`,`1.2-SNAPSHOT`, etc) to be deployed.

??? success "Release"

    Repositories of this kind will only allow artifacts with fixed/released versions (`1.1`, `1.2`, etc) to be deployed.

??? success "Mixed"

    Repositories of this kind will allow artifacts of both snapshot and release versions. 
    This is usually used for group repositories, as they might contain both snapshot and release repositories.
    
## The `repositoryId`

Each repository is identified by its Id and the storage that it belongs to. The repository's Id should be unique per storage and it may contain:

- All letters from the [English_alphabet](https://en.wikipedia.org/wiki/English_alphabet) (upper and lowercase)
- All [numerical digits](https://en.wikipedia.org/wiki/Numerical_digit)
- 3 special characters: `-` (dash), `_` (underscore) and `.` (dot)    

## See Also
* [Artifact Routing Rules][artifact-routing-rules]
* [Maven: Introduction to Repositories](http://maven.apache.org/guides/introduction/introduction-to-repositories.html)


[artifact-routing-rules]: ../user-guide/artifact-routing-rules.md
[integrating-build-tools]: https://github.com/strongbox/strongbox-docs/blob/master/wiki/integrating-build-tools-with-strongbox.md
[hello-maven]: https://github.com/strongbox/strongbox-examples/tree/master/hello-strongbox-maven
[hello-nuget]: (https://github.com/strongbox/strongbox-examples/tree/master/hello-strongbox-nuget
