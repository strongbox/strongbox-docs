# package.json
Every **npm** package packed as `tgz` archive which contains [`package.json`](https://docs.npmjs.com/files/package.json) inside. It defines all necessary information about the package like: who developed this package, which packages it depends on, license, etc.

# Registry API
There are different metadata levels which can be fetched using [REST API](https://github.com/npm/registry/blob/master/docs/REGISTRY-API.md).

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

It something like continuous Registry changes feed and also called [Replicate API](https://github.com/npm/registry/blob/master/docs/REPLICATE-API.md). Strongbox use this feed to get proxy repositories synced with remote registry.

Example:
```
GET https://replicate.npmjs.com/_changes
```

Every change have sequenced ID, so it's possible to get changes made starting from some point 

Example:
```
https://replicate.npmjs.com/_changes?update_seq=1000000&include_docs=true
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