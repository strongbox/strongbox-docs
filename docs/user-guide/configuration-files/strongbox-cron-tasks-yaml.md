# The `strongbox-cron-tasks.yaml` File

This resource file describes the configuration of the Strongbox cron jobs which are a flexible way to configure recurring tasks for strongbox distribution.

The property controlling this file is `strongbox.cron.tasks.yaml`. The default location for this resource is `etc/conf/strongbox-cron-tasks.yaml`.

This file is read by the system at the server startup time and it automatically schedules (and executes, if needed) tasks based on the provided configuration. All cron task configurations located in this file have to be strongbox supported cron task configurations. Currently, there is no way to provide your own implementation  of the cron task.

# File Structure

For an example, check [here](https://github.com/strongbox/strongbox/blob/master/strongbox-cron/strongbox-cron-api/src/main/resources/etc/conf/strongbox-cron-tasks.yaml)

Every cron task configuration is a `cronTaskConfigurations` array element. Inner properties are:

* `uuid`: identifies the individual cron task configuration in the system

* `name`: cron task configuration name

* `oneTimeExecution`: specifies whether the declared cron task shouldn't be recurring; if `true` it will only be one time executed and removed and rescheduled from the system

* `immediateExecution`: specifies whether the declared cron task should be run immediately

* `properties`: specifies the list of properties for the given cron job

  * `cronExpression`: mandatory property for each cron task configuration ([see doc](https://docs.oracle.com/cd/E12058_01/doc/doc.1014/e12030/cron_expressions.htm))
  
  * `jobClass`: specifies the underlying cron task implementation (mandatory property for each cron task configuration)
  
  * additional set of mandatory/optional properties individually allowed and described below per each individual cron task configuration


# Available Cron Task Configurations

## Repository Layout-Independent Cron Task Configuration

| Description  | Implementation | Mandatory properties | Optional properties |
| ------------- | ------------- | ------------- | ------------- |
| [Empty Trash](https://github.com/strongbox/strongbox/wiki/Cron-Tasks#empty-trash) | `org.carlspring.strongbox.cron.jobs.ClearRepositoryTrashCronJob` ||`storageId`<br>`repositoryId`|
| [Regenerate Checksums](https://github.com/strongbox/strongbox/wiki/Cron-Tasks#regenerate-checksums) | `org.carlspring.strongbox.cron.jobs.RegenerateChecksumCronJob` ||`storageId`<br>`repositoryId`<br>`basePath`<br>`forceRegeneration`|
| Cleanup Expired Artifacts From Proxy Repositories | `org.carlspring.strongbox.cron.jobs.CleanupExpiredArtifactsFromProxyRepositoriesCronJob` |`lastAccessedTimeInDays`|`minSizeInBytes`|

### Maven-Specific Cron Task Configuration

| Description  | Implementation | Mandatory properties | Optional properties |
| ------------- | ------------- | ------------- | ------------- |
| [Rebuild Maven Metadata](https://github.com/strongbox/strongbox/wiki/Cron-Tasks#rebuild-maven-metadata) | `org.carlspring.strongbox.cron.jobs.RebuildMavenMetadataCronJob` ||`storageId`<br>`repositoryId`<br>`basePath`|
| [Rebuild Maven Indexes](https://github.com/strongbox/strongbox/wiki/Cron-Tasks#rebuild-maven-indexes) | `org.carlspring.strongbox.cron.jobs.RebuildMavenIndexesCronJob` |`storageId`<br>`repositoryId`|`basePath`|
| [Download Remote Indexes](https://github.com/strongbox/strongbox/wiki/Cron-Tasks#download-remote-indexes-maven-repositories-only) | `org.carlspring.strongbox.cron.jobs.DownloadRemoteMavenIndexCronJob` |`storageId`<br>`repositoryId`||
| [Remove Timestamped Snapshot Artifacts](https://github.com/strongbox/strongbox/wiki/Cron-Tasks#remove-timestamped-maven-snapshot-artifacts) | `org.carlspring.strongbox.cron.jobs.RemoveTimestampedMavenSnapshotCronJob` ||`storageId`<br>`repositoryId`<br>`basePath`<br>`numberToKeep`<br>`keepPeriod`|

### Nuget-Specific Cron Task Configuration

| Description  | Implementation | Mandatory properties | Optional properties |
| ------------- | ------------- | ------------- | ------------- |
| Download Remote Feed| `org.carlspring.strongbox.cron.jobs.DownloadRemoteFeedCronJob` |`storageId`<br>`repositoryId`||

## Information For Developers

The following classes are related to various aspects of the authorization configuration:

| Class Name  | Description | 
|:------------|-------------|
| [`org.carlspring.strongbox.cron.domain.CronTasksConfigurationDto`](https://github.com/strongbox/strongbox/blob/master/strongbox-cron/strongbox-cron-api/src/main/java/org/carlspring/strongbox/cron/domain/CronTasksConfigurationDto.java) | Represents cron configuration in a deserialized form. |
| [`org.carlspring.strongbox.cron.config.CronTasksConfigurationFileManager`](https://github.com/strongbox/strongbox/blob/master/strongbox-cron/strongbox-cron-api/src/main/java/org/carlspring/strongbox/cron/config/CronTasksConfigurationFileManager.java) | Class to serialize / deserialize the cron configuration. | 

The [strongbox-cron-tasks.yaml](https://github.com/strongbox/strongbox/blob/master/strongbox-cron/strongbox-cron-api/src/main/resources/etc/conf/strongbox-cron-tasks.yaml), which is packaged in the distribution, is located under the [strongbox-storage-api-resources](https://github.com/strongbox/strongbox/blob/master/strongbox-resources/strongbox-storage-api-resources/)'s `src/main/resources/etc/conf` directory.
