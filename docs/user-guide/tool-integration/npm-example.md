# NPM Example

This is an example of how to use the Strongbox artifact repository manager with NPM.

## Pre-requisites

The following is a minimal configuration in order to be able to use this tutorial:

* `Linux`
* `npm` 

## Prepare project workspace

First of all, you need to configure npm to use Strongbox as a private registry. This can be done within your project using the `.npmrc` file, which is local npm configuration applied to your project. The [Strongbox Examples] contains an [npmrc.template] file with a set of pre-defined configuration properties that can be used in your own project, or on your machine. Typically, all you'll need to do, is execute the following command, and create your `.npmrc` file:
    
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
    
    $ npm publish

The output should look like this:
    
    $ npm publish
    + @strongbox/hello-strongbox-npm@1.0.0


## See also:

* [npm official site](https://www.npmjs.com/)


[Strongbox Examples]: https://github.com/strongbox/strongbox-examples/tree/master/hello-strongbox-npm
[npmrc.template]: https://github.com/strongbox/strongbox-examples/blob/master/hello-strongbox-npm/npmrc.template
