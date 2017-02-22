## What is stored in the Maven metadata?

The `maven-metadata.xml` file is a place where Maven stores basic information about artifacts. It can contain useful data such as, for example:

- Which timestamped artifact file represents the current `SNAPSHOT` artifact
- What the latest deployed version of an artifact is
- What the most recent released version of an artifact is
- What plugins can be found under a `groupId`
- What other artifacts (apart from the main one) have been deployed to the repository (along with their extensions)

## What types of metadata are there and where are they stored?

- `artifactId` level `maven-metadata.xml` (located under, for example: `org/carlspring/strongbox/metadata-example/maven-metadata.xml`). This is used for storing the top-level versions of artifacts. For example, if an artifact has versions `1.0`, `1.1`, `1.2`, this `maven-metadata.xml` will only contain version information about them. Consider the following `maven-metadata.xml`:

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <metadata>
        <groupId>org.carlspring.strongbox</groupId>
        <artifactId>metadata-example</artifactId>
        <versioning>
            <latest>1.2</latest>
            <release>1.2</release>
            <versions>
                <version>1.0</version>
                <version>1.1</version>
                <version>1.2</version>
            </versions>
            <lastUpdated>20150509185437</lastUpdated>
        </versioning>
     </metadata>
     ```

- Artifact `version`-level `maven-metadata.xml` (located under, for example: `org/carlspring/strongbox/strongbox-metadata/2.0-SNAPSHOT/maven-metadata.xml`). This is used only for timestamped `SNAPSHOT` versioned artifacts. The purpose of this file is to contain a list of the existing timestamped artifacts, while at the same time specifying which one of them is the latest deployed one that should be used as the actual `SNAPSHOT` artifact to be resolved by Maven. The following is a brief example which illustrates the case where two timestamped `SNAPSHOT` artifacts have been deployed. Each deployment of an artifact increments the `<buildNumber/>` and updates the `<timestamp/>` fields.

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <metadata>
        <groupId>org.carlspring.strongbox</groupId>
        <artifactId>strongbox-metadata</artifactId>
        <version>2.0-SNAPSHOT</version>
        <versioning>
            <snapshot>
                <timestamp>20150508.221712</timestamp>
                <buildNumber>2</buildNumber>
            </snapshot>
            <lastUpdated>20150508221310</lastUpdated>
            <snapshotVersions>
                <snapshotVersion>
                    <classifier>javadoc</classifier>
                    <extension>jar</extension>
                    <value>2.0-20150508.220658-1</value>
                    <updated>20150508220658</updated>
                </snapshotVersion>
                <snapshotVersion>
                    <extension>jar</extension>
                    <value>2.0-20150508.220658-1</value>
                    <updated>20150508220658</updated>
                </snapshotVersion>
                <snapshotVersion>
                    <extension>pom</extension>
                    <value>2.0-20150508.220658-1</value>
                    <updated>20150508220658</updated>
                </snapshotVersion>
                <snapshotVersion>
                    <classifier>javadoc</classifier>
                    <extension>jar</extension>
                    <value>2.0-20150508.221205-2</value>
                    <updated>20150508221205</updated>
                </snapshotVersion>
                <snapshotVersion>
                    <extension>jar</extension>
                    <value>2.0-20150508.221205-2</value>
                    <updated>20150508221205</updated>
                </snapshotVersion>
                <snapshotVersion>
                    <extension>pom</extension>
                    <value>2.0-20150508.221205-2</value>
                    <updated>20150508221205</updated>
                </snapshotVersion>
            </snapshotVersions>
        </versioning>
    </metadata>
    ```

- `groupId`-level plugin information for plugins (located under, for example: `org/carlspring/maven/maven-metadata.xml`). This is a top-level `maven-metadata.xml` file containing a list of the available plugins under this `groupId`. This type of `maven-metadata.xml` file contains only `<plugins/>` and provides no version information.

   ```xml
    <metadata>
        <plugins>
            <plugin>
                <name>Maven Derby Plugin</name>
                <prefix>derby</prefix>
                <artifactId>derby-maven-plugin</artifactId>
            </plugin>
            <plugin>
                <name>LittleProxy Maven Plugin</name>
                <prefix>little-proxy</prefix>
                <artifactId>little-proxy-maven-plugin</artifactId>
            </plugin>
            <plugin>
                <name>Maven Artifact Relocation Plugin</name>
                <prefix>relocation</prefix>
                <artifactId>relocation-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </metadata>
    ```

