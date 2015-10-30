
# Pre-requisites:
* Java 1.8
* Set the `JAVA_HOME` variable to point to your Java installation.
* Set the `PATH` variable to include `$JAVA_HOME/bin`.

# Linux

* Install:

    ```
    sudo su -
    mkdir /usr/local/strongbox
    groupadd strongbox
    useradd -d /usr/local/strongbox -g strongbox strongbox
    
    chown -R strongbox:strongbox /usr/local/strongbox/
    chmod 770 /usr/local/strongbox/
    
    su - strongbox
    tar -zxf /path/to/strongbox-distribution*.tar.gz \
        -C /usr/local/strongbox --strip-components=1
    ln -s /usr/local/strongbox/bin/wrapper-linux-x86-64 \
        /usr/local/strongbox/bin/wrapper
    ```

* Setup
  * Setup Script Variables (in $STRONGBOX_HOME/bin/strongbox):
    * Set the `STRONGBOX_HOME` variable to point to your installation of strongbox (this would normally be `/usr/local/strongbox`).
    * Set the `RUN_AS_USER` variable to `strongbox`. Please, note that if you do not make this change, you may be taking a serious security risk.
  * Create a service
    * CentOs, Redhat, Suse
    ```
    $ sudo su -
    $ cd /etc/init.d/
    $ ln -s /usr/local/strongbox/bin/strongbox /etc/init.d/
    $ chkconfig --add strongbox
    $ service strongbox start
    $ tail -F /usr/local/strongbox/logs/wrapper.log
    ```

    * **[TODO]:** Debian, Ubuntu

# Windows
* Unzip the distribution.
* Install the service:

    ```
    c:\java\strongbox>bin\strongbox.bat install
    wrapper  | Strongbox: Distribution installed.
    c:\java\strongbox>bin\strongbox.bat start
    ```