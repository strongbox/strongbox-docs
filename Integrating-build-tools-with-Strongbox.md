The following build tools are known to work with Strongbox

|  Tool   | Resolve | Deploy | Notes  | Example |
|:-------:|:-------:|:------:|--------|---------|
| Maven   |   Yes   |  Yes   |        | [hello-strongbox-maven](https://github.com/strongbox/strongbox-examples/tree/master/hello-strongbox-maven) |
| Gradle  |   Yes   |  Yes   |        | [hello-strongbox-gradle](https://github.com/strongbox/strongbox-examples/tree/master/hello-strongbox-gradle) |
| SBT     |   Yes   |  Yes   | <ul><li>SBT does not produce `maven-metadata.xml` files.</li><li>SBT does not deploy timestamped SNAPSHOT artifacts</li></ul> | [hello-strongbox-sbt](https://github.com/strongbox/strongbox-examples/tree/master/hello-strongbox-sbt) |
| Ivy /<br/> Ant+Ivy |   Yes   |  Yes   |        | [hello-strongbox-ant-ivy](https://github.com/strongbox/strongbox-examples/tree/master/hello-strongbox-ant-ivy) |
| Nuget |   Yes   |  Yes   | This example uses Mono to build the code and Nuget to deploy. | [hello-strongbox-nuget-mono](https://github.com/strongbox/strongbox-examples/tree/master/hello-strongbox-nuget-mono) |
| curl    |   Yes   |  Yes   | You will have to craft your own HTTP PUT and GET requests | n/a |
| Jenkins |   Yes   |  Yes   | Tested via the "Deploy artifacts to Maven repository" post build task. | n/a |


For more details, please checkout the [strongbox-examples](https://github.com/strongbox/strongbox-examples) project.
