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

### What's not indexable ?

The following file types are not indexable:

* `maven-metadata.xml` files
* `.properties` files
* checksum and signature files `.asc`, `.md5`, `.sha1`

### What Are Packed Indexes?

Packed indexes are either a complete compressed index, or a compressed subset of data which can be applied to an 
existing index incrementally.

## What's the goal of packed indexes ?

Packed indexes are used for transferring indexes from the remote to the proxy/tool. 

## What Is The Maven Indexer Used For In The Strongbox Project?

The Maven Indexer is used for integration with IDE-s.

<<<<<<< HEAD
The Maven indexes produced by most public repository managers (such as Maven Central), are usually rebuilt once a week, 
as it can take quite a while to scan large repositories with countless small artifacts. Hence, these indexes have proven
 to not be quite as up-to-date as the real server's contents. For this reason, we are using OrientDB to keep more 
 accurate information.
=======
## How Does The Maven Indexer Work In Strongbox ?

Strongbox allows you to download packed repository Maven Index. Every maven repository with indexing enabled serves the packed Maven Index. 
Based on the repository type, the index is prepared as follows:

* [Hosted][hosted-repositories-link] repositories:

  Strongbox stores the information of uploaded artifacts (in hosted repositories) in the OrientDB database. This Information is used 
  to create the hosted repository Maven Index. Strongbox serves following [Maven Indexer Fields][maven-indexer-fields-link] in indexer:

  * artifactId;
  * version;
  * classifier;
  * packaging/extension 
  * classnames
  * lastModified
  * size
  * signatureExists 
  * sha1
  * sourcesExists
  * javadocExists
  
  For each hosted maven repository defined in strongbox there should be a scheduled task configured to rebuild the index (unless you don't 
  want to serve Maven Index for some repository). [Rebuild Maven Indexes Cron Job](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-maven-layout/strongbox-storage-maven-layout-provider/src/main/java/org/carlspring/strongbox/cron/jobs/RebuildMavenIndexesCronJob.java)
  is scheduled at strongbox startup on time specified by the `cronExpression` value within `repositoryConfiguration` in [strongbox.yaml][strongbox-yaml-link]
  configuration file for `repository` with `type` equal to `hosted`.
  
  The process of rebuilding the hosted repository Maven Index purges previous index and recreates it from scratch using OrientDB to keep 
  more accurate information. Thanks to this the index is up-to-date, as the real server's contents. 
  
* [Proxy][proxy-repositories-link] repositories:

  Strongbox fetches the proxy repository Maven Index from remote host, stores it locally and serves it. For each proxy maven repository 
  defined in strongbox there should be a scheduled task configured to re-fetch the index (unless you don't want to serve Maven Index 
  for some repository). [Download Remote Maven Index Cron Job](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-maven-layout/strongbox-storage-maven-layout-provider/src/main/java/org/carlspring/strongbox/cron/jobs/DownloadRemoteMavenIndexCronJob.java)
  is scheduled at strongbox startup on time specified by the `cronExpression` value within `repositoryConfiguration` in [strongbox.yaml][strongbox-yaml-link]
  configuration file for `repository` with `type` equal to `proxy`.
  
  Strongbox supports incremental proxy repository Maven Index. It means that it will update the index by downloading only the missing Maven 
  Index parts that were not downloaded before. Thanks to this feature, strongbox saves the bandwidth costs. Once the soft parts are downloaded,
  they are merged with the locally existing part and finally packed.
  
  The Maven indexes produced by most public repository managers (such as Maven Central), are usually rebuilt once a week.

* [Group][group-repositories-link] repositories:

  Strongbox creates the group repository Maven Index by merging their underlying repositories Maven Indexes. This process is recursive meaning that
  root group repository will contain in the Maven Index all the information stored in every inner and outer vertex repository Maven Index.
  [Merge Maven Group Repository Index Cron Job](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-maven-layout/strongbox-storage-maven-layout-provider/src/main/java/org/carlspring/strongbox/cron/jobs/MergeMavenGroupRepositoryIndexCronJob.java)
  is scheduled at strongbox startup on time specified by the `cronExpression` value within `repositoryConfiguration` in [strongbox.yaml][strongbox-yaml-link]
  configuration file for `repository` with `type` equal to `group`.
  
  The process of rebuilding the group repository Maven Index purges previous index and recreates it from scratch to keep more accurate information. 

