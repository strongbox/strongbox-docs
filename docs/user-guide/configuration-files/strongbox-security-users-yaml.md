# Strongbox Security Users Yaml

TODO @sbespalov

## Example

The configuration file consists of a set of `user` configurations and has the following structure:

    users:
      user:
        - username: admin
          password: $2a$10$WqtVx7Iio0cndyR1lEaKW.SWhUYmF/zHHG5hkAXvH5hUmklM7QfMO
          roles:
            - ADMIN
          securityTokenKey: admin-secret
        - username: maven
          password: $2a$10$WqtVx7Iio0cndyR1lEaKW.SWhUYmF/zHHG5hkAXvH5hUmklM7QfMO
          roles:
            - ADMIN
          securityTokenKey: maven-secret
        - username: user
          password: $2a$10$WqtVx7Iio0cndyR1lEaKW.SWhUYmF/zHHG5hkAXvH5hUmklM7QfMO
          roles:
            - ADMIN
          securityTokenKey: user-secret
        - username: deployer
          password: $2a$10$WqtVx7Iio0cndyR1lEaKW.SWhUYmF/zHHG5hkAXvH5hUmklM7QfMO
          roles:
            - UI_MANAGER
          securityTokenKey: deployer-secret
          accessModel:
            storages:
              - id: storage0
                repositories:
                  - id: releases
                    repositoryPrivileges:
                      - name: ARTIFACTS_DEPLOY
                      - name: ARTIFACTS_RESOLVE
        - username: developer01
          password: $2a$10$WqtVx7Iio0cndyR1lEaKW.SWhUYmF/zHHG5hkAXvH5hUmklM7QfMO
          roles:
            - UI_MANAGER
          securityTokenKey: developer01-secret
          accessModel:
            storages:
              - id: storage0
                repositories:
                  - id: releases
                    repositoryPrivileges:
                      - name: ARTIFACTS_RESOLVE
                    pathPrivileges:
                      - path: com/carlspring
                        wildcard: true
                        privileges:
                          - name: ARTIFACTS_VIEW
                      - path: org/carlspring
                        wildcard: true
                        privileges:
                          - name: ARTIFACTS_DELETE
                      - path: com/mycorp
                        privileges:
                          - name: ARTIFACTS_VIEW
                          - name: ARTIFACTS_DEPLOY
                          - name: ARTIFACTS_DELETE
                          - name: ARTIFACTS_COPY


The `access-model` element is optional.

### Configuring The User Access Model

TODO @sbespalov

## Information for Developers

The following classes are related to various aspects of the users configuration:

| Class Name  | Description | 
|:------------|-------------|
| [`org.carlspring.strongbox.users.dto.UsersDto`](https://github.com/strongbox/strongbox/blob/master/strongbox-security/strongbox-user-management/src/main/java/org/carlspring/strongbox/users/dto/UsersDto.java) | Represents users configuration in a deserialized form. |
| [`org.carlspring.strongbox.users.UsersFileManager`](https://github.com/strongbox/strongbox/blob/master/strongbox-security/strongbox-user-management/src/main/java/org/carlspring/strongbox/users/UsersFileManager.java) | Class to serialize / deserialize the users configuration. | 

The [strongbox-security-users.yaml](https://github.com/strongbox/strongbox/blob/master/strongbox-security/strongbox-user-management/src/main/resources/etc/conf/strongbox-security-users.yaml), which is packaged in the distribution, is located under the [strongbox-storage-api-resources](https://github.com/strongbox/strongbox/blob/master/strongbox-resources/strongbox-storage-api-resources/)'s `src/main/resources/etc/conf` directory.

