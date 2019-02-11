## Strongbox Distribution

When you download and extract `strongbox-distribution.tar.gz` you will find the following directory structure:

### Directory structure

* `strongbox-distribution/`
    * `etc/conf` - all configuration files will be in this path. 
        * [strongbox.xml](https://github.com/strongbox/strongbox/wiki/The-strongbox.xml-File) (TODO: fix link)
        * security-authentication.xml (TODO: fix link; update after SB-1285)
        * security-authorization.xml (TODO: fix link; update after SB-1285)
        * [strongbox-security-users.xml](https://github.com/strongbox/strongbox/wiki/The-strongbox%E2%80%90security%E2%80%90users.xml-File) (TODO: fix link; SB-1285)
    * `jetty/`
        * `jetty.xml`
        * `jetty-http.xml`
        * `jetty-https.xml`
        * `jetty-ssl.xml`
    * `ssl/`
        * `keystores.jks`
        * `localhost-client.cer`
        * `truststore.jks`
    * `logback.xml` - default logback with info level settings. 
    * `logback-debug.xml` - debug level logback settings, use with caution as logs will be big.

## Strongbox Vault

The vault is the work area of the server. This includes things like the cache, location of the OrientDB files, 
storages and temporary directory. You can find this directory right next to where `strongbox-distribution` is located 
(in other words - `strongbox-distribution/../strongbox-vault`). Check the [Application Properties](/user-guide/application-properties.md) 
section to see which property to override to change the default location.

### Directory structure

* `strongbox-vault/`
    * `cache/`
    * `db/`
    * [storages](/knowledge-base/storages/)/
        * `${storageId}/`
            * `${repositoryId}/`
                * [.index/](https://github.com/strongbox/strongbox/wiki/Maven-Indexer#where-are-the-maven-indexes-located) (TODO: fix link)
                * `local/`
                * `remote/`
            * `.trash/`
    * `tmp/`
