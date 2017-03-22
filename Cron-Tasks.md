Cron tasks can be used to execute scheduled tasks.

Cron tasks can execute tasks against:
- A path in a repository
- A repository
- All the repositories in a storage
- All repositories

# Implementations

The following implementations exist:
* Java
* Groovy

All the built-in cron tasks are written in Java, however, it is also possible to execute scheduled Groovy scripts.

# Available Cron Tasks

The following is a list of the implemented cron tasks.

## Rebuild Maven Metadata

Sometimes Maven metadata can become corrupt, or not reflect the actual artifacts on the file system. Usually, this will happen in cases where an artifact has been added, from the file system manually and the respective `maven-metadata.xml` files have not been updated.

This cron task can rebuild the metadata for Maven repositories. (Check this article for more information on [[Maven Metadata]]).

## Rebuild Maven Indexes

Sometimes Maven indexes can become corrupt, or not reflect the actual artifacts on the file system. Usually, this will happen in cases where an artifact has been added, or removed from the file system manually, in which case the index would not be updated on it own, because the application would know of this change.

This cron task can rebuild the Lucene for Maven repositories. (Check this article for more information on [[Maven Indexer]]).

## Download Remote Indexes (Maven Repositories Only)

Maven proxy repositories have two types of Lucene indexes:
* A local one, that contains all the locally cached artifacts.
* A remote one, that contains a list of all of the artifacts available from the remote.

Each proxy repository needs to have a cron task that downloads the remote at a given interval and merges it with the local copy of the remote.

## Empty Trash

This task can periodically empty the trash.

## Remove Time-stamped Maven Snapshot Artifacts

This cron task can perform cleanups of time-stamped snapshot builds.

The cron task is be able to remove all timestamped artifacts based on the following rules:
* **numberToKeep** : The number of artifacts to keep. For example, if this is set to 2, versions 1, 2  and 3  will be removed and only the last two (4  and 5) preserved.
* **keepPeriod** : The period to keep artifacts

The number of artifacts to keep takes precedence, ensuring that the **numberToKeep** are preserved.

## Remove Released Snapshots

This task checks which artifacts have been released and can be removed from the respective snapshot repository.

## Regenerate Checksums

This task can be useful, in cases where an artifact has been copied to (or altered) manually on the file system and there are no checksum, or the checksum has become invalid.

# Information for developers

## Location Of Code
The code for the cron tasks is located under the [strongbox-cron-tasks](https://github.com/strongbox/strongbox/tree/master/strongbox-cron-tasks) module.

The base cron implementation classes are:
* [JavaCronJob](https://github.com/strongbox/strongbox/blob/master/strongbox-cron-tasks/src/main/java/org.carlspring.strongbox/cron/api/jobs/JavaCronJob.java)
* [GroovyCronJob](https://github.com/strongbox/strongbox/blob/master/strongbox-cron-tasks/src/main/java/org.carlspring.strongbox/cron/api/jobs/GroovyCronJob.java)

## Notes

### Support Spring DI in Quartz job

Quartz does not know anything about Spring dependency injection.

But we need to be able to autowire Spring beans in Quartz job classes. So, it was created a custom job factory class called [AutowiringSpringBeanJobFactory](https://github.com/strongbox/strongbox/blob/master/strongbox-cron-tasks/src/main/java/org.carlspring.strongbox/cron/config/AutowiringSpringBeanJobFactory.java) to automatically autowire quartz objects using Spring. This class extends SpringBeanJobFactory and implements ApplicationContextAware.

Then it was defined bean SpringBeanJobFactory in class with scheduler configuration [CronTasksConfig](https://github.com/strongbox/strongbox/blob/master/strongbox-cron-tasks/src/main/java/org.carlspring.strongbox/cron/config/CronTasksConfig.java) and setted it ApplicationContext.
It was attached to class SchedulerFactoryBean. 

And we get scheduler factory with DI support for @Autowired. 

### Run the cron tests

The cron tests are executed only under special spring active profile that we can see in created annotation [@CronTaskTest](https://github.com/strongbox/strongbox/blob/master/strongbox-cron-tasks/src/test/java/org.carlspring.strongbox.cron/context/CronTaskTest.java):

    @IfProfileValue(name = "spring.profiles.active", values = { "quartz-integration-test" }).

This annotation [@CronTaskTest](https://github.com/strongbox/strongbox/blob/master/strongbox-cron-tasks/src/test/java/org.carlspring.strongbox.cron/context/CronTaskTest.java) is needed to use in all cron tests.

So, all cron tests aren't  executed when the project is builded.

We need to add **-Dspring.profiles.active=quartz-integration-test** for running cron tests during the building of the project:

    mvn clean install -Dspring.profiles.active=quartz-integration-test 

### Create a new cron job

// TODO: Explain the process of creating a new cron job

### Define the cron variables/properties when implementing a new cron task

// TODO: Explain how to define the cron variables/properties when implementing a new cron task

# See Also
* [[Maven Metadata]]
* [[Maven Indexer]]
* [[REST API]]
* [[Storages]]
* [[Repositories]]
