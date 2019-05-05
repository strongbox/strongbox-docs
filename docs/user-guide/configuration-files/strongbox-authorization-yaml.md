# The `strongbox-authorization.yaml` File

There are a number of built-in roles and privileges that are already pre-configured in the source code. In addition you can define your own roles and privileges either through the YAML configuration file or REST API.

You can't use unsupported roles or privileges in the configuration file. In such cases you will get a runtime exception during application startup. All custom (user-defined) roles and privileges have to be properly defined in the `strongbox-authorization.yaml` configuration file.

# Example `strongbox-authorization.yaml` File

Below is a simple scrap of the `strongbox-authorization.yaml` configuration file that configures user defined roles:

    authorizationConfiguration:
      roles:
        - name: ANONYMOUS_ROLE
          description: Common anonymous user role
          privileges:
            - ARTIFACTS_RESOLVE
            - SEARCH_ARTIFACTS
        - name: USER_ROLE
          description: Common user role
          privileges:
            - VIEW_USER
        - name: CUSTOM_ROLE
          description: Deployment role
          privileges:
            - Deploy

# Anonymous User Privileges

There is a special treatment role called **`ANONYMOUS_ROLE`** that is not considered as a [built-in role](http://TODO_link_to_roles) so it doesn't have a fixed set of permissions. Anonymous user's privileges are configurable and can be defined in the `strongbox-authorization.yaml` configuration file.

    authorizationConfiguration:
      roles:
        - name: ANONYMOUS_ROLE
          description: Common anonymous user role
          privileges:
            - ARTIFACTS_RESOLVE
            - SEARCH_ARTIFACTS
        ...

This way every user not logged in will be awarded by the `ARTIFACTS_RESOLVE` and `SEARCH_ARTIFACTS` privileges.

# Information for Developers

The following classes are related to various aspects of the authorization configuration:

| Class Name  | Description | 
|:------------|-------------|
| [`org.carlspring.strongbox.authorization.dto.AuthorizationConfigDto`](https://github.com/strongbox/strongbox/blob/master/strongbox-security/strongbox-user-management/src/main/java/org/carlspring/strongbox/authorization/dto/AuthorizationConfigDto.java) | Represents authorization configuration in a deserialized form. |
| [`org.carlspring.strongbox.authorization.AuthorizationConfigFileManager`](https://github.com/strongbox/strongbox/blob/master/strongbox-security/strongbox-user-management/src/main/java/org/carlspring/strongbox/authorization/AuthorizationConfigFileManager.java) | Class to serialize / deserialize the authorization configuration. | 

The [strongbox-authorization.yaml](https://github.com/strongbox/strongbox/blob/master/strongbox-security/strongbox-user-management/src/main/resources/etc/conf/strongbox-authorization.yaml), which is packaged in the distribution, is located under the [strongbox-storage-api-resources](https://github.com/strongbox/strongbox/blob/master/strongbox-resources/strongbox-storage-api-resources/)'s `src/main/resources/etc/conf` directory.
