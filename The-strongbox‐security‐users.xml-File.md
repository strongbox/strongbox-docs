# Understanding Access Restrictions

The access to the system's web resources can be restricted for users using roles and privileges. Access restrictions are implemented internally through a set of privileges and roles, that are a set of unique privileges.

It is also possible to manage the access to certain resources.

# Built-in Roles And Privileges

There are a number of built-in roles and privileges that are already pre-configured in the source code. In addition you can define your own roles and privileges either through the XML configuration file or REST API.

You can't use unsupported roles or privileges in the configuration file. In such cases you will get a runtime exception during application startup. All custom (user-defined) roles and privileges have to be properly defined in the `strongbox-authorization.xml` configuration file.

# Configuring Security Rules For Users

The user access rights can be configured either through the `etc/conf/strongbox-security-users.xml` configuration, file or via the REST API.

## Using The XML Configuration File

The XML configuration file consists of a set of `user` configurations and has the following structure:

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

If a user doesn't have any custom permissions defined via the `<access-model/>`, the default security settings will be used (based on the current set of privileges). Otherwise, the storage and repository will be parsed from current URL as well as current path, (if present). If a user has custom privileges for the requested path under the specified storage and repository, these privileges will be temporarily assigned (added to existing set of privileges) during access granting process. For any other URL, user will have the initial set of privileges.

A user can have a main role and in addition several separate privileges that will grant them access to different resources that would otherwise have restricted access via the default assigned privileges. For example, there could be:

* A `deployer` user which has `Artifacts: Resolve` and `Artifacts: Deploy` privileges for the repository
* Another user `developer01`  that only has `Artifacts: Resolve`  for just this repository.

Users can also fine-grain the access levels for different paths under the same repository. Paths can be defined using wildcards, for example `com/carlspring/foo/**`  which will mean that access is granted for all paths for this repository that start with `com/carlspring/foo`.

Furthermore, users can have different permissions for each configured path or repository. If a permission is not defined, a `rw`  (read-write) permission will be assigned by default. `READ` permission will be translated as `ARTIFACTS_VIEW` and `ARTIFACTS_RESOLVE`  privileges, and `WRITE` as `ARTIFACTS_DEPLOY` , `ARTIFACTS_DELETE` and `ARTIFACTS_COPY`.

### Example of Custom User Access Model

The following is an example of a custom user access model:

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
                    <repository id="mycorp-releases">
                        <privileges>
                            <privilege>
                                <name>ARTIFACTS_RESOLVE</name>
                            </privilege>
                        </privileges>
                        <path-permissions>
                            <path>com/mycorp/.*</path>
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

In the example above, the user has the default `UI_MANAGER` role and this role privileges set is used for all the web resources. 

In addition, if user `developer01` tries to access a resources under storage `storage0` and repository `mycorp-releases`, they will also gain read-write (`rw`) or read (`r`) privileges for the paths specified in the example above in addition to the default set of privileges that are included in `UI_MANAGER` role. Despite this, the user will have an additional `ARTIFACTS_RESOLVE` privilege for all the resources in that repository (according to the `privileges` configuration settings).

For example, for all artifacts under `com/carlspring/foo/.*` path they will have `UI_MANAGER` privileges, as well as the `ARTIFACTS_VIEW` and `ARTIFACTS_RESOLVE` privileges.

# Information For Developers

## Internal privileges and roles subsystem

Built-in privileges are defined in `org.carlspring.strongbox.users.domain.Privileges`. Roles are defined in `org.carlspring.strongbox.users.domain.Roles`.

The built-in privileges defined in `org.carlspring.strongbox.users.domain.Privileges`. Such are, for example:

* `ADMIN`
* `ARTIFACTS_DEPLOY`
* `SEARCH_ARTIFACTS`
* etc.

The built-in roles are defined in `org.carlspring.strongbox.users.domain.Roles`. Such are, for example:

* `ADMIN`
* `REPOSITORY_MANAGER`
* `LOGS_MANAGER`
* etc.

## How It Works

The runtime user authentication credentials are managed using a custom `AffirmativeBased` extension for every request. A `CustomAccessDecisionVoter` decision voter is used that does not participate in the voting, unless the user has a custom access model defined. In such cases it calculates decides whether the user has the required rights to access the current URL. If the user has the required access level, the voter adds the new privileges as user credentials for current authentication and refreshes Spring authentication context.

Please review `org.carlspring.strongbox.security.vote.CustomAccessDecisionVoter` for more details.
