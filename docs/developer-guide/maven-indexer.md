# Maven Indexer

## What Is The Maven Indexer?

The Maven Indexer is a library created by Sonatype Inc. and contributed to the Apache Maven team. It can produce a 
Lucene Index and carry out queries against it. This packed index can be downloaded from the repository and be used by:

* Artifact repository managers
    * Check if a remote host contains an artifact, class, etc
    * Check what versions of an artifact exist
* IDE-s
    * Resolve dependencies
    * To find out which packages contain the class you would like to import
* Custom tools

## How Does The Maven Indexer Work?

The Maven Indexer uses:

* The artifact's `.pom` file
* The artifact file itself 
* The artifact's file system path 

to figure out information about the artifacts which it adds to a Lucene index. 
This index can then be packed and downloaded by consumers. 

## What Kind Of Information Does The Maven Indexer Keep?

The Maven Indexer keeps a record of the following information:

* Basic artifact file attributes: last modified, file extension, file size
* Source and/or javadoc existence flags
* GAV coordinates (`groupId`, `artifactId`, `version`, `packaging`, `classifier`)
* SHA-1 checksums (+ whether the related signature file exists)

## What Artifacts Does The Maven Indexer Index?

The indexer will add a record to the Lucene index for every Maven artifact that it recognizes (the file name and 
artifact path have to match the Maven artifact repository storage rules), regardless of whether or not 
it has a `.pom` file. Artifacts that have several classifiers will have all their sub-artifact files added to the index, 
except a record for the POM. 

Maven indexer also may or may not store a `.pom` file as an artifact. However, firstly it tries to find matching _real_ 
artifact file in the file system, switching over to indexing that, instead of the `.pom` file.

### What's not indexable

The following file types are not indexable:

* `maven-metadata.xml` files
* `.properties` files
* checksum and signature files `.asc`, `.md5`, `.sha1`

## What Is The Maven Indexer Used For In The Strongbox Project?

The Maven Indexer is used for integration with IDE-s.

The Maven indexes produced by most public repository managers (such as Maven Central), are usually rebuilt once a week, 
as it can take quite a while to scan large repositories with countless small artifacts. Hence, these indexes have proven
 to not be quite as up-to-date as the real server's contents. For this reason, we are using OrientDB to keep more 
 accurate information.

There are two types of Maven Indexer indexes:

* Local
    * For hosted repositories, this contains the artifacts that have been deployed to this repository.
    * For proxy repositories, this contains the artifacts which have been requested and cached from the remote repository.
* Remote
    * This is downloaded from the remote repository and contains a complete index of what is available on the remote.

## Where Are The Maven Indexes Located?

Every repository has an index under the `strongbox-vault/storages/${storageId}/${repositoryId}/.index` directory 
where the index is located.

* [Hosted](../knowledge-base/repositories.md#hosted) repositories have:
    * Local: `strongbox-vault/storages/${storageId}/${repositoryId}/local/.index`
* [Proxy](../knowledge-base/repositories.md#proxy) repositories have:
    * Local: `strongbox-vault/storages/${storageId}/${repositoryId}/local/.index`
    * Remote: `strongbox-vault/storages/${storageId}/${repositoryId}/remote/.index`

## Do Maven Indexes Break And How To Repair Them?

Usually, you don't need to rebuild the index, because all artifact operations should be handled via the REST API.

However, there are cases like for example:
- Some artifacts have gone missing (hdd error, or somebody removed them and you need to restore one, or a whole batch of 
  them manually directly on the file system without not using the REST API)
- You have added/removed some artifact(s) manually on the file system and would like to update the index

## Packed Indexes

In contrast to unpacked indexes (which are used for searching and browsing the remote), packed indexes are used for 
transferring indexes from the remote to the proxy/tool. 

### What Are Packed Indexes?

Packed indexes are either a complete compressed index, or a compressed subset of data which can be applied to an 
existing index incrementally.

### When Are Packed Indexes Generated?

Packed indexes are generated when the index for a repository is rebuilt. They are not generated when a re-indexing 
request for a path in the repository is executed.

## Information For Developers

The code for the Maven indexing is located under the [strongbox-storage-maven-layout-provider] module.

## See Also
* [Maven Indexer: Github](https://github.com/apache/maven-indexer/)
* [Maven Indexer: About](http://maven.apache.org/maven-indexer-archives/maven-indexer-LATEST/index.html)
* [Maven Indexer: Fields](http://maven.apache.org/maven-indexer-archives/maven-indexer-LATEST/indexer-core/index.html)
* [Maven Indexer: Core (Notes)](https://github.com/apache/maven-indexer/tree/master/indexer-core)
* [Maven Indexer: Examples](https://github.com/apache/maven-indexer/tree/master/indexer-examples)
* [Maven Indexer: Incremental Downloading](http://blog.sonatype.com/2009/05/nexus-indexer-20-incremental-downloading/)
* [Maven Indexing: Indexing (Part I)](http://www.sonatype.com/people/2009/06/nexus-indexer-api-part-1/)
* [Maven Indexing: Searching (Part II)](http://www.sonatype.com/people/2009/06/nexus-indexer-api-part-2/)
* [Maven Indexing: Packing (Part III)](http://blog.sonatype.com/2009/09/nexus-indexer-api-part-3/)
* [Maven Metadata](./metadata/maven-metadata.md)
* [Stackoverflow: [maven-indexer]](http://stackoverflow.com/questions/tagged/maven-indexer)


[strongbox-storage-maven-layout-provider]: https://github.com/strongbox/strongbox/tree/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-maven-layout/strongbox-storage-maven-layout-provider
