Strongbox is an opensource Artifact Repository Manager written in Java.

# General artifact repository manager functionality
* Provide a place to host your binary artifacts (via [hosted](Repositories#hosted) repositories)
* Provide a way to resolve artifacts from other third-party repositories on the Internet (via [proxy](Repositories#proxy) repositories)
* Provide a way to serve multiple artifact repositories under the same URL (via [group](Repositories#group) repositories)
* Access control over the repositories
* Search for artifacts

# Benefits of using an artifact repository manager

Here are some key benefits of using an artifact repository manager, instead of downloading/installing libraries locally, or storing them in a version control:
* Access to external repositories is handled via (via [proxy](Repositories#proxy) repositories which is especially useful in company environments, as it reduces the bandwidth towards external sites, due to a build up of a local cache. The benefit of this can mainly be experienced with release repositories, due to the fact that the artifacts in them are guaranteed to never change, hence no further attempts to resolve an artifact from external sources is made after the initial one.
* Third-party artifacts are resolved from one central location, instead of developers:
  * Sharing the libraries among themselves and manually copying them
  * Having to list all the required external repositories in their build files
* Control over what artifacts are allowed within the company
* Artifacts are not stored under the version control system, hence keeping it lightweight and clean from binary products.
* Developers don't have to build all the libraries from sources all the time, hence:
  * Less time to build, more time to code
  * You don't have to grant access to third-parties to your VCS in order to share your code with them
* The continuous integration servers don't have to rely on external services to resolve artifacts and builds are faster.
* If the remote repository, which is being proxied, is down, the artifacts can still be resolved from the cache, if they have previously been requested.
* Storing artifacts in an artifact repository manager, instead of under a version control server means that you'll be able to have smaller source repositories. If you're using a distributed version control such as Git, Mercurial and so on, this will make a huge difference when cloning a project, because you wouldn't have to waste time and space checking out the entire history or libraries from version control, when you would only be needing a significantly smaller sub-set of them.
