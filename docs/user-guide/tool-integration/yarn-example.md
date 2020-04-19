# Yarn

This is an example of how to use the Strongbox artifact repository manager with Yarn.

## Pre-requisites

* [Installed and configured a Strongbox Distribution](../getting-started.md)
* Java Development Kit (JDK) version 1.8.x
* [NodeJS](https://nodejs.org/) version 12 or higher
* [Yarn](https://yarnpkg.com/en/) version 1.19.1 or higher

## Example project

The "Hello, World!" sample application for this can be found [here][hello-strongbox-yarn].

## Prepare project workspace

First, you need to configure `yarn` to use Strongbox as a private registry. This can be done in your project by creating a `.npmrc` file, which is local npm configuration applied to your project. The [Strongbox Yarn Example] contains an [npmrc.template] file with a set of pre-defined configuration properties that can be used in your own project, or on your machine. Typically, all you'll need to do, is execute the following command, and create your `.npmrc` file:

    $ cp npmrc.template .npmrc

After that the pre-defined configuration parameters can be changed, according to your needs and environment (Strongbox URL, username and password).

Your `.npmrc` should look like this:

    $ cat .npmrc

    registry=http://localhost:48080/storages/storage-npm/npm-releases
    always-auth=true
    email=someuser@example.com
    _auth=YWRtaW46cGFzc3dvcmQ=

    ; `_auth` is a base64 encoded authentication token
    ; you can use it instead of:
    ; username=admin
    ; _password=password


## How to publish npm package into Strongbox registry

Execute the following command within your project folder:

    $ yarn publish

??? info "Example output"

    ```
    $ yarn publish v1.19.1
    + [1/4] Bumping version...
    + info Current version: 1.0.0
    + question New version: 1.0.0
    + [2/4] Logging in...
    + [3/4] Publishing...
    + success Published.
    + [4/4] Revoking token...
    + Done in 4.50s.
    ```

## See also

* [Yarn official site](https://yarnpkg.com/en/)


[Strongbox Yarn Example]: https://github.com/strongbox/strongbox-examples/tree/master/hello-strongbox-yarn
[npmrc.template]: https://github.com/strongbox/strongbox-examples/blob/master/hello-strongbox-npm/npmrc.template
[hello-strongbox-yarn]: https://github.com/strongbox/strongbox-examples/tree/master/hello-strongbox-yarn
