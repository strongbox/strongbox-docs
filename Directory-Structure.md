# The Application's Configuration

The server's configuration files reside under the `strongbox` directory.

* strongbox/
  * etc/
    * conf/
      * strongbox.xml
      * security-authentication.xml
      * security-authorization.xml
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
  * storages/
  * tmp/