## Where Are The Maven Indexes Located in Strongbox ?
>>>>>>> upstream/master

There are two types of Maven Indexer indexes:

* Local
    * For hosted repositories, this contains the artifacts that have been deployed to this repository.
    * For group repositories, this contains the merged index from the underlying repositories.
* Remote
    * This is downloaded from the remote repository and contains a complete index of what is available on the remote.

Every repository (with enabled indexing) has an index under the `strongbox-vault/storages/${storageId}/${repositoryId}/.index` directory 
where the index is located.

* [Hosted][hosted-repositories-link] repositories: have:
    * Local: `strongbox-vault/storages/${storageId}/${repositoryId}/local/.index`
* [Proxy][proxy-repositories-link] repositories have:
    * Remote: `strongbox-vault/storages/${storageId}/${repositoryId}/remote/.index`
* [Group][group-repositories-link] repositories have:
    * Local: `strongbox-vault/storages/${storageId}/${repositoryId}/local/.index`

## How to force to rebuild the repository index ?

Use REST API endpoint:

* `POST` `/api/maven/index/{storageId}/{repositoryId}`
  * see also [MavenIndexController](https://github.com/strongbox/strongbox/blob/master/strongbox-web-core/src/main/java/org/carlspring/strongbox/controllers/layout/maven/MavenIndexController.java)

## How to download the packed repository index ?

Use REST API endpoint:

* `GET` `/storages/{storageId}/{repositoryId}/.index/nexus-maven-repository-index.gz`
  * see also [MavenArtifactController](https://github.com/strongbox/strongbox/blob/master/strongbox-web-core/src/main/java/org/carlspring/strongbox/controllers/layout/maven/MavenArtifactController.java)

## Information For Developers

The code for the Maven indexing is located under the [strongbox-storage-maven-layout-provider] module.

## See Also
* [Maven Indexer: Github](https://github.com/apache/maven-indexer/)
* [Maven Indexer: About](http://maven.apache.org/maven-indexer-archives/maven-indexer-LATEST/index.html)
* [Maven Indexer: Fields][maven-indexer-fields-link]
* [Maven Indexer: Core (Notes)](https://github.com/apache/maven-indexer/tree/master/indexer-core)
* [Maven Indexer: Examples](https://github.com/apache/maven-indexer/tree/master/indexer-examples)
* [Maven Indexer: Incremental Downloading](http://blog.sonatype.com/2009/05/nexus-indexer-20-incremental-downloading/)
* [Maven Indexing: Indexing (Part I)](http://www.sonatype.com/people/2009/06/nexus-indexer-api-part-1/)
* [Maven Indexing: Searching (Part II)](http://www.sonatype.com/people/2009/06/nexus-indexer-api-part-2/)
* [Maven Indexing: Packing (Part III)](http://blog.sonatype.com/2009/09/nexus-indexer-api-part-3/)
* [Maven Metadata](./metadata/maven-metadata.md)
* [Stackoverflow: [maven-indexer]](http://stackoverflow.com/questions/tagged/maven-indexer)


[strongbox-yaml-link]: https://github.com/strongbox/strongbox/blob/master/strongbox-resources/strongbox-storage-api-resources/src/main/resources/etc/conf/strongbox.yaml
[maven-indexer-fields-link]: http://maven.apache.org/maven-indexer-archives/maven-indexer-LATEST/indexer-core/index.html
[hosted-repositories-link]: ../knowledge-base/repositories.md#hosted
[proxy-repositories-link]: ../knowledge-base/repositories.md#proxy
[group-repositories-link]: ../knowledge-base/repositories.md#group
[strongbox-storage-maven-layout-provider]: https://github.com/strongbox/strongbox/tree/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-maven-layout/strongbox-storage-maven-layout-provider
