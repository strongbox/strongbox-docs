# What are artifact routing rules?

Requests to resolve an artifact from a group repository loop over all of the repositories in the group until an artifact has been resolved.

Artifact routing rules allow you to control the searching in group repositories. With routing rules you can define patterns which are accepted, or denied by a repository in the group. This makes it possible to narrow down the list of repositories in which to search for artifacts matching a certain pattern.

# Examples

## Accepted Patterns

The following example specifies that:
* The `third-party` repository accepts lookups for `corp.foo` artifacts.
* The `releases` repository accepts lookups for `org.carlspring.strongbox.*`, or `org.carlspring.strongbox.*` artifacts.

        <configuration>
            ...
            <routing-rules>
                <accepted>
                    <rule-set group-repository="group-releases">
                        <rule pattern=".*(com|org)/corp/foo.*">
                            <repositories>
                                <repository>third-party-releases</repository>
                            </repositories>
                        </rule>
                    </rule-set>
                    <rule-set group-repository="*">
                        <rule pattern=".*(com|org)/carlspring/strongbox.*">
                            <repositories>
                                <repository>releases</repository>
                            </repositories>
                        </rule>
                    </rule-set>
                </accepted>
            </routing-rules>    
        </configuration>

## Denied Patterns

The following example disable lookups for `springframework` in the `releases` repository.

    <configuration>
        ...
        <routing-rules>
            <denied>
                <rule-set group-repository="*">
                    <rule pattern=".*org.springframework.*">
                        <repositories>
                            <repository>releases</repository>
                        </repositories>
                    </rule>
                </rule-set>
            </denied>
        </routing-rules>    
    </configuration>
