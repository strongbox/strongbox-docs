# Building the code with Docker

## Introduction

Docker is awesome and we are using it to build and test almost everything. 
It has proven to be quite fast and convenient way to easily reproduce issues.
We encourage you to have a decent version of Docker installed on your machine 
so that you can debug or reproduce issues easier.

You should note that we are mostly using Linux so this guide is more focused on how to do things on Linux distributions.
However, things under Windows shouldn't be that different.

## Docker installation

Depending on your OS and distribution you can install different versions of Docker CE (Community Edition).
In most cases your distribution will have it's own package of Docker which works fine. 

Please head to the docker [installation manual](https://docs.docker.com/install/) pages to check how to install it on your machine:

Also, don't forget to install [Docker Compose](https://docs.docker.com/compose/install/) on your machine 
because we have some `docker-compose.yml` files in place to make it easier for you to start Strongbox.

## Available images

We have created docker images for the most used distributions (Debian, Centos, OpenSUSE, Ubuntu) and we 
test for a lot of different scenarios and tools. Our images are published in the Docker hub
and can be found at [strongboxci](https://hub.docker.com/r/strongboxci/). At the time of writing this, we have the 
following distribution images:

* [strongboxci/alpine]
* [strongboxci/centos]
* [strongboxci/debian]
* [strongboxci/opensuse]
* [strongboxci/ubuntu]

Most of the tests we run in our CI are using [strongboxci/alpine]. Please note that almost all of our images come 
with `maven` pre-installed and configured with our `settings.xml` file. You don't need to do anything other than
just start the container and build your code.

## Possible permission issues (Linux)

It is important to mention that our docker images are running under the user `jenkins` which has `user_id=1000` and 
`group_id=1000`. This is usually the very first user on many distributions and in general should "work".  
  
Please check your `user/group id` by executing `id`. If you see something like the output below - you shouldn't have problems:

```
uid=1000(your-username) gid=1000(your-username) groups=1000(your-username)
```
  
If you see another `uid/gid` you will likely hit a permission issue. Unfortunately [docker/compose#3328][issue-3328], 
[docker/compose#4700][issue-4700] and [docker/cli#1318][issue-1318] are preventing `docker-compose` from being able to 
automatically fix the group id. There are two workarounds which you can apply for things to work as expected:

1. Instead of using `docker-compose`, you can use plain `docker` and pass ```--group-add `id -g` ``` to the arguments. 
   This will add your local group id in the docker container and you will be able to work as usual, however it will 
   require typing the `docker run` command every time. Example command:  
   ```
   docker run -it --rm --group-add `id -g` -v /path/to/strongbox-project:/workspace strongboxci/alpine:jdk8-mvn-3.5
   ```

2. You can create a user with `uid=1000` and `gid=1000` and then fix the permissions of the folders:
    * Create the user/group
     ```
      groupadd -g 1000 jenkins
      useradd -u 1000 -g 1000 -s /bin/bash -m jenkins
     ```
    * Fix the permissions
     ```
     chown -R `id -u`.1001 /path/to/strongbox-project ~/.m2/repository
     chmod -R 775 /path/to/strongbox-project ~/.m2/repository
     ```  
    * You can now proceed with running `docker-compose up` as usual and it should work.
  

## Run strongbox

You just want to start a Strongbox instance from sources? We've got you covered:

```
git clone https://github.com/strongbox/strongbox.git
cd strongbox
docker-compose up
```

Once the build has completed, Strongbox will start and you will be able to access it at [http://localhost:48080/](http://localhost:48080/)

## Building and testing

To build your code inside a container with our images you need to have cloned the repository you need
and then start a docker container with the image you need. This is an example of how to build Strongbox
from sources inside a container using [strongboxci/alpine:jdk8-mvn-3.5]: 

```
$ git clone https://github.com/strongbox/strongbox.git
$ cd strongbox
$ docker pull strongboxci/alpine:jdk8-mvn-3.5
$ docker run -it --rm \
             -v $(pwd):/home/jenkins/workspace \
             -w /home/jenkins/workspace \
             strongboxci/alpine:jdk8-mvn-3.5

Apache Maven 3.3.9 (bb52d8502b132ec0a5a3f4c09453c07478323dc5; 2015-11-10T16:41:47+00:00)
Maven home: /java/mvn-3.3.9
Java version: 1.8.0_161, vendor: Oracle Corporation
Java home: /java/jdk-1.8u161-b12/jre
Default locale: en, platform encoding: UTF-8
OS name: "linux", version: "4.13.0-37-generic", arch: "amd64", family: "unix"

bash-4.3$ 
``` 

What the `docker run` command just did was to create a disposable container (`--rm`) in which you can execute any commands.
By passing the `-w` flag we have set the current working directory to be the workspace (default is `/home/jenkins`).

We can now proceed with building the code: 

```
mvn clean install
```

This might take a while, but in the end you should have a successful build.

!!! tip "Mount maven repository cache"
    It is also possible to mount your local `~/.m2/repository` directory into the container.  
    Just pass `-v ~/.m2/repository:/home/jenkins/.m2/repository` into the arguments and you're good to go. 

## Making life easier

If you have already checked out our [strongboxci/alpine] repository you would have noticed the amount of 
different images we have. Trying to remember all of them and the way you need to setup the container is tedious and 
unnecessary. We have created a [.bashrc]({{resources}}/docker/bashrc-strongbox) with commands you can execute to easily 
get a container up and running

Our `.bashrc` has two types of commands which:

1. Start a container by mounting the current working directory as `workspace` (i.e `dockerMvn35`, `dockerGradle45`, etc)
2. Start a container and automatically clone a project from github and use that as the `workspace`. (i.e. `dockerMvn35Checkout`, `dockerGradle45Checkout`, etc) 

If you don't remember arguments the command needs you can always execute `dockerMvn35 --help` and it will print them to you as well as an example.

### Setting up `~/.bashrc`

If you are interested in using the commands from our `.bashrc`:

```linenums="1"
curl -o ~/.bashrc-strongbox \
     -L {{resources}}/docker/bashrc-strongbox
chmod 750 ~/.bashrc-strongbox
echo "\$HOME/.bashrc-strongbox" >> ~/.bashrc
```

You can now either open up a new terminal or execute `source ~/.bashrc`  
Have fun building things in docker :smile:


### Example commands

* Checkout `strongbox/strongbox.git` and run `mvn clean install`
    ```
    dockerMvn35Checkout
    ```

* Checkout `strongbox/strongbox.git` and run `mvn clean install -DskipTests`
    ```
    dockerMvn35Checkout strongbox master/branch/PR-1234 "mvn clean install"
    ```

* Use current working directory to build project
    ```
    cd /some/path
    dockerMvn35
    ```

* Checkout `strongbox/strongbox-web-integration-tests.git` and build using Gradle
    ```
    dockerGradle45Checkout strongbox-web-integration-tests master "cd gradle; mvn clean install"
    ```


[strongboxci/alpine]: https://hub.docker.com/r/strongboxci/alpine/tags
[strongboxci/alpine:jdk8-mvn-3.5]: https://hub.docker.com/r/strongboxci/alpine/tags 
[strongboxci/centos]: https://hub.docker.com/r/strongboxci/centos/tags
[strongboxci/debian]: https://hub.docker.com/r/strongboxci/debian/tags
[strongboxci/opensuse]: https://hub.docker.com/r/strongboxci/opensuse/tags
[strongboxci/ubuntu]: https://hub.docker.com/r/strongboxci/ubuntu/tags

[issue-1318]: https://github.com/docker/cli/issues/1318
[issue-3328]: https://github.com/docker/compose/issues/3328
[issue-4700]: https://github.com/docker/compose/issues/4700#issuecomment-416714975
