# package.json
Every **npm** package is packed as a `tgz` archive which contains [`package.json`](https://docs.npmjs.com/files/package.json) inside. It defines all the necessary information about the package like: who developed this package, which packages it depends on, license, etc.

# Registry API
There are different metadata levels which can be fetched using the [NPM REST API](https://github.com/npm/registry/blob/master/docs/REGISTRY-API.md).

## Package

Package level metadata contains all package versions, last version can be found there under `dist-tags` section.

Example:
```
GET http://localhost:48080/storage/repository/@strongbox/hello-strongbox-npm
```

## Version 

Package version level defines concrete package version. It looks much like **package.json**, but also it contains some additional sections like `dist`, to determine package integrity, and others.

Example:
```
GET http://localhost:48080/storage/repository/@strongbox/hello-strongbox-npm/1.0.0
``` 

## Changes

This is a feed which is like a continuous registry of changes and it's also called the [Replicate API](https://github.com/npm/registry/blob/master/docs/REPLICATE-API.md). Strongbox uses this feed to get proxy repositories synced with the remote registry.

Example:
```
GET https://replicate.npmjs.com/_changes
```

Every change has a sequenced ID, so it's possible to get changes made starting from some point:
```
https://replicate.npmjs.com/_changes?since=1000000&include_docs=true
```

It can also be filtered like below:
```
POST https://replicate.npmjs.com/_changes?filter=_doc_ids&include_docs=true

Body
{
    "doc_ids": [
        "@strongbox/hello-strongbox-npm"
    ]
}
```

# Information For Developers

The code for the NPM Metadata implementation can be found in the [strongbox-npm-metadata](https://github.com/strongbox/strongbox-npm-metadata) module.
