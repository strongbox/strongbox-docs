
# Pre-requisites:
* Java 1.8
* Set JAVA_HOME to point to your Java installation.

# Linux

* Install:

    ```
    sudo su -
    groupadd strongbox
    useradd -d /usr/local/strongbox -g strongbox strongbox
    
    mkdir /usr/local/strongbox
    chown -R strongbox:strongbox /usr/local/strongbox/
    
    su - strongbox
    tar -zxf /path/to/strongbox-distribution*.tar.gz -C /usr/local/strongbox --strip-components=1
    ln -s /usr/local/strongbox/bin/wrapper-linux-x86-64 /usr/local/strongbox/bin/wrapper
    ```

* Setup
 * Setup Script Variables (in $STRONGBOX_HOME/bin/strongbox):
   * Set the `STRONGBOX_HOME` variable to point to your installation of strongbox (this would normally be `/usr/local/strongbox`).
    * Set the `RUN_AS_USER` variable to `strongbox`.

