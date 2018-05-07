# Introduction

Docker is awesome and we are using it to build and test almost everything. 
It has proven to be quite fast and convenient way to easily reproduce issues.
We encourage you to have a decent version of Docker installed on your machine 
so that you can debug or reproduce issues easier.

You should note that we are mostly using Linux so this guide is more focused on how to do things on Linux distributions.
However, things under Windows shouldn't be that different.

We have created docker images for the most used distributions (Debian, Centos, OpenSUSE, Ubuntu) and we 
test for a lot of different scenarios and tools. Our images are published in the Docker hub
and can be found at [strongboxci](https://hub.docker.com/r/strongboxci/).

Our initial builds and most of the testing is done on nodes which run containers
with [strongboxci/alpine](https://hub.docker.com/r/strongboxci/alpine/tags/). Also, you should keep in mind that all 
of our images come with `maven` pre-installed and configured so you don't need to do anything other than
just start the container and build your code inside it.

# Installation

Depending on your OS and distribution you can install different versions of Docker CE (Community Edition).
In most cases your distribution will have it's own package of Docker which works fine. 

Please head to the docker [installation manual](https://docs.docker.com/install/) pages to check how to install it on your machine:

* [Debian](https://docs.docker.com/install/linux/docker-ce/debian/)
* [CentOS](https://docs.docker.com/install/linux/docker-ce/centos/)
* [Fedora](https://docs.docker.com/install/linux/docker-ce/fedora/)
* [Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
* [Windows](https://docs.docker.com/docker-for-windows/install/)
* [MacOS](https://docs.docker.com/docker-for-mac/install/)
* [Binaries](https://docs.docker.com/install/linux/docker-ce/binaries/#install-static-binaries)

Also, don't forget to install [Docker Compose](https://docs.docker.com/compose/install/) on your machine 
as we have some `docker-compose.yml` files in place to make it easier for you to start Strongbox.


# Run strongbox

You just want to start a Strongbox instance from sources? We've got you covered:

```
git clone https://github.com/strongbox/strongbox.git
cd strongbox
docker-compose up
```

Once the build has completed, Strongbox will start and you will be able to access it at [http://localhost:48080/](http://localhost:48080/)


# Building and testing

To build your code inside a container with our images you need to have cloned the repository you need
and then start a docker container with the image you need. This is an example of how to build Strongbox
inside an alpine image with mvn-3.3 

```
git clone https://github.com/strongbox/strongbox.git
cd strongbox
docker pull strongboxci/alpine:jdk8-mvn-3.3
docker run -it --rm -v $(pwd):/home/jenkins/workspace strongboxci/alpine:jdk8-mvn-3.3
```

If everything has gone according to plan you should now be inside the docker container and should
have seen a similar console output:

```
Apache Maven 3.3.9 (bb52d8502b132ec0a5a3f4c09453c07478323dc5; 2015-11-10T16:41:47+00:00)
Maven home: /java/mvn-3.3.9
Java version: 1.8.0_161, vendor: Oracle Corporation
Java home: /java/jdk-1.8u161-b12/jre
Default locale: en, platform encoding: UTF-8
OS name: "linux", version: "4.13.0-37-generic", arch: "amd64", family: "unix"

bash-4.3$ 
``` 

By default, your working directory is `/home/jenkins` and you will need to `cd` into `/home/jenkins/workspace`
to to be able to run `mvn clean install`.

```
cd workspace/
mvn clean install
```

At this point you should be seeing the maven build downloading all necessary artifacts. 
Keep in mind that with the `docker run` command you executed above you haven't passed a volume
for the `~/.m2/repository` directory. This means that when you exit the container and start a new one,
maven will download all the dependencies again (because they would have been deleted when you exited the container).
You can avoid this by attaching your m2 local repository directory as a volume into the container.
This is done by adding another `-v` argument in the run command above so that it ends up looks something like this:

```
docker run -it --rm \
  -v $(pwd):/home/jenkins/workspace \
  -v ~/.m2/repository:/home/jenkins/.m2/repository \
  strongboxci/alpine:jdk8-mvn-3.3
```

# Making life easier

If you have already checked out our [strongboxci/alpine](https://hub.docker.com/r/strongboxci/alpine/tags/) repository 
you would have noticed the amount of different images we have. Trying to remember all of them and the way you need to 
setup the container is tedious and unnecessary. We have created a [[.bashrc|resources/docker/.bashrc-strongbox]] 
with commands you can execute to easily get a container up and running

Our `.bashrc` has two types of commands which:

1. Start a container by mounting the current working directory as `workspace` (`dockerMvn33`, `dockerGradle45`, etc)
2. Start a container which automatically clones a project from github and use that as the `workspace`. (i.e. `dockerMvn33Checkout`, `dockerGradle45Checkout`, etc) 

If you don't remember arguments the command needs you can always execute `docker(Mvn33|Mvn33Checkout) --help` 
and it will print them to you as well as an example.


#### Setting up `~/.bashrc`

If you are interested in using the commands from our `.bashrc`:

1. Download our `.bashrc` as `.bashrc-strongbox`
    ```
    curl -o ~/.bashrc-strongbox -L https://raw.githubusercontent.com/wiki/strongbox/strongbox/resources/docker/.bashrc-strongbox
    ```
2. Add the `.bashrc-strongbox` file to your `~/.bashrc` 
    ```
    sed -i -e "\$a [ -f \$HOME\/\.bashrc-strongbox ] && \. \$HOME\/\.bashrc-strongbox" -e "/bashrc-strongbox.*/d" ~/.bashrc
    ```
3. Either open up a new terminal or execute `source ~/.bashrc`

4. Have fun building in docker :)


#### Examples

* Checkout `strongbox/strongbox.git` and run `mvn clean install`
    ```
    dockerMvn33Checkout
    ```

* Checkout `strongbox/strongbox.git` and run `mvn clean install -DskipTests`
    ```
    dockerMvn33Checkout strongbox master/branch/PR-123 "mvn clean install -DskipTests"
    ```

* Use current working directory to build project
    ```
    cd /some/path
    dockerMvn33
    ```

* Checkout `strongbox/strongbox-web-integration-tests.git` and build using Gradle
    ```
    dockerGradle45Checkout strongbox-web-integration-tests master "cd gradle; mvn clean install"
    ```
