# Artifact Routing Rules

## What are artifact routing rules?

Requests made to a group repository will loop over the [ordered repositories](#fn:1)[^1] list to `resolve` the `artifact`.
The first repository which has the `artifact` will serve it to the client.  

Artifact Routing Rules allows you to fine-tune which of the [ordered repositories](#fn:1)[^1] can `accept` or `deny` the URL 
pattern. This makes it possible to narrow down the list of repositories[^1] which will be used to `resolve` the artifact.  
  
## Types of routing rules

### Accepted

Allowed routing rules are used to allow resolving the artifact/path from the [accepted repositories](#fn:2)[^2].  
   
By default all [ordered repositories](#fn:1)[^1] will `accept` any url pattern. Therefore, this rule is only useful when 
it is used with a `deny` rule. 

### Denied

Denied routing rules are used to `block` resolving the artifact/path from the [denied repositories](#fn:3)[^3].  

## Artifact Routing Rules precedence

An `accepted` rule takes precedence over `denied`.  
  
Consider the following example:

1. You have configured a pattern to `deny` the pattern `.*/org/.*` for all [ordered repositories](#fn:1)[^1] in `myGroupRepository`
2. You have configured a pattern to `accept` the pattern `.*/org/carlspring/strongbox/.*` via `myRepository` in `myGroupRepository`

In this case, if `myGroupRepository` has `myRepository` in the [ordered repositories](#fn:1)[^1], then the request `.*/org/carlspring/strongbox/.*` will be allowed.  
  
So, if you want to exclude some artifact (or artifacts matching some pattern), then make sure any accepted rule does not match the same pattern.

## Artifact Routing Rules optionality

Routing rules may be strict or elastic, in two ways.

#### Flexibility of defining the group repository
* We can define the specific group repository (by identifying its `storage-id` and `repository-id`)
* We can define the group repositories within declared `storage-id` (by leaving `repository-id` empty)
* We can define the group repositories having provided `repository-id` (by leaving `storage-id` empty)

#### Flexibility of defining the underlying repositories
* We can define the specific underlying repository (by identifying its `storage-id` and `repository-id`)
* We can define the underlying repositories within declared `storage-id` (by leaving `repository-id` empty)
* We can define the underlying repositories having provided `repository-id` (by leaving `storage-id` empty)

The above approaches can be used together and separately.

## Examples

### Accepted Patterns

The following example specifies that:

* Requests for artifacts matching `^(com|org)/corp/foo.*` will be accepted by every repository with `repository-id` equal to `third-party-releases` under each group having `repository-id` equal to `group-releases`.
* Requests for artifacts matching `^(com|org)/carlspring/strongbox.*` will be accepted by repository identified by `storage-id` equal to `storage-common-proxies` and `repository-id` equal to `releases` under each group of repositories.

Example: 
```xml
<configuration>
    ...
    <routing-rules>
        <routing-rule uuid="0f84a9a7-b2ce-47ed-8a01-085e235a1942"
                      storage-id=""
                      repository-id="group-releases"
                      pattern="^(com|org)/corp/foo.*"
                      type="accept">
            <repositories>
                <repository storage-id="" repository-id="third-party-releases"/>
            </repositories>
        </routing-rule>    
        <routing-rule uuid="0f84a9a7-b2ce-47ed-8a01-085e235a1943"
                      storage-id=""
                      repository-id=""
                      pattern="^(com|org)/carlspring/strongbox.*"
                      type="accept">
            <repositories>
                <repository storage-id="storage-common-proxies" repository-id="releases"/>
            </repositories>
        </routing-rule>
    </routing-rules>    
</configuration>
```

### Denied Patterns

* The following example disables lookups for `.*(com|org)/carlspring.*` in the group repository identified by `storage-id` equal to `storage-common-proxies` and `repository-id` equal to `group-common-proxies` in the underlying repository identified by `storage-id` equal to `storage-common-proxies` and `repository-id` equal to `jboss-public-releases`.  

  To put it more simply, if someone tries to access `.*(com|org)/carlspring.*` from group repository `storage-id="storage-common-proxies" repository-id="group-common-proxies"` then this group repository won't serve this request from repository `storage-id="storage-common-proxies" repository-id="jboss-public-releases"`, for sure.

```xml
<configuration>
    ...
    <routing-rules>
        <routing-rule uuid="0f84a9a7-b2ce-47ed-8a01-085e235a1946"
                      storage-id="storage-common-proxies"
                      repository-id="group-common-proxies"
                      pattern=".*(com|org)/carlspring.*"
                      type="deny">
            <repositories>
                <repository storage-id="storage-common-proxies" repository-id="jboss-public-releases"/>
            </repositories>
        </routing-rule>
    </routing-rules>
</configuration>
```

* The following example disable lookups for `.*(com|org)/carlspring.*` in `repository-id="jboss-public-releases"` for every group repository containing this repository.

```xml
<configuration>
    ...
    <routing-rules>
        <routing-rule uuid="0f84a9a7-b2ce-47ed-8a01-085e235a1947"
                      storage-id=""
                      repository-id=""
                      pattern=".*(com|org)/carlspring.*"
                      type="deny">
            <repositories>
                <repository storage-id="" repository-id="jboss-public-releases"/>
            </repositories>
        </routing-rule>
    </routing-rules>
</configuration>
```

[^1]: **Ordered Repositories List** - an ordered list of repositories which you configure when you add the group repository.
[^2]: **Accepted Repositories** - are an ordered list of **Accepted** repositories. If these repositories are in your Group Repository,
      then they will be used to `resolve` the artifact.
[^3]: **Denied Repositories** - are an ordered list of **Denied** repositories. If these repositories are in your Group Repository,
      then they will **NOT** be used to `resolve` the artifact.
