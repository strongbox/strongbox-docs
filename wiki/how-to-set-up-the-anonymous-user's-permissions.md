# General

Strongbox supports anonymous user's permissions. There is a special treatment role called **`ANONYMOUS_ROLE`** that is not considered as a [built-in role](https://github.com/strongbox/strongbox/wiki/The-strongbox%E2%80%90security%E2%80%90users.xml-File#user-content-built-in-roles-and-privileges) so it doesn't have a fixed set of permissions. Anonymous user's permissions are configurable and can be defined in the `strongbox-authorization.xml` configuration file.

# Example

Below is a simple scrap of the `strongbox-authorization.xml` configuration file that configures anonymous user's permissions:

        <role>
            <name>ANONYMOUS_ROLE</name>
            <description>Common anonymous user role</description>
            <privileges>
                <privilege>ARTIFACTS_RESOLVE</privilege>
            </privileges>
        </role>

This way every user not logged in will be awarded by the `ARTIFACTS_RESOLVE` privilege.