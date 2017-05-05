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

## Remove Timestamped Maven Snapshot Artifacts

This cron task can perform cleanups of time-stamped snapshot builds.

The cron task is be able to remove all timestamped artifacts based on the following rules:
* **numberToKeep** : The number of artifacts to keep. For example, if this is set to 2, versions 1, 2  and 3  will be removed and only the last two (4  and 5) preserved.
* **keepPeriod** : The period to keep artifacts

The number of artifacts to keep takes precedence, ensuring that the **numberToKeep** are preserved.

## Remove Released Snapshots

This task checks which artifacts have been released and can be removed from the respective snapshot repository.

## Regenerate Checksums

This task can be useful, in cases where an artifact has been copied to (or altered) manually on the file system and there are no checksum, or the checksum has become invalid.

# Information For Developers

## Location Of The Code
The code for the cron tasks is located under the [strongbox-cron-tasks](https://github.com/strongbox/strongbox/tree/master/strongbox-cron-tasks) module.

The base cron implementation classes are:
* [`JavaCronJob`](https://github.com/strongbox/strongbox/blob/master/strongbox-cron-tasks/src/main/java/org.carlspring.strongbox/cron/api/jobs/JavaCronJob.java)
* [`GroovyCronJob`](https://github.com/strongbox/strongbox/blob/master/strongbox-cron-tasks/src/main/java/org.carlspring.strongbox/cron/api/jobs/GroovyCronJob.java)

## Implementing Cron Tasks

### Implementing a Java Cron Task

To create a Java based cron task you will need to extend the [JavaCronJob](https://github.com/strongbox/strongbox/blob/4c54d8884768d816f69ad53f6d4616de723de246/strongbox-cron-tasks/src/main/java/org/carlspring/strongbox/cron/api/jobs/JavaCronJob.java) class and override the `executeInternal()` method.

    public class MyTask
            extends JavaCronJob
    {
    
        private final Logger logger = LoggerFactory.getLogger(MyTask.class);
    
        @Override
        protected void executeInternal(JobExecutionContext jobExecutionContext)
                throws JobExecutionException
        {
            logger.debug("My cron task is working");
        }
        
    }

### Implementing a Groovy Cron Task

To create a Groovy based cron task, you will need to save a cron configuration without any job class, and then upload the Groovy script under that name.

## Notes

### Support For Spring Dependency Injection in Quartz Jobs

As Quartz doesn't know anything about Spring dependency injection and we need to be able to autowire Spring beans in Quartz job classes, we created a custom job factory called [`AutowiringSpringBeanJobFactory`](https://github.com/strongbox/strongbox/blob/master/strongbox-cron-tasks/src/main/java/org.carlspring.strongbox/cron/config/AutowiringSpringBeanJobFactory.java) to autowire Quartz objects using Spring under the hood. This class extends `SpringBeanJobFactory` and implements `ApplicationContextAware`.

In addition, we defined a `SpringBeanJobFactory` in the [`CronTasksConfig`](https://github.com/strongbox/strongbox/blob/master/strongbox-cron-tasks/src/main/java/org.carlspring.strongbox/cron/config/CronTasksConfig.java) and set it's `ApplicationContext`, which is then passed on to the `SchedulerFactoryBean`.

This is how we implemented a scheduler factory with dependency injection support for `@Autowired`.

### How To Execute The Cron Tests

The cron tests are not executed by default when the project is built. They are only executed only under a special Spring active profile which is defined in the [`@CronTaskTest`](https://github.com/strongbox/strongbox/blob/master/strongbox-cron-tasks/src/test/java/org.carlspring.strongbox.cron/context/CronTaskTest.java) annotation:

    @IfProfileValue(name = "spring.profiles.active", values = { "quartz-integration-tests" })

All cron tests need to be marked with this annotation.

The Spring profile can be enabled like this:

    mvn clean install -Dspring.profiles.active=quartz-integration-tests 

### How To Create A New Cron Job

Cron jobs need to extend the [`JavaCronJob`](https://github.com/strongbox/strongbox/blob/master/strongbox-cron-tasks/src/main/java/org.carlspring.strongbox/cron/api/jobs/JavaCronJob.java) class and override the `executeInternal(JobExecutionContext jobExecutionContext)` function.

Every cron job runs in a separate thread. As we need to know the outcome of the job while testing, we use the [`JobManager`](https://github.com/strongbox/strongbox/blob/master/strongbox-cron-tasks/src/main/java/org.carlspring.strongbox/cron/config/JobManager.java) class in all the cron jobs for saving the name of executed job.    

### Defining Cron Variables/Properties When Implementing A New Cron Task

Settings for cron tasks can be defined by adding a [`CronTaskConfiguration`](https://github.com/strongbox/strongbox/blob/master/strongbox-cron-tasks/src/main/java/org.carlspring.strongbox/cron/domain/CronTaskConfiguration.java) to your implementation class.

The properties of cron task are stored in the **Map<String, String> properties** field of the [CronTaskConfiguration](https://github.com/strongbox/strongbox/blob/master/strongbox-cron-tasks/src/main/java/org.carlspring.strongbox/cron/domain/CronTaskConfiguration.java) class:

 * **k** is the name of the property
 * **v** is the value of the property
 
We need to get object of class [`CronTaskConfiguration`](https://github.com/strongbox/strongbox/blob/master/strongbox-cron-tasks/src/main/java/org.carlspring.strongbox/cron/domain/CronTaskConfiguration.java) from the job context in all job classes:

    CronTaskConfiguration config = (CronTaskConfiguration) jobExecutionContext.getMergedJobDataMap().get("config");

This way we can get any property of a cron task by looking it up by it's name:

    config.getProperty("name");


# See Also
* [[Maven Metadata]]
* [[Maven Indexer]]
* [[REST API]]
* [[Storages]]
* [[Repositories]]
