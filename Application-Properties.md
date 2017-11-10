The following is a list of configuration properties, which can be used to customize your installation.

| Property   |   Type   | Default Value | Description | 
|:-----------|:--------:|:-------------:|-------------|
| repository.config.xml | String | `etc/conf/strongbox.xml` | The path to the `strongbox.xml` file. |
| strongbox.download.indexes | boolean | true | Whether, or not to download the Maven indexes for remote repositories. |
| strongbox.download.indexes.${storageId}.${repositoryId} | boolean | true | Whether, or not to download the Maven indexes for a remote repository in a storage. If this is explicitly defined and `strongbox.download.indexes` and/or `strongbox.download.indexes.${storageId}.*` is defined, then the value specified by this option will override the others. |
| strongbox.download.indexes.${storageId}.* | boolean | true | Whether, or not to download the Maven indexes for all remote repositories in a storage. |
| strongbox.home | String |  |  |
| strongbox.port | Integer | 48080 | The port on which Strongbox will be running. | 
| strongbox.vault | String |  |  |
| strongbox.storage.booter.basedir | String |  |  |
| strongbox.storage.booter.storages.basedir | String |  |  |
| strongbox.orientdb.host | String | 127.0.0.1 | The host for OrientDB. |
| strongbox.orientdb.port | Integer | 2424 | The port for OrientDB. |
| strongbox.orientdb.database | String | strongbox | The name of the OrientDB database. |
| strongbox.orientdb.username | String | admin | The admin username for OrientDB. |
| strongbox.orientdb.password | String | password | The password for OrientDB. |
