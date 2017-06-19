
# What Is The Maven Indexer?

The Maven Indexer is a library created by Sonatype Inc. and contributed to the Apache Maven team. It can produce a Lucene Index and carry out queries against it. This packed index can be downloaded from the repository and be used by:
* Artifact repository managers
 * Check if a remote host contains an artifact, class, etc
 * Check what versions of an artifact exist
* IDE-s
 * Resolve dependencies
 * To find out which packages contain the class you would like to import
* Custom tools

# How Does The Maven Indexer Work?

The Maven Indexer uses `maven-metadata.xml` and `.pom` files to figure out information about the artifacts which it adds to a Lucene index. This index can then be packed and downloaded by consumers. 

# What Kind Of Information Does The Maven Indexer Keep?

The Maven Indexer keeps a record of the following information:

* GAV coordinates (`groupId`, `artifactId`, `version`, `packaging`, `classifier`)
* SHA-1 checksums
* Fully qualified class names contained in the artifact

# What Artifacts Does The Maven Indexer Index?

The indexer will add a record to the Lucene index for every artifact that has a `.pom` file. Artifacts that have several classifiers will have all their sub-artifact files added to the index, except a record for the POM. Artifacts, which have a `<packaging>pom</packaging>`, (usually parent POM-s and dependency POM-s), will be added to the index, as they have no other sub-artifacts.

# What Is The Maven Indexer Used For In The Strongbox Project?

The Maven Indexer is used for integration with IDE-s.

The Maven indexes produced by most public repository managers (such as Maven Central), are usually rebuilt once a week, as it can take quite a while to scan large repositories with countless small artifacts. Hence, these indexes have proven to not be quite as up-to-date, as the real server's contents. For this reason, we are using OrientDB to keep more accurate information.

There are two types of Maven Indexer indexes:
* Local
  * For hosted repositories, this contains the artifacts that have been deployed to this repository.
  * For proxy repositories, this contains the artifacts which have been requested and cached from the remote repository.
* Remote
  * This is downloaded from the remote repository and contains a complete index of what is available on the remote.

# Where Are The Maven Indexes Located?

* [Hosted](https://github.com/strongbox/strongbox/wiki/Repositories#hosted) repositories have:
  * Local: `strongbox-vault/storages/${storageId}/${repositoryId}/local/.index`
* [Proxy](https://github.com/strongbox/strongbox/wiki/Repositories#proxy) repositories have:
  * Local: `strongbox-vault/storages/${storageId}/${repositoryId}/local/.index`
  * Remote: `strongbox-vault/storages/${storageId}/${repositoryId}/remote/.index`

Every repository has an index under the `strongbox-vault/storages/${storageId}/${repositoryId}/.index` directory where the index is located.

# Do Maven Indexes Break And How To Repair Them?

Usually, you don't need to rebuild the index, because all artifact operations should be handled via the REST API.

However, there are cases like for example:
- Some artifacts have gone missing (hdd error, or somebody removed them and you need to restore one, or a whole batch of them manually directly on the file system without not using the REST API)
- You have added/removed some artifact(s) manually on the file system and would like to update the index

# Packed Indexes

In contrast to unpacked indexes (which are used for searching and browsing the remote), packed indexes are used for transferring indexes from the remote to the proxy/tool. 

## What Are Packed Indexes?

Packed indexes are either a complete compressed index, or a compressed subset of data which can be applied to an existing index incrementally.

## When Are Packed Indexes Generated?

Packed indexes are generated when the index for a repository is rebuilt. They are not generated when a re-indexing request for a path in the repository is executed.

# Information For Developers

The code for the Maven indexing is located under the [strongbox-storage-maven-layout-provider](https://github.com/strongbox/strongbox/tree/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-maven-layout-provider) module.

# See Also
* [Maven Indexer: Github](https://github.com/apache/maven-indexer/)
* [Maven Indexer: About](http://maven.apache.org/maven-indexer-archives/maven-indexer-LATEST/index.html)
* [Maven Indexer: Fields](http://maven.apache.org/maven-indexer-archives/maven-indexer-LATEST/indexer-core/index.html)
* [Maven Indexer: Core (Notes)](https://github.com/apache/maven-indexer/tree/master/indexer-core)
* [Maven Indexer: Examples](https://github.com/apache/maven-indexer/tree/master/indexer-examples)
* [Maven Indexer: Incremental Downloading](http://blog.sonatype.com/2009/05/nexus-indexer-20-incremental-downloading/)
* [Maven Indexing: Indexing (Part I)](http://www.sonatype.com/people/2009/06/nexus-indexer-api-part-1/)
* [Maven Indexing: Searching (Part II)](http://www.sonatype.com/people/2009/06/nexus-indexer-api-part-2/)
* [Maven Indexing: Packing (Part III)](http://blog.sonatype.com/2009/09/nexus-indexer-api-part-3/)
* [Maven Metadata](https://github.com/strongbox/strongbox/wiki/Maven-Metadata)
* [Stackoverflow: [maven-indexer]](http://stackoverflow.com/questions/tagged/maven-indexer)