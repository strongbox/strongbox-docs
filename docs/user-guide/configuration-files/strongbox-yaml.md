# The `strongbox.yaml` File

This resource file describes the configuration of the server.

The property controlling this file is `strongbox.config.file`. The default location for this resource is `etc/conf/strongbox.yaml`.

The cases in which this file is required are:
* During the server launch
* For a configuration import from another server
* For a configuration export of the server

# Example `strongbox.yaml` File

The following is an example of a `strongbox.yaml` configuration file:

    configuration:
      instanceName: strongbox
      version: ${project.version}
      revision: ${strongbox.revision}
      baseUrl: http://localhost:48080/
      port: 48080
      sessionConfiguration:
        timeoutSeconds: 3600
      remoteRepositoriesConfiguration:
        checkIntervalSeconds: 60
        heartbeatThreadsNumber: 5
        retryArtifactDownloadConfiguration:
          timeoutSeconds: 60
          maxNumberOfAttempts: 5
          minAttemptsIntervalSeconds: 5
      corsConfiguration:
        allowedCredentials: true
        maxAge: 600
        allowedOrigins:
          - "*"
        allowedMethods:
          - GET
          - PUT
          - POST
          - DELETE
          - OPTIONS
        allowedHeaders:
          - Accept
          - Accepts
          - Authorization
          - Access-Control-Allow-Headers
          - Access-Control-Request-Headers
          - Access-Control-Request-Method
          - DNT
          - Keep-Alive
          - User-Agent
          - X-Requested-With
          - If-Modified-Since
          - Cache-Control
          - Content-Type
          - Content-Range,Range
      storages:
        storage0:
          id: storage0
          repositories:
            releases:
              id: releases
              policy: release
              dataStore: file-system
              layout: Maven 2
              type: hosted
              allowsForceDeletion: true
              checksumHeadersEnabled: true
              strictChecksumValidation: true
              repositoryConfiguration:
                type: Maven 2
                indexingEnabled: true
                cronExpression: "0 0 2 * * ?"
                metadataExpirationStrategy: checksum
            snapshots:
              id: snapshots
              policy: snapshot
              dataStore: file-system
              layout: Maven 2
              type: hosted
              secured: true
              checksumHeadersEnabled: true
              strictChecksumValidation: true
              repositoryConfiguration:
                type: Maven 2
                indexingEnabled: true
                cronExpression: "0 0 2 * * ?"
                metadataExpirationStrategy: checksum
        storage-common-proxies:
          id: storage-common-proxies
          repositories:
            maven-central:
              id: maven-central
              policy: release
              dataStore: file-system
              layout: Maven 2
              type: proxy
              remoteRepository:
                url: https://repo.maven.apache.org/maven2/
                downloadRemoteIndexes: true
                autoBlocking: true
                checksumValidation: true
              repositoryConfiguration:
                type: Maven 2
                indexingEnabled: true
                cronExpression: "0 0 2 * * ?"
                metadataExpirationStrategy: checksum
            carlspring:
              id: carlspring
              policy: mixed
              dataStore: file-system
              layout: Maven 2
              type: proxy
              remoteRepository:
                url: https://repo.carlspring.org/content/groups/carlspring
                downloadRemoteIndexes: true
                autoBlocking: true
                checksumValidation: true
              repositoryConfiguration:
                type: Maven 2
                indexingEnabled: true
                cronExpression: "0 0 2 * * ?"
                metadataExpirationStrategy: checksum
            apache-snapshots:
              id: apache-snapshots
              policy: snapshot
              dataStore: file-system
              layout: Maven 2
              type: proxy
              remoteRepository:
                url: https://repository.apache.org/snapshots/
                downloadRemoteIndexes: true
                autoBlocking: true
                checksumValidation: true
              repositoryConfiguration:
                type: Maven 2
                indexingEnabled: true
                cronExpression: "0 0 2 * * ?"
                metadataExpirationStrategy: checksum
            jboss-public-releases:
              id: jboss-public-releases
              policy: release
              dataStore: file-system
              layout: Maven 2
              type: proxy
              remoteRepository:
                url: http://repository.jboss.org/nexus/content/groups/public-jboss/
                downloadRemoteIndexes: true
                autoBlocking: true
                checksumValidation: true
              repositoryConfiguration:
                type: Maven 2
                indexingEnabled: true
                cronExpression: "0 0 2 * * ?"
                metadataExpirationStrategy: checksum
            maven-oracle:
              id: maven-oracle
              policy: release
              dataStore: file-system
              layout: Maven 2
              type: proxy
              remoteRepository:
                url: https://maven.oracle.com
                downloadRemoteIndexes: true
                autoBlocking: true
                checksumValidation: true
                allowsDirectoryBrowsing: false
              repositoryConfiguration:
                type: Maven 2
                indexingEnabled: true
                cronExpression: "0 0 2 * * ?"
                metadataExpirationStrategy: checksum
            group-common-proxies:
              id: group-common-proxies
              policy: release
              dataStore: file-system
              layout: Maven 2
              type: group
              secured: true
              groupRepositories:
                - carlspring
                - maven-central
                - apache-snapshots
                - jboss-public-releases
              repositoryConfiguration:
                type: Maven 2
                indexingEnabled: true
                cronExpression: "0 0 2 * * ?"
                metadataExpirationStrategy: checksum
            nuget.org:
              id: nuget.org
              policy: release
              dataStore: file-system
              layout: NuGet
              type: proxy
              remoteRepository:
                url: https://www.nuget.org/api/v2
              repositoryConfiguration:
                type: NuGet
                remoteFeedPageSize: 1000
        storage-springsource-proxies:
          id: storage-springsource-proxies
          repositories:
            springsource-snapshots:
              id: springsource-snapshots
              policy: snapshot
              dataStore: file-system
              layout: Maven 2
              type: proxy
              remoteRepository:
                url: http://repo.spring.io/snapshot
                downloadRemoteIndexes: true
                autoBlocking: true
                checksumValidation: true
              repositoryConfiguration:
                type: Maven 2
                indexingEnabled: true
                cronExpression: "0 0 2 * * ?"
                metadataExpirationStrategy: checksum
            springsource-releases:
              id: springsource-releases
              policy: release
              dataStore: file-system
              layout: Maven 2
              type: proxy
              remoteRepository:
                url: http://repo.spring.io/libs-release
                downloadRemoteIndexes: true
                autoBlocking: true
                checksumValidation: true
              repositoryConfiguration:
                type: Maven 2
                indexingEnabled: true
                cronExpression: "0 0 2 * * ?"
                metadataExpirationStrategy: checksum
            springsource-milestones:
              id: springsource-milestones
              policy: release
              dataStore: file-system
              layout: Maven 2
              type: proxy
              remoteRepository:
                url: http://repo.spring.io/milestone
                downloadRemoteIndexes: true
                autoBlocking: true
                checksumValidation: true
              repositoryConfiguration:
                type: Maven 2
                indexingEnabled: true
                cronExpression: "0 0 2 * * ?"
                metadataExpirationStrategy: checksum
            springsource-proxies:
              id: springsource-proxies
              policy: mixed
              dataStore: file-system
              layout: Maven 2
              type: group
              secured: true
              groupRepositories:
                - springsource-snapshots
                - springsource-releases
                - springsource-milestones
              repositoryConfiguration:
                type: Maven 2
                indexingEnabled: true
                cronExpression: "0 0 2 * * ?"
                metadataExpirationStrategy: checksum
        storage-ivy-proxies:
          id: storage-ivy-proxies
          repositories:
            typesafe-releases:
              id: typesafe-releases
              policy: release
              dataStore: file-system
              layout: Maven 2
              type: proxy
              remoteRepository:
                url: https://repo.typesafe.com/typesafe/releases
                downloadRemoteIndexes: true
                autoBlocking: true
                checksumValidation: true
              repositoryConfiguration:
                type: Maven 2
                indexingEnabled: true
                cronExpression: "0 0 2 * * ?"
                metadataExpirationStrategy: checksum
            typesafe-ivy-releases:
              id: typesafe-ivy-releases
              policy: release
              dataStore: file-system
              layout: Maven 2
              type: proxy
              remoteRepository:
                url: https://repo.typesafe.com/typesafe/ivy-releases
                downloadRemoteIndexes: true
                autoBlocking: true
                checksumValidation: true
              repositoryConfiguration:
                type: Maven 2
                indexingEnabled: true
                cronExpression: "0 0 2 * * ?"
                metadataExpirationStrategy: checksum
            group-ivy-proxies:
              id: group-ivy-proxies
              policy: release
              dataStore: file-system
              layout: Maven 2
              type: group
              secured: true
              groupRepositories:
                - typesafe-releases
                - typesafe-ivy-releases
              repositoryConfiguration:
                type: Maven 2
                indexingEnabled: true
                cronExpression: "0 0 2 * * ?"
                metadataExpirationStrategy: checksum
        storage-sbt-proxies:
          id: storage-sbt-proxies
          repositories:
            sbt-plugin-releases:
              id: sbt-plugin-releases
              policy: release
              dataStore: file-system
              layout: Maven 2
              type: proxy
              remoteRepository:
                url: https://repo.scala-sbt.org/scalasbt/sbt-plugin-releases
                downloadRemoteIndexes: true
                autoBlocking: true
                checksumValidation: true
              repositoryConfiguration:
                type: Maven 2
                indexingEnabled: true
                cronExpression: "0 0 2 * * ?"
                metadataExpirationStrategy: checksum
            group-sbt-proxies:
              id: group-sbt-proxies
              policy: release
              dataStore: file-system
              layout: Maven 2
              type: group
              secured: true
              groupRepositories:
                - sbt-plugin-releases
                - storage-ivy-proxies:group-ivy-proxies
              repositoryConfiguration:
                type: Maven 2
                indexingEnabled: true
                cronExpression: "0 0 2 * * ?"
                metadataExpirationStrategy: checksum
        storage-third-party:
          id: storage-third-party
          repositories:
            third-party:
              id: third-party
              policy: release
              dataStore: file-system
              layout: Maven 2
              type: hosted
              allowsForceDeletion: true
              checksumHeadersEnabled: true
              repositoryConfiguration:
                type: Maven 2
                indexingEnabled: true
                cronExpression: "0 0 2 * * ?"
            nuget-third-party:
              id: nuget-third-party
              policy: release
              dataStore: file-system
              layout: NuGet
              type: hosted
              allowsForceDeletion: true
              checksumHeadersEnabled: true
        storage-npm:
          id: storage-npm
          repositories:
            npm-releases:
              id: npm-releases
              policy: release
              dataStore: file-system
              layout: npm
              type: hosted
              allowsForceDeletion: true
              checksumHeadersEnabled: true
            npmjs:
              id: npmjs
              policy: release
              dataStore: file-system
              layout: npm
              type: proxy
              remoteRepository:
                url: https://registry.npmjs.org/
                customConfiguration:
                  type: npm
                  lastChangeId: 0
                  replicateUrl: https://replicate.npmjs.com/
        storage-nuget:
          id: storage-nuget
          repositories:
            nuget-releases:
              id: nuget-releases
              policy: release
              dataStore: file-system
              layout: NuGet
              type: hosted
              allowsForceDeletion: true
              checksumHeadersEnabled: true
        storage-raw:
          id: storage-raw
          repositories:
            raw-releases:
              id: raw-releases
              policy: release
              dataStore: file-system
              layout: Raw
              type: hosted
              allowsForceDeletion: true
              checksumHeadersEnabled: true
        public:
          id: public
          repositories:
            maven-group:
              id: maven-group
              policy: mixed
              dataStore: file-system
              layout: Maven 2
              type: group
              secured: true
              groupRepositories:
                - storage0:releases
                - storage0:snapshots
                - storage-common-proxies:group-common-proxies
                - storage-springsource-proxies:springsource-proxies
                - storage-ivy-proxies:group-ivy-proxies
                - storage-sbt-proxies:group-sbt-proxies
                - storage-third-party:third-party
              repositoryConfiguration:
                type: Maven 2
                indexingEnabled: true
                cronExpression: "0 0 2 * * ?"
                metadataExpirationStrategy: checksum
            nuget-group:
              id: nuget-group
              policy: mixed
              dataStore: file-system
              layout: NuGet
              type: group
              secured: true
              groupRepositories:
                - storage-common-proxies:nuget.org
                - storage-third-party:nuget-third-party
            npm-group:
              id: npm-group
              policy: mixed
              dataStore: file-system
              layout: npm
              type: group
              secured: true
              groupRepositories:
                - storage-npm:npmjs
      routingRules:
        rules:
          - uuid: 0f84a9a7-b2ce-47ed-8a01-085e235a1946
            storageId: storage-common-proxies
            repositoryId: group-common-proxies
            pattern: ".*(com|org)/carlspring.*"
            type: deny
            repositories:
              - storageId: storage-common-proxies
                repositoryId: jboss-public-releases

# Information For Developers

The following classes are related to various aspects of the configuration:

| Class Name  | Description | 
|:------------|-------------|
| [`org.carlspring.strongbox.configuration.MutableConfiguration`](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-core/src/main/java/org/carlspring/strongbox/configuration/MutableConfiguration.java) | Represents a configuration in a deserialized form. |
| [`org.carlspring.strongbox.configuration.ConfigurationFileManager`](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-api/src/main/java/org/carlspring/strongbox/configuration/ConfigurationFileManager.java) | Class to serialize / deserialize the configuration. | 

The [strongbox.yaml](https://github.com/strongbox/strongbox/blob/master/strongbox-resources/strongbox-storage-api-resources/src/main/resources/etc/conf/strongbox.yaml), which is packaged in the distribution, is located under the [strongbox-storage-api-resources](https://github.com/strongbox/strongbox/blob/master/strongbox-resources/strongbox-storage-api-resources/)'s `src/main/resources/etc/conf` directory.

# See Also
* [Artifact Routing Rules](../artifact-routing-rules.md)