When generating metadata, the following `maven-metadata.xml` files need to be produced for each of these cases:
- For artifacts with a released version (for example, `1.2.3`, `1.2.4`, etc), under the path to the artifact's root directory (for example, `org/carlspring/strongbox/metadata`), there needs to be a `maven-metadata.xml` containing the list of released versions.
- For artifacts with a `SNAPSHOT` version (for example, `1.2.3-SNAPSHOT`, `1.2.4-SNAPSHOT`, etc), under the path to the artifact's root directory (for example, `org/carlspring/strongbox/metadata`), there will need to be a `maven-metadata.xml` containing the list of `SNAPSHOT` versions. In addition to that, in each of the version directories, a separate `maven-metadata.xml` needs to exist, which, (as explained above), will contain a mapping of which timestamped artifacts have been deployed and which one of them represents the latest `SNAPSHOT`.
- For Maven plugins, under the plugin's `groupId` path there needs to be a `maven-metadata.xml` which lists all the plugins under this `groupId`. In addition, depending on whether this is a release or `SNAPSHOT` version, the same rules for artifacts apply, as explained above.


## What is the `latest` field used for?
The `<latest/>` field is used to point to the most-recently deployed (release, or `SNAPSHOT`) artifact. Please note, that this is not always necessarily the highest available version. For example, if you have several active branches under version control from which you're deploying versions of the artifact (for example `1.2` and `2.0` branches from which you respectively release artifacts with versions `1.2.1`, `1.2.2`, etc. and `2.0.1`, `2.0.2`), you may have the case where an artifact from the `1.2` branch been deployed while at the same time there is also a `2.0.3` version as well. Depending on the repository type, the `<latest/>` field may also be pointing to `SNAPSHOT` artifacts as well.

## What is the `release` field used for?
The `<release/>` field is used to point to the most-recently deployed release artifact. Please note, that this is not always necessarily the highest available version. For example, if you have several active branches under version control from which you're releasing and deploying versions of the artifact (for example `1.2` and `2.0` branches from which you respectively release artifacts with versions `1.2.1`, `1.2.2`, etc. and, respectively, 2.0.1`, `2.0.2`), you may have the case where an artifact from the `1.2` branch has been deployed while at the same time there is also a `2.0.3` version as well.

## What's the difference between `maven-metadata.xml` and `maven-metadata-xyz.xml`?
- In remote repositories, the metadata generated by Maven (and/or managed by the respective artifact repository manager) is stored in a `maven-metadata.xml` file.
- In local repositories, Maven stores the collected metadata from the remote server into a `maven-metadata-${repositoryServerId}.xml` file where `${repositoryServerId}` is the server id stored in your Maven [`settings.xml`](https://maven.apache.org/settings.html#Servers) (for example `<server><id>development-snapshots</id></server>`).

## What produces the `maven-metadata.xml` files and who manages it?
When you deploy an artifact to a remote repository, Maven will check if there is an existing `maven-metadata.xml` (of the respectively required type(s)) on the remote host. If the file(s) exist, Maven will use that data, merge the necessary changes into a new copy and then overwrite the data on the remote. If there is no existing `maven-metadata.xml` in the remote repository, Maven will generate a new one and deploy it.

Sometimes the data in the repository can become corrupt and this is when the repository manager needs to be told to rebuild it (or, alternatively, a scheduled task on the repository manager can take care of this to pre-emptively fix it). 

## What are the official resources on Maven metadata?
- [Maven Metadata: Introduction](http://maven.apache.org/ref/3.3.9/maven-repository-metadata/index.html)
- [Maven Metadata: Reference](http://maven.apache.org/ref/3.3.9/maven-repository-metadata/repository-metadata.html)
- [Maven Metadata: Javadocs](http://maven.apache.org/ref/3.3.9/maven-repository-metadata/apidocs/index.html)
- [Maven 3.x Compatibility Notes] (https://cwiki.apache.org/confluence/display/MAVEN/Maven+3.x+Compatibility+Notes) (contains various useful comments on behavioral changes in Maven 3.x, compared to 2.x).

# See Also
- [How does Maven plugin prefix resolution work? Why is it resolving “findbugs” but not “jetty”?](http://stackoverflow.com/a/40206597/774183)
