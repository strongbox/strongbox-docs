# Upgrading Dependencies And Plugins

Keeping dependencies up-to-date is a crucial task of our development process.

All of our Maven dependencies and plugins are defined via the `<dependencyManagement/>` and, respectively,
`<pluginManagement/>` sections in our [strongbox-parent] project. All of our projects inherit this parent and it's
important for you to understand how to upgrade dependencies and plugins without breaking the rest of the projects
and modules down the line.

When a `<dependency/>` is defined in a `<dependencyManagement/>` section, the dependency can be defined versionless
in any `pom.xml` file that extends the parent. In addition, you can define dependency `<exclusions/>` this way too and
they will get inherited. Thus, the versions of dependencies can be controlled from one central place.

Similarly, when a `<plugin/>` is defined in a `<pluginManagement/>` section, the plugin can be defined versionless 
in any `pom.xml` file that extends the parent. What's more, you can actually define the `<configuration/>` of the plugin
in the `<pluginManagement/>` section as well and this will get inherited. Thus, the versions and configurations of
plugins can be controlled from one central place.

# Steps For Upgrading Dependencies And Plugins

Here are the steps you will need to follow in order to do so:

1. Fork the [strongbox-parent] project.
2. Change the version of the project to `ABC-issue-XYZ-SNAPSHOT`, where `ABC` is the current base version (for example,
   `1.0`), and `issue-XYZ` is the Github issue from the [strongbox] project's issue tracker, (an example of the changed
   version would be `1.0-issue-12345-SNAPSHOT`).
3. Update the version of the respective dependency.
4. Run the following to get the new version of the `strongbox-parent` installed in your local Maven repository:
   ```
   mvn clean install
   ```
5. Fork the [strongbox] project.
6. Change all the `parent` definitions in the project's `pom.xml` files to use the new version of parent. 
7. Run the following to get the new version of the `strongbox` installed in your local Maven repository (none of the
   tests should fail):
   ```
   mvn clean install -Dintegration.tests
   ```
8. Check that the `strongbox-web-core` still works (there should be no start-up errors and you should be able to browse
   the web application at http://localhost:48080/:
   ```
   cd strongbox-web-core
   mvn spring-boot:run
   ```
9. Similarly to the above, you will need to check that the `strongbox-distribution` is still working as expected:
   ```
   cd strongbox-distribution
   mvn spring-boot:run
   ```
10. Run the [strongbox-web-integration-tests] and make sure that none of them are failing. You will need Docker and 
   `docker-compose` for this and you can find instructions on how to run these tests in the project's `README.md`, but
    this is roughly an overview of the steps:
    ```
    find . -maxdepth 2 -type f -name "docker-compose.y*ml" -exec docker-compose -f {} up \;
    ```
11. If there are issues with the tests in the [strongbox-web-integration-tests] project, you might have to fix them
    there as well and raise a pull request for that project.
12. If all of the above is successful, please, raise a pull request against the [strongbox-parent] project. 
13. If all of the above is successful, please, raise a pull request against the [strongbox] project.
    The automated checks of this pull request are expected to fail the first time. You will need to contact us either
    via a comment under the pull request, or by pinging us on our [chat] channel.

Please, make sure that all the steps above work, before raising your pull requests. If the upgrade causes an issue
which you can't figure out, please raise the pull requests and  try to provide as much information in the issue on our
tracker, as possible, so that we could further investigate when we can.

[<--# Links -->]: #
[strongbox]: https://github.com/strongbox/strongbox/
[strongbox-parent]: https://github.com/strongbox/strongbox-parent/
[strongbox-web-integration-tests]: https://github.com/strongbox/strongbox-web-integration-tests/
[chat]: https://chat.carlspring.org/channel/community
