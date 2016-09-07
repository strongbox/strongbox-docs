# General

The project contains a `Dockerfile` in the root directory. This `Dockerfile` prepares an instance of `OpenSuse 42.1` with a required minimum of OS binaries. It is set up to:
* Contain the latest 1.8.x JDK
* Contain Maven 3.3.9 (properly set up on the path with the latest settings.xml for the project)
* Expose port 48080
* Map your local `/usr/src/strongbox` (on the host OS) to `/usr/src/strongbox` (on the guest); (it would be best to add a symlink for this on your host operating system)
* Have a properly set up and permissioned installation of `Strongbox` under `/usr/local/strongbox`
* Have a start up script under `/etc/init.d/strongbox`; (please, note that the service is not started by default, as it would otherwise not be possible to build the code while it's running)

# Docker Commands

Get Opensuse

    docker pull opensuse

List the available images on the system

    docker images

Create a tag for the current Dockerfile

    docker build -t strongbox/standalone:master .

Run the master's standalone

    docker run -it -p 127.0.0.1:18080:48080 strongbox/standalone:master strongbox/standalone /bin/bash

# See Also:

* [Managing data volumes](https://docs.docker.com/engine/tutorials/dockervolumes/)
* [Dockefile OpenSuse](http://dockerfile.github.io/#/opensuse)