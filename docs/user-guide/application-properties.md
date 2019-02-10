The following is a list of configuration properties, which can be used to customize your installation.

<div class="env" markdown="1">

### Strongbox

??? info "export STRONGBOX_HOME or <br> -Dstrongbox.home"

    The path in which `strongbox-distribution` is located.
    
    Can be passed as `-Dstrongbox.home` or set via the env variable `STRONGBOX_HOME` 
    
    | Type   | Default Value |
    |:------:|:-------------:|
    | String | `.`           |
    
    
??? info "export STRONGBOX_PORT or <br> -Dstrongbox.port"

    The port on which Strongbox will be running.

    Can be passed as `-Dstrongbox.port` or set via the env variable `STRONGBOX_PORT` 

    | Type   | Default Value | 
    |:------:|:-------------:|
    | Integer | 48080        | 



??? info "export STRONGBOX_VAULT or <br> -Dstrongbox.vault"

    The path in which the `strongbox-vault` will be kept. 
    This includes the database and repository storage(s).
    
    Can be passed as `-Dstrongbox.vault` or set via the env variable `STRONGBOX_VAULT` 

    
    | Type   | Default Value | 
    |:------:|:-------------:|
    | String | `${STRONGBOX_HOME}/../strongbox-vault` | 


??? info "export STRONGBOX_CONFIG_XML or <br> -Dstrongbox.config.xml"

    The path to the `strongbox.xml` file.
    
    Can be passed as `-Dstrongbox.config.xml` or set via the env variable `STRONGBOX_CONFIG_XML` 

    | Type   | Default Value | 
    |:------:|:-------------:|
    | String | `${STRONGBOX_HOME}/etc/conf/strongbox.xml` | 


??? info "export STRONGBOX_DOWNLOAD_INDEXES or <br> -Dstrongbox.download.indexes"

    Whether, or not to download the Maven indexes for remote repositories.

    Can be passed as `-Dstrongbox.download.indexes` or set via the env variable `STRONGBOX_DOWNLOAD_INDEXES` 

    
    | Type   | Default Value | 
    |:------:|:-------------:|
    | Boolean | true         | 


??? info "export STRONGBOX_DOWNLOAD_INDEXES_\${storageId}\_\* or <br> -Dstrongbox.download.indexes_\${storageId}_*"

    Whether, or not to download the Maven indexes for all remote repositories in the `$storageId`.
    
    Can be passed as `-Dstrongbox.download.indexes_${storageId}_*` or set via the env variable `STRONGBOX_DOWNLOAD_INDEXES_${storageId}_*`     
    
    | Type   | Default Value | 
    |:------:|:-------------:|
    | boolean | true         | 


??? info "export STRONGBOX_DOWNLOAD_INDEXES_\${storageId}\_\${repositoryId} or <br> -Dstrongbox.download.indexes_\${storageId}_\${repositoryId}"

    Whether, or not to download the Maven indexes for a remote repository in a storage. 
    If this is explicitly defined and `strongbox.download.indexes` and/or `strongbox.download.indexes.${storageId}.*` is defined, 
    then the value specified by this option will override the others.

    Can be passed as `-Dstrongbox.download.indexes_\${storageId}_*` or set via the env variable `STRONGBOX_DOWNLOAD_INDEXES_\${storageId}_\${repositoryId}`     
    
    | Type   | Default Value | 
    |:------:|:-------------:|
    | boolean | true         | 

---

### OrientDB

??? info "export STRONGBOX_ORIENTDB_HOST or <br> -Dstrongbox.orientdb.host"

    The host of OrientDB server.
    
    Can be passed as `-Dstrongbox.orientdb.host` or set via the env variable `STRONGBOX_ORIENTDB_HOST`     

    | Type   | Default Value | 
    |:------:|:-------------:|
    | String | 127.0.0.1     | 



??? info "export STRONGBOX_ORIENTDB_PORT or <br> -Dstrongbox.orientdb.port"

    The port of OrientDB server.
    
    Can be passed as `-Dstrongbox.orientdb.port` or set via the env variable `STRONGBOX_ORIENTDB_PORT`     

    | Type   | Default Value | 
    |:------:|:-------------:|
    | Integer | 2424         | 

??? info "export STRONGBOX_ORIENTDB_DATABASE or <br> -Dstrongbox.orientdb.database"

    The name of the OrientDB database.
    
    Can be passed as `-Dstrongbox.orientdb.database` or set via the env variable `STRONGBOX_ORIENTDB_DATABASE`     

    | Type   | Default Value | 
    |:------:|:-------------:|
    | String | strongbox     | 


??? info "export STRONGBOX_ORIENTDB_USERNAME or <br> -Dstrongbox.orientdb.username"

    The username to use when connecting to OrientDB.
    
    Can be passed as `-Dstrongbox.orientdb.username` or set via the env variable `STRONGBOX_ORIENTDB_USERNAME`     

    | Type   | Default Value | 
    |:------:|:-------------:|
    | String | admin         | 


??? info "export STRONGBOX_ORIENTDB_PASSWORD or <br> -Dstrongbox.orientdb.password"

    The password to use when connecting to OrientDB.
    
    Can be passed as `-Dstrongbox.orientdb.password` or set via the env variable `STRONGBOX_ORIENTDB_PASSWORD`     

    | Type   | Default Value | 
    |:------:|:-------------:|
    | String | admin         | 


??? info "export STRONGBOX_ORIENTDB_PROFILE or <br> -Dstrongbox.orientdb.profile"

    OrientDB mode (`orientdb_EMBEDDED`,`orientdb_MEMORY` or `orientdb_REMOTE`)

    Can be passed as `-Dstrongbox.orientdb.profile` or set via the env variable `STRONGBOX_ORIENTDB_PROFILE`     
    
    | Type   | Default Value     | 
    |:------:|:-----------------:|
    | String | orientdb_EMBEDDED | 


??? info "export STRONGBOX_ORIENTDB_STUDIO_ENABLED or <br> -Dstrongbox.orientdb.studio.enabled"

    Enable OrientDB Web Studio
    
    Can be passed as `-Dstrongbox.orientdb.studio.enabled` or set via the env variable `STRONGBOX_ORIENTDB_STUDIO_ENABLED`     

    | Type    | Default Value | 
    |:-------:|:-------------:|
    | Boolean | false         | 



??? info "export STRONGBOX_ORIENTDB_STUDIO_IP_ADDRESS or <br> -Dstrongbox.orientdb.studio.ip.address"

    IP address, which OrientDB Web Studio will be listening

    Can be passed as `-Dstrongbox.orientdb.studio.ip.address` or set via the env variable `STRONGBOX_ORIENTDB_STUDIO_IP_ADDRESS`     
    
    | Type   | Default Value | 
    |:------:|:-------------:|
    | String | 127.0.0.1     | 



??? info "export STRONGBOX_ORIENTDB_STUDIO_PORT or <br> -Dstrongbox.orientdb.studio.port"

    Port, on which OrientDB Web Studio will be listening
    
    Can be passed as `-Dstrongbox.orientdb.studio.port` or set via the env variable `STRONGBOX_ORIENTDB_STUDIO_PORT`     

    | Type   | Default Value | 
    |:------:|:-------------:|
    | Integer | 2480         | 


---
</div>
