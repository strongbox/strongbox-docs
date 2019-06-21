# Application Properties

The following is a list of configuration properties, which can be used to customize your installation.
Each of these properties can be set either by exporting a variable or passing it as a property via `-D`.  
  
!!! tip "Tip" 
    Environment variables are in the format `STRONGBOX_SOME_PROPERTY=value`, however properties are in lower case and each `_` is replaced with `.` so that it becomes `-Dstrongbox.some.property=value` 

<div class="env" markdown="1">

### Generic properties

#### STRONGBOX_HOME

The path in which `strongbox-distribution` is located.

| Type      | Default |
|:--------- |:------- |
| `String`  | `.`     |

#### STRONGBOX_PORT

The port on which Strongbox will be running.

| Type      | Default   |
|:--------- |:--------- |
| `Integer` | `48080`   |  


#### STRONGBOX_VAULT

The path in which the `strongbox-vault` will be kept. This includes the database and repository storage(s). 

| Type      | Default   |
|:--------- |:--------- |
| `String`  | `${STRONGBOX_HOME}/../strongbox-vault` |

#### STRONGBOX_CONFIG_FILE 

The path to the `strongbox.yaml` file. 

| Type      | Default   |
|:--------- |:--------- |
| `String`  | `${STRONGBOX_HOME}/etc/conf/strongbox.yaml` | 

#### STRONGBOX_JVM_XMX

Specify the maximum size of the memory allocation pool.

| Type      | Default   |
|:--------- |:--------- |
| `String`  | `512m`    |
    
### Indexing properties

#### STRONGBOX_DOWNLOAD_INDEXES

Whether, or not to download the Maven indexes for remote repositories.

| Type      | Default   |
|:--------- |:--------- |
| `Boolean` | `true`    | 

##### STRONGBOX_DOWNLOAD_INDEXES_\${storageId}_*

Whether, or not to download the Maven indexes for all remote repositories in the `$storageId` 

| Type      | Default   |
|:--------- |:--------- |
| `Boolean` | `true`    | 

##### STRONGBOX_DOWNLOAD_INDEXES_\${storageId}_\${repositoryId}

Whether, or not to download the Maven indexes for a remote repository in a storage. 
If this is explicitly defined and `strongbox.download.indexes` and/or `strongbox.download.indexes.${storageId}.*` is defined, 
then the value specified by this option will override the others.

| Type      | Default   |
|:--------- |:--------- |
| `Boolean` | `true`    | 

### Logging properties

These properties are used for configuring the logging - should logs be printed to the console, logged to a file or both?

#### STRONGBOX_DEBUG

When set to `true`, Strongbox will output debugging information.

| Type      | Default   |
|:--------- |:--------- |
| `Boolean` | `false` when using `strongbox-distribution`; <br>`true` when running via `mvn spring-boot:run` | 

#### STRONGBOX_LOG_CONSOLE_ENABLED

When set to `true`, Strongbox will output the logs to the console

| Type      | Default   |
|:--------- |:--------- |
| `Boolean` | `false` when using `strongbox-distribution`; <br>`true` when running via `mvn spring-boot:run` |

#### STRONGBOX_LOG_FILE_ENABLED

When set to `true`, Strongbox will save the logs into log files under `./strongbox-vault/logs`. 

##### STRONGBOX_LOG_FILE_SIZE_SINGLE

The maximum file size of one log file.

| Type      | Default   |
|:--------- |:--------- |
| `String`  | `128M`    |

##### STRONGBOX_LOG_FILE_SIZE_TOTAL

The maximum size of all log files.

| Type      | Default   |
|:--------- |:--------- |
| `String`  | `1GB`     | 

##### STRONGBOX_LOG_FILE_HISTORY

The maximum number of log files to keep.

| Type      | Default   |
|:--------- |:--------- |
| `Integer` | `31`      | 

### OrientDB properties

#### STRONGBOX_ORIENTDB_HOST

The host of OrientDB server. 

| Type      | Default     |
|:--------- |:----------- |
| `String`  | `127.0.0.1` | 

#### STRONGBOX_ORIENTDB_PORT

The port of OrientDB server.

| Type      | Default     |
|:--------- |:----------- |
| `Integer` | `2424`      | 

#### STRONGBOX_ORIENTDB_DATABASE

The name of the OrientDB database.

| Type      | Default     |
|:--------- |:----------- |
| `String`  | `strongbox` | 

#### STRONGBOX_ORIENTDB_USERNAME

The username to use when connecting to OrientDB.

| Type      | Default     |
|:--------- |:----------- |
| `String`  | `admin`     | 

#### STRONGBOX_ORIENTDB_PASSWORD

The password to use when connecting to OrientDB.

| Type      | Default     |
|:--------- |:----------- |
| `String`  | `admin`     | 

#### STRONGBOX_ORIENTDB_PROFILE

OrientDB mode (`orientdb_EMBEDDED`,`orientdb_MEMORY` or `orientdb_REMOTE`)

| Type      | Default     |
|:--------- |:----------- |
| `String`  | `orientdb_EMBEDDED` | 

#### OrientDB Studio 

##### STRONGBOX_ORIENTDB_STUDIO_ENABLED

Enable OrientDB Web Studio
    
| Type      | Default     |
|:--------- |:----------- |
| `Boolean` | `false`     | 

##### STRONGBOX_ORIENTDB_STUDIO_IP_ADDRESS

IP address, which OrientDB Web Studio will be listening
    
| Type      | Default     |
|:--------- |:----------- |
| `String`  | `127.0.0.1` | 

##### STRONGBOX_ORIENTDB_STUDIO_PORT

Port, on which OrientDB Web Studio will be listening

| Type      | Default     |
|:--------- |:----------- |
| `Integer` | `2480`      | 

</div>
