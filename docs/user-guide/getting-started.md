# Getting started (User)

## Pre-requisites

* OpenJDK 1.8
* Set the `JAVA_HOME` variable to point to your Java installation.
* Set the `PATH` variable to include `$JAVA_HOME/bin`.

## Installation

<a href="https://github.com/strongbox/strongbox/releases" target="_blank">Download strongbox</a>

```Linux linenums="1" tab=
# Open a terminal

sudo su

mkdir /opt/strongbox /opt/strongbox-vault

groupadd strongbox
useradd -d /opt/strongbox -g strongbox -r strongbox

chown -R strongbox:strongbox /opt/strongbox /opt/strongbox-vault

chmod -R 770 /opt/strongbox /opt/strongbox-vault

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
     {{resources}}/systemd/strongbox.service 
sudo systemctl deamon-reload
sudo service strongbox start

# this step is optional: only if you want to start Strongbox at boot!
sudo systemctl enable strongbox
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

```MacOS linenums="1" tab=
# Open a terminal

sudo su
sysadminctl -addUser strongbox

mkdir -p /opt/strongbox /opt/strongbox-vault

chown -R strongbox:staff /opt/strongbox /opt/strongbox-vault

chmod -R 770 /opt/strongbox /opt/strongbox-vault

su strongbox
tar -zxf /path/to/strongbox-distribution*.tar.gz \
    -C /opt/strongbox \ 
    --strip-components=2

# If you just want to start Strongbox without installing the launchctl service:

/opt/strongbox/bin/strongbox console

# If you want to install Strongbox as a LaunchDaemon then download the 
# plist file. If you've customized the installation, edit the details
# in the plist file where necessary.
# (This file must be owned by root.)
sudo curl -o /Library/LaunchDaemons/strongbox.plist \
     {{resources}}/launchctl/strongbox.plist

# This will validate that launchd can load the file and start the service.
sudo launchctl load /opt/strongbox/etc/strongbox.plist

# Strongbox will now start on boot.

```

```Docker linenums="1" tab=

Currently unavailable due to our heavy development.
We are planning to start releasing to hub.docker.com very soon.

Meanwhile, you could clone strongbox/strongbox 
use `docker-compose up` instead.
```


