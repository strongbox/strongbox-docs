# Understanding Access Restrictions

The access to the system's web resources can be restricted for users using roles. Access restrictions are implemented internally through a set of privileges and roles, that are a set of unique privileges.

It is also possible to manage the access to certain resources.

# Built-in Roles And Privileges

We have build-in roles and privileges that are already pre-configured in source code. In addition you can define your own roles and privileges either through XML configuration file or REST API.

The project build-in privileges defined in `org.carlspring.strongbox.users.domain.Privileges`. They are, for example, `ADMIN`, `ARTIFACTS_DEPLOY`, `SEARCH_ARTIFACTS` etc.

Build-in roles defined in `org.carlspring.strongbox.users.domain.Roles`. They are, for example, `ADMIN`, `REPOSITORY_MANAGER`, `LOGS_MANAGER` etc.

You can't use unsupported roles or privileges in configuration file. In that case you will get exception at runtime during application startup. All custom (user-defined) roles and privileges have to be properly defined in `strongbox-security-authorization.xml` configuration file.

# Configuring Security Rules For Users

The user access rights can be configured either through the `etc/conf/strongbox-security-users.xml` configuration file or the REST API.

## Using XML configuration file

XML configuration file consists of set of `user` configurations and has the following structure:

    <users>
        <user>
            <username>testuser</username>
            <credentials>
                <password>password</password>
                <encryption-algorithm>plain</encryption-algorithm>
            </credentials>
            <roles>
                <role>ARTIFACTS_MANAGER</role>
            </roles>
            <access-model/>
        </user>
        ....
    </users>

The `<access-model>` element is optional.

## Using The REST API

If you would like to create a new user, you can issue an HTTP POST request as illustrated in the [[REST API]] and include the desired security configuration via the `<access-model/>`. You can also update the settings for existing users via the [[REST API]]. 

## Configuring The User Access Model

If a user doesn't have any custom permissions defined via the `<access-model/>`, the default security settings will be used (based on the current privileges set). Otherwise, the storage and repository will be parsed from current URL as well as current path (if present). If user have custom privileges for current path under current storage and repository this privileges will be temporary assigned (added to existing privileges set) during current access granting process. For another URL user will have initial set of privileges.

A user can have a main role and in addition several separate privileges that will grant them access to different resources that would otherwise have restricted access via the default assigned privileges. For example, there could be:
* A `deployer` user which has `Artifacts: Resolve` and `Artifacts: Deploy` privileges for the repository
* Another user `developer01`  that only has `Artifacts: Resolve`  for just this repository.

User can have different access level for different paths under the same repository. Path can be defined using wildcard `*` , for example `com/carlspring/foo/**`  which will means that access restricted for all paths for this repository that start with `com/carlspring/foo`.

User can have different permissions for each configured path or repository. If permission  is not defined, `rw`  (read-write) permission will be assigned by default.`READ` permission will be translated as `ARTIFACTS_VIEW` and `ARTIFACTS_RESOLVE`  privileges, and `WRITE` as `ARTIFACTS_DEPLOY` , `ARTIFACTS_DELETE` and `ARTIFACTS_COPY`.

### Example of Custom User Access Model

The following is an example of custom user access model:

```xml
<user>
    <username>developer01</username>
    <credentials>
        <password>password</password>
        <encryption-algorithm>plain</encryption-algorithm>
    </credentials>
    <roles>
        <role>UI_MANAGER</role>
    </roles>
    <access-model>
        <storages>
            <storage id="storage0">
                <repositories>
                    <repository id="act-releases-1">
                        <privileges>
                            <privilege>
                                <name>ARTIFACTS_RESOLVE</name>
                            </privilege>
                        </privileges>
                        <path-permissions>
                            <path>pro/redsoft/bar/.*</path>
                            <path permission="r">com/carlspring/foo/.*</path>
                            <path permission="rw">org/carlspring/foo/.*</path>
                        </path-permissions>
                    </repository>
                </repositories>
            </storage>
        </storages>
    </access-model>
</user>
```

In the example above, the user has the default `UI_MANAGER` role and this role privileges set used for all resources that user is trying working with. 

In addition, if user `developer01` will try to work with resources under storage `storage0` and repository `act-releases-1` he will gain RW or R privileges for certain paths to the default set of privileges that are included in `UI_MANAGER` role. Despite that, the user will have additional `ARTIFACTS_RESOLVE` privilege for all resources in that repository (according to the `privileges` configuration settings).

For example, for all artifacts under `com/carlspring/foo/.*` path they will have `UI_MANAGER` privileges plus `ARTIFACTS_VIEW` and `ARTIFACTS_RESOLVE`.

# Information For Developers

## Internal privileges and roles subsystem

Built-in privileges are defined in `org.carlspring.strongbox.users.domain.Privileges`. Roles are defined in `org.carlspring.strongbox.users.domain.Roles`.

## How It Works

We manage runtime user authentication credentials using a custom `AffirmativeBased` extension for every request. We use a `CustomAccessDecisionVoter` decision voter that does not participate in voting, but works first and - if and only if - certain user has custom access model it calculates whenever user has special access rights rules for current URL. If that's true it add's new privileges as user credentials for current authentication and refreshes Spring authentication context. Please review `org.carlspring.strongbox.security.vote.CustomAccessDecisionVoter` for more details.
