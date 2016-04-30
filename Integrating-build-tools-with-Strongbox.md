The following build tools are known to work with Strongbox

|  Tool   | Resolve | Deploy | Notes  | Example |
|:-------:|:-------:|:------:|--------|---------|
| Maven   |   Yes   |  Yes   |        | [hello-strongbox-maven](https://github.com/strongbox/strongbox-examples/tree/master/hello-strongbox-maven) |
| SBT     |   Yes   |  Yes   | <ul><li>SBT does not produce `maven-metadata.xml` files.</li><li>SBT does not deploy timestamped SNAPSHOT artifacts</li></ul> | [hello-strongbox-sbt](https://github.com/strongbox/strongbox-examples/tree/master/hello-strongbox-sbt) |
| Ivy     |   Yes   |  Yes   |        | n/a |
| curl    |   Yes   |  Yes   | You will have to craft your own HTTP PUT and GET requests | n/a |

For more details, please checkout the [strongbox-examples](https://github.com/strongbox/strongbox-examples) project.
