# Getting started with persistence

## Abstract

This page contains explanations and code samples for developers who need to store their entities into the database. 

The Strongbox project uses [JanusGraph](https://janusgraph.org/) as its internal persistent storage through the 
corresponding [Gremlin](https://tinkerpop.apache.org/gremlin.html) implementation and [spring-data-neo4j](https://spring.io/projects/spring-data-neo4j#overview) middle tier. Also we use `JTA` for transaction management and `spring-tx` implementation module from Spring technology stack.

## Persistence stack

We using following technology stack to deal with persistence:

 - Embedded Cassandra as direct storage (`CassandraDaemon` allows to have the Cassandra instance inside same JVM as the application)
 - JanusGraph as Graph DBMS (it is not directly a data storage, it just allows you to have access to data in the form of a graph)
 - [Apache TinkerPop](http://tinkerpop.apache.org/docs/current/reference/)  as a set of tools to interact with the database (mainly Gremlin meant here)
 - [spring-data-neo4j](https://github.com/spring-projects/spring-data-neo4j) to manage transactions in Spring with `Neo4jTransactionManager` and implement custom Cypher queries with Spring Data repositories (by custom queries means `@org.springframework.data.neo4j.annotation.Query` annotation)
 - [cypher-for-gremlin](https://github.com/opencypher/cypher-for-gremlin) which translates Cypher queries into Gremlin traversals (it has some issues which prevents us to use it for `neo4j-ogm` CRUD operations, these issues will be explained below)
 - [neo4j-ogm](https://github.com/neo4j/neo4j-ogm) to map Java POJOs into Vertices and Edges of Graph
 - we also use custom `EntityTraversalAdapters`, which implements anonimous Gremlin traversals for CRUD operations under `neo4j-ogm` entities.

# Vertices and Edges

Unlike a Relational DBMS, Graph DBMS have vertices and edges, not rows and tables. So in terms of Graph every persistent entity should be stored as Vertex or Edge. An example of a vertex might be `Artifact` or `AritfactCoordinates` and the relation between them would be an edge. It should be noted that, unlike RDBMS, object relations are represented by separate edge instead of just foreign key column in table. In addition to vertices, persistence objects can also be an edges, as an example the `ArtifactDependency` would be an edge between `ArtifactCoordinates` vertices.

# Issues of `cypher-for-gremlin` and `neo4j-ogm`

First issue was the fact that `cypher-for-gremlin` not fully suport all Cypher syntax that produced by `neo4j-ogm` for CRUD operations. In more detail on every CRUD operation `neo4j-ogm` generate Cypher query which then translates into Gremlin by `cypher-for-gremlin`. As a workadound we modify Cypher queries produced by `neo4j-ogm` and replace some clauses (see `org.opencypher.gremlin.neo4j.ogm.request.GremlinRequest`). 

Another issue is that `cypher-for-gremlin` have some doubtful concept to work with `null` values in Gremlin. They put a lot of noisy tokens into Gremlin traversals which prevents JanusGraph engine to match expected indexes, this causes heavy fullscan on every query (see [#342](https://github.com/opencypher/cypher-for-gremlin/issues/342)).  This was the main reason of why we can't use `neo4j-ogm` for CRUD operations.
Anyway we still using it for custom Cypher queries with `@org.springframework.data.neo4j.annotation.Query` annotation. This is good option to have Cypher queries  instead of Gremlin because it looks more clear and takes less time to read existing and write new queries.

## Gremlin Server

`TODO`


## Adding Dependencies

Let's assume that you, as a Strongbox developer, need to create a new module or write some persistence code in an 
existing module that does not contain any persistence dependencies yet. (Otherwise you will already have the proper 
`<dependencies/>` section in your `pom.xml`, similar to the one in the example below). You will need to add the 
following code snippet to your module's `pom.xml` under the `<dependencies>` section:

```xml
<dependency>
    <groupId>${project.groupId}</groupId>
    <artifactId>strongbox-data-service</artifactId>
    <version>${project.version}</version>
</dependency>
```

Notice that there is no need to define any direct dependencies on JanusGraph or Spring Data - it's already done via 
the `strongbox-data-service` module.

## Creating Your Entity Class

Let's now assume that you have a POJO and you need to save it to the database (and that you probably have at least 
CRUD operation's implemented in it as well). Place your code under the `org.carlspring.strongbox.domain` 
package. For the sake of the example, let's pick `PetEntity` as the name of your entity.

If you want to store that entity properly you need to adopt the following rules:

* Create the interface for your entity with all getters and setters that required to interact with the entity according to the `JavaBeans` coding convention. This interface should extend `org.carlspring.strongbox.data.domain.DomainObject`. The need for an interface is due to hide the implementation specific to underlying database, such as inheritance strategy.
* Create the entity class which implements the above interface and have the `org.carlspring.strongbox.data.domain.DomainEntity` as the superclass. 
* Define a default empty constructor, this would need to create entity instance from `neo4j-ogm` internals.

The complete source code example that follows all requirements should look something like this:

```java
package org.carlspring.strongbox.domain;

public class PetEntity
        extends DomainEntity
        implements Pet
{

    private Integer age;

    public PetEntity()
    {
    }

    @Override
    public Integer getAge()
    {
        return age;
    }

    @Override
    public void setAge(Integer age)
    {
        this.age = age;
    }

}
```

# Gremlin Repositories

As mentioned above besides `neo4j-ogm` we were forced to have custom CRUD implementation based on Gremlin. This has its advantages as it allow for us to optimize OGM entities and make them faster then common `neo4j-ogm` provide out of the box.  The main thing of the Gremlin based CRUD is `EntityTraversalAdapter` which is a strategy for create/update, read/delete operations. The concrete `EntityTraversalAdapter` provide anonymous traversals for each of the operations on specific entity type. These traversals used in Gremlin based repositories to perform common CRUD operations. The `EntityTraversalAdapter` implementations can also use each other to support relations between entities, inheritance and cascade operations.

## Creating a `EntityTraversalAdapter`
`TODO`

## Creating a `Repository`
`TODO`

```
