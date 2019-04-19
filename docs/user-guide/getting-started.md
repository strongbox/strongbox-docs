## Pre-requisites

* OpenJDK 1.8
* Set the `JAVA_HOME` variable to point to your Java installation.
* Set the `PATH` variable to include `$JAVA_HOME/bin`.

## Installation

<a href="https://github.com/strongbox/strongbox/releases" target="_blank">Download strongbox</a>

```Linux (tar) linenums="1" tab=
# Open a terminal

sudo su
mkdir /opt/{strongbox,strongbox-vault}
groupadd strongbox
useradd -d /opt/strongbox -g strongbox -r strongbox
chown -R strongbox:strongbox /opt/{strongbox,strongbox-vault}
chmod -R 770 /opt/{strongbox,strongbox-vault}
su strongbox
tar -zxf /path/to/strongbox-distribution*.tar.gz \
    -C /opt/strongbox \ 
    --strip-components=2

# If you just want to start Strongbox without installing the systemd service:

/opt/strongbox/bin/strongbox console

# If you want to install Strongbox as a service then download the 
# systemd service file. Make sure to change the `Environment` variables 
# in the service file where necessary. Depending on your distribution, 
# you could also move the environment variables into `EnvironmentFile` 
# and load that instead.

sudo curl -o /etc/systemd/system/strongbox.service \
     https://strongbox.github.io/assets/resources/systemd/strongbox.service 
sudo systemctl deamon-reload
sudo service strongbox start

# this step is optional: only if you want to start Strongbox at boot!
sudo systemctl enable strongbox
```

```Linux (RPM) linenums="1" tab=
# Open a terminal

sudo rpm -ivh /path/to/strongbox-distribution-*.rpm

# If you just want to start Strongbox without installing the systemd service:
su strongbox
/opt/strongbox/bin/strongbox console

# If you want to configure strongbox to start at system, boot:

sudo systemctl enable strongbox.service
sudo service strongbox start

```

```Windows linenums="1" tab=

# Unzip the distribution.

# To start Strongbox, run cmd or PowerShell and execute:
c:\java\strongbox> bin\strongbox.bat console
      wrapper   | Strongbox: Distribution started...

# To install Strongbox as a service, run cmd or PowerShell and execute:
c:\java\strongbox> bin\strongbox.bat install
      wrapper  | Strongbox: Distribution installed.
c:\java\strongbox> bin\strongbox.bat start

```

```Docker linenums="1" tab=

Currently unavailable due to our heavy development.
We are planning to start releasing to hub.docker.com very soon.

Meanwhile, you could clone strongbox/strongbox 
use `docker-compose up` instead.
```


!!! info "Help wanted!"

    We would like to add instructions for MacOS. If you're interested in giving us a hand, please have a look at <a href="https://github.com/strongbox/strongbox/issues/1008">strongbox/strongbox#1008</a>
