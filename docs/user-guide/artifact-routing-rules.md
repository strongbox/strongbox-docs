# Artifact Routing Rules

## What are artifact routing rules?

Requests made to a group repository will loop over the [ordered repositories](#fn:1)[^1] list to `resolve` the `artifact`.
The first repository which has the `artifact` will serve it to the client.  

Artifact Routing Rules allows you to fine-tune which of the [ordered repositories](#fn:1)[^1] can `accept` or `deny` the URL 
pattern. This makes it possible to narrow down the list of repositories[^1] which will be used to `resolve` the artifact.  
  
## Types of routing rules

### Accepted

By default all [ordered repositories](#fn:1)[^1] will `accept` any url pattern. Therefore, this rule is only useful when it is
used with a `deny` rule, because it will `allow` the [accepted ordered repositories](#fn:2)[^2] defined in the rule to
be used to `resolve` the requested artifact/path.   

### Denied

Denied routing rules are used to `block` resolving the artifact/path from the [denied ordered repositories](#fn:3)[^3].  

## Artifact Routing Rules precedence

An `accepted` rule takes precedence over `denied`.  
  
Consider the following example:

1. You have configured a pattern to `deny` the pattern `.*/org/.*` for all [ordered repositories](#fn:1)[^1] in `myGroupRepository`
2. You have configured a pattern to `accept` the pattern `.*/org/carlspring/strongbox/.*` via `myRepository` in `myGroupRepository`

In this case, if `myGroupRepository` has `myRepository` in the [ordered repositories](#fn:1)[^1], then the request `.*/org/carlspring/strongbox/.*` will be allowed.  
  
So, if you want to exclude some artifact (or artifacts matching some pattern), then make sure any accepted rule does not match the same pattern.

## Examples

### Accepted Patterns

The following example specifies that:

* The `third-party` repository accepts lookups for `com.corp.foo` artifacts.
* The `releases` repository accepts lookups for `org.carlspring.strongbox.*`, or `org.carlspring.strongbox.*` artifacts.

Example: 
```xml
<configuration>
    ...
    <routing-rules>
        <accepted>
            <rule-set group-repository="group-releases">
                <rule pattern="^(com|org)/corp/foo.*">
                    <repositories>
                        <repository>third-party-releases</repository>
                    </repositories>
                </rule>
            </rule-set>
            <rule-set group-repository="*">
                <rule pattern="^(com|org)/carlspring/strongbox.*">
                    <repositories>
                        <repository>releases</repository>
                    </repositories>
                </rule>
            </rule-set>
        </accepted>
    </routing-rules>    
</configuration>
```

### Denied Patterns

The following example disable lookups for `springframework` in the `releases` repository.

Example: 
```xml
<configuration>
    ...
    <routing-rules>
        <denied>
            <rule-set group-repository="*">
                <rule pattern="^org/springframework.*">
                    <repositories>
                        <repository>releases</repository>
                    </repositories>
                </rule>
            </rule-set>
        </denied>
    </routing-rules>    
</configuration>
```

[^1]: **Ordered Repositories List** - an ordered list of repositories which you configure when you add the group repository.
[^2]: **Accepted Ordered Repositories** - an ordered list of **Accepted** repositories. If these repositories are in your Group Repository,
      then they will be used to `resolve` the artifact.
[^3]: **Denied Ordered Repositories** - an ordered list of **Denied** repositories. If these repositories are in your Group Repository,
      then they will **NOT** be used to `resolve` the artifact.
