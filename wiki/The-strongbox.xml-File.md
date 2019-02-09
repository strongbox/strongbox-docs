# General

This resource file describes the configuration of the server.

The property controlling this file is `repository.config.xml`. The default location for this resource is `etc/conf/strongbox.xml`.

The cases in which this file is required are:
* During the very first server launch when there is no data in the database
 * Upon the first launch, this resource is loaded from the classpath as the default resource.
 * If the `repository.config.xml` property has been specified, then the path to that resource will be used instead.
* For a configuration import from another server
* For a configuration export of the server

# The Configuration File

The following is an example of a `strongbox.xml` configuration file:

    <configuration>
    
        <version>1.0</version>
    
        <baseUrl>http://localhost:48080/</baseUrl>
        <port>48080</port>
    
        <storages>
            <storage id="storage0">
                <repositories>
                    <repository id="releases" policy="release" implementation="file-system" layout="Maven 2" type="hosted" allows-force-deletion="true" checksum-headers-enabled="true"/>
                    <repository id="releases-with-redeployment" policy="release" implementation="file-system" layout="Maven 2" type="hosted" allows-redeployment="true" indexing-enabled="false"/>
                    <repository id="releases-with-trash" policy="release" implementation="file-system" layout="Maven 2" type="hosted" trash-enabled="true" allows-redeployment="true"/>
                    <repository id="releases-without-deployment" policy="release" implementation="file-system" layout="Maven 2" type="hosted" allows-deployment="false" indexing-enabled="false"/>
                    <repository id="releases-without-redeployment" policy="release" implementation="file-system" layout="Maven 2" type="hosted" allows-deployment="false" indexing-enabled="false"/>
                    <repository id="releases-without-delete" policy="release" implementation="file-system" layout="Maven 2" type="hosted" allows-delete="false" indexing-enabled="false"/>
                    <repository id="releases-without-delete-trash" policy="release" implementation="file-system" layout="Maven 2" type="hosted" trash-enabled="true" allows-delete="false" indexing-enabled="false"/>
                    <repository id="releases-without-browsing" policy="release" implementation="file-system" layout="Maven 2" type="hosted" allows-directory-browsing="false" indexing-enabled="false"/>
    
                    <repository id="snapshots" policy="snapshot" implementation="file-system" layout="Maven 2" type="hosted" secured="true" checksum-headers-enabled="true"/>
    
                    <repository id="proxied-releases" policy="release" implementation="proxy" layout="Maven 2" type="proxy">
                        <proxy-configuration host="localhost" port="8180" username="testuser" password="password" />
                        <remote-repository url="http://localhost:48080/storages/storage0/releases/"
                                           username="maven"
                                           password="password"
                                           download-remote-indexes="true"
                                           auto-blocking="true"
                                           checksum-validation="true" />
                    </repository>
    
                    <repository id="group-releases" policy="release" implementation="file-system" layout="Maven 2" type="group" secured="true">
                        <group>
                            <repository>releases</repository>
                            <repository>releases-with-redeployment</repository>
                            <repository>releases-with-trash</repository>
                            <repository>releases-without-deployment</repository>
                            <repository>releases-without-redeployment</repository>
                            <repository>releases-without-delete</repository>
                            <repository>releases-without-delete-trash</repository>
                            <repository>releases-without-browsing</repository>
                        </group>
                    </repository>
                </repositories>
            </storage>
            <storage id="storage-common-proxies">
                <repositories>
                    <repository id="maven-central" policy="release" implementation="file-system" layout="Maven 2" type="proxy">
                        <remote-repository url="https://repo.maven.apache.org/maven2/"
                                           download-remote-indexes="true"
                                           auto-blocking="true"
                                           checksum-validation="true" />
                    </repository>
    
                    <repository id="apache-snapshots" policy="snapshot" implementation="file-system" layout="Maven 2" type="proxy">
                        <remote-repository url="https://repository.apache.org/snapshots/"
                                           download-remote-indexes="true"
                                           auto-blocking="true"
                                           checksum-validation="true" />
                    </repository>
    
                    <repository id="jboss-public-releases" policy="release" implementation="file-system" layout="Maven 2" type="proxy">
                        <remote-repository url="http://repository.jboss.org/nexus/content/groups/public-jboss/"
                                           download-remote-indexes="true"
                                           auto-blocking="true"
                                           checksum-validation="true" />
                    </repository>
    
                    <repository id="group-common-proxies" policy="release" implementation="file-system" layout="Maven 2" type="group" secured="true">
                        <group>
                            <repository>maven-central</repository>
                            <repository>apache-snapshots</repository>
                            <repository>jboss-public-releases</repository>
                        </group>
                    </repository>
                </repositories>
            </storage>
            <storage id="storage-third-party">
                <repositories>
                    <repository id="third-party" policy="release" implementation="file-system" layout="Maven 2" type="hosted" allows-force-deletion="true" checksum-headers-enabled="true" />
                </repositories>
            </storage>
    
            <storage id="public">
                <repositories>
                    <repository id="public-group" policy="mixed" implementation="group" layout="Maven 2" type="group" secured="true">
                        <group>
                            <repository>storage-common-proxies:group-common-proxies</repository>
                            <repository>storage-springsource-proxies:springsource-proxies</repository>
                            <repository>storage-third-party:third-party</repository>
                        </group>
                    </repository>
                </repositories>
            </storage>
        </storages>
    
        <routing-rules>
            <accepted>
                <rule-set group-repository="group-releases">
                    <rule pattern=".*(com|org)/artifacts.in.releases.with.trash.*">
                        <repositories>
                            <repository>releases-with-trash</repository>
                            <repository>releases-with-redeployment</repository>
                        </repositories>
                    </rule>
                </rule-set>
                <rule-set group-repository="*">
                    <rule pattern=".*(com|org)/artifacts.in.releases.*">
                        <repositories>
                            <repository>releases</repository>
                        </repositories>
                    </rule>
                </rule-set>
            </accepted>
            <denied>
                <rule-set group-repository="*">
                    <rule pattern=".*(com|org)/artifacts.denied.by.wildcard.*">
                        <repositories>
                            <repository>releases</repository>
                        </repositories>
                    </rule>
                </rule-set>
            </denied>
        </routing-rules>
    </configuration>


# Information for Developers

The following classes are related to various aspects of the configuration:

| Class Name  | Description | 
|:------------|-------------|
| [`org.carlspring.strongbox.configuration.Configuration`](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-api/src/main/java/org/carlspring/strongbox/configuration/Configuration.java) | Represents to configuration in a serializable form. |
| [`org.carlspring.strongbox.configuration.ConfigurationManager`](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-api/src/main/java/org/carlspring/strongbox/configuration/ConfigurationManager.java) | Utility class for handling serialization and deserialization in XML form. | 
| [`org.carlspring.strongbox.configuration.ConfigurationRepository`](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-api/src/main/java/org/carlspring/strongbox/configuration/ConfigurationRepository.java) | Repository class for handling CRUD operations against OrientDB. |

The [strongbox.xml](https://github.com/strongbox/strongbox/blob/master/strongbox-resources/strongbox-storage-resources/strongbox-storage-api-resources/src/main/resources/etc/conf/strongbox.xml), which is packaged in the distribution, is located under the [strongbox-storage-api-resources](https://github.com/strongbox/strongbox/blob/master/strongbox-resources/strongbox-storage-resources/strongbox-storage-api-resources/)'s `src/main/resources/etc/conf` directory.

# See Also
* [[Artifact Routing Rules]]
