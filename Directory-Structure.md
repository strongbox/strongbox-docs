# The Server's Configuration

The server's configuration files reside under the `strongbox` directory.

* strongbox/
  * etc/
    * conf/
      * [strongbox.xml](https://github.com/strongbox/strongbox/wiki/The-strongbox.xml-File)
      * security-authentication.xml
      * security-authorization.xml
      * security-users.xml
    * jetty/
      * jetty.xml
      * jetty-http.xml
      * jetty-https.xml
      * jetty-ssl.xml
    * ssl/
      * keystores.jks
      * localhost-client.cer
      * truststore.jks
   * logback.xml

# The Vault

The vault is the work area of the server. This includes things like the cache, location of the OrientDB files, storages and temporary directory reside.

* strongbox-vault/
  * cache/
  * db/
  * [storages](https://github.com/strongbox/strongbox/wiki/Storages)/
    * ${storageId}/
      * ${repositoryId}/
        * [.index/](https://github.com/strongbox/strongbox/wiki/Maven-Indexer#where-are-the-maven-indexes-located)
        * .trash/
  * tmp/
