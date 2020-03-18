# Getting started with persistence

## Abstract

This page contains explanations and code samples for developers who need to store their entities into the database. 

The Strongbox project uses [JanusGraph](https://janusgraph.org/) as its internal persistent storage through the 
corresponding [Gremlin](https://tinkerpop.apache.org/gremlin.html) implementation and [spring-data-neo4j](https://spring.io/projects/spring-data-neo4j#overview) middle tier. Also we use `JTA` for transaction management and `spring-tx` implementation module from Spring technology stack.

## Persistence stack

We using following technology stack to deal with persistence:

 - Embedded Cassandra as direct storage (`CassandraDaemon` allows to have the Cassandra instance inside same JVM as the application)
 - JanusGraph as Graph DBMS (it is not directly a data storage, it just allows you to have access to data in the form of a graph)
 - [Apache TinkerPop](http://tinkerpop.apache.org/docs/current/reference/)  as a set of tools to interact with the database
 - [spring-data-neo4j](https://github.com/spring-projects/spring-data-neo4j) to manage transactions in Spring with `Neo4jTransactionManager` and implement custom Cypher queries with Spring Data repositories (by custom queries means `@org.springframework.data.neo4j.annotation.Query` annotation)
 - [cypher-for-gremlin](https://github.com/opencypher/cypher-for-gremlin) which translates Cypher queries into Gremlin traversals (it has some issues which prevents us to use it for `neo4j-ogm` CRUD operations, these issues will be explained below)
 - [neo4j-ogm](https://github.com/neo4j/neo4j-ogm) to map Java POJOs into Vertices and Edges of Graph
 - we also use custom `EntityTraversalAdapters`, which implements anonimous Gremlin traversals for CRUD operations under `neo4j-ogm` entities.

# Vertices and Edges

Unlike a Relational DBMS, Graph DBMS have vertices and edges, not rows and tables. So in terms of Graph every persistent entity should be stored as Vertex or Edge. An example of a vertex might be `Artifact` or `AritfactCoordinates` and the relation between them would be an edge. It should be noted that, unlike RDBMS, object relations are represented by separate edge instead of just foreign key column in table. In addition to vertices, persistence objects can also be an edges, as an example the `ArtifactDependency` would be an edge between `ArtifactCoordinates` vertices.

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
CRUD operations implemented in it as well). Place your code under the `org.carlspring.strongbox.domain` 
package. For the sake of the example, let's pick `PetEntity` as the name of your entity.

If you want to store that entity properly you need to adopt the following rules:

* Create the interface for your entity with all getters and setters that required to interact with the entity, according to the `JavaBeans` coding convention. This interface should extend `org.carlspring.strongbox.data.domain.DomainObject`. The need for an interface is due to hide the implementation specific details depending on underlying database, such as inheritance strategy.
* Create the entity class which implements the above interface and have the `org.carlspring.strongbox.data.domain.DomainEntity` as the superclass.
* Declare entity class with `@NodeEntity` or `@RelationshipEntity`
* Define a default empty constructor, this would need to create entity instance from `neo4j-ogm` internals.

The complete source code example that follows all requirements should look something like this:

```java
package org.carlspring.strongbox.domain;

@NodeEntity("Pet")
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

## Creating a `EntityTraversalAdapter`

As mentioned above besides `neo4j-ogm` and `spring-data-neo4j` we were forced to use custom CRUD implementations based on Gremlin. This has its advantages as it allow for us to optimize OGM entities and make them faster then common `neo4j-ogm` provide out of the box. The main thing of the Gremlin based CRUD is `EntityTraversalAdapter` which is a strategy for create/update, read/delete operations. The concrete `EntityTraversalAdapter` provide [Anonymous traversals](http://tinkerpop.apache.org/docs/current/tutorials/gremlins-anatomy/) for each of the operations on specific entity type. These traversals used in Gremlin based repositories to perform common CRUD operations:

- `fold` to construct entity instance based on Vertex/Edge and it's properties
- `unfold` to extract entity properties into Vertex/Edge and it's properties
- `cascade` to cascade other Vertices/Edges within delete if needed

The `EntityTraversalAdapter` implementations can also use each other to support relations between entities, inheritance and cascade operations.

Below is the code example of `EntityTraversalAdapter` implementation for `PetEntity`:

```java
package org.carlspring.strongbox.gremlin.adapters;

import static org.carlspring.strongbox.gremlin.adapters.EntityTraversalUtils.extractObject;

import java.util.Collections;
import java.util.Map;
import java.util.Set;

import org.apache.tinkerpop.gremlin.process.traversal.Traverser;
import org.apache.tinkerpop.gremlin.structure.Element;
import org.apache.tinkerpop.gremlin.structure.Vertex;
import org.carlspring.strongbox.domain.Pet;
import org.carlspring.strongbox.domain.PetEntity;
import org.carlspring.strongbox.gremlin.dsl.EntityTraversal;
import org.carlspring.strongbox.gremlin.dsl.__;
import org.springframework.stereotype.Component;

@Component
public class PetAdapter extends VertexEntityTraversalAdapter<Pet>
{

    @Override
    public Set<String> labels()
    {
        return Collections.singleton("Pet");
    }

    @Override
    public EntityTraversal<Vertex, Pet> fold()
    {
        return __.<Vertex, Object>project("uuid", "age")
                 .by(__.enrichPropertyValue("uuid"))
                 .by(__.enrichPropertyValue("age"))
                 .map(this::map);
    }

    private Pet map(Traverser<Map<String, Object>> t)
    {
        PetEntity result = new PetEntity();
        result.setUuid(extractObject(String.class, t.get().get("uuid")));
        result.setAge(extractObject(Integer.class, t.get().get("age")));

        return result;
    }

    @Override
    public UnfoldEntityTraversal<Vertex, Vertex> unfold(Pet entity)
    {
        EntityTraversal<Vertex, Vertex> t = __.<Vertex>identity();
        if (entity.getAge() != null)
        {
            t = t.property(single, "age", entity.getAge());
        }
    
        return new UnfoldEntityTraversal<>("Pet", t);
    }

    @Override
    public EntityTraversal<Vertex, ? extends Element> cascade()
    {
        return __.identity();
    }

}

```

## Creating a `Repository`

All the database interactions should be done through repositories. For the compatibility with `spring-data` we use `org.springframework.data.repository.CrudRepository` as a basis for our repositories. The base class for implementing `EntityTraversalAdapter`-based repositories is `org.carlspring.strongbox.gremlin.repositories.GremlinRepository`. Further repository implementation depends on the type of entity, for Vertex backed entities it should be `GremlinVertexRepository`.
In addition to CRUD operations, there is also need the ability to select data using queries. Queries could be implemented using [Cypher](https://neo4j.com/docs/cypher-manual/current/introduction/) through  `spring-data-neo4j` and `@org.springframework.data.neo4j.annotation.Query` annotation. So the final repository should be a class that extends `GremlinRepository` and delegates custom `Cypher` queries into `org.springframework.data.repository.Repository` instance provided by `spring-data-neo4j`.

Putting all above together the repository for the `PetEntity` will looks like below:

```
package org.carlspring.strongbox.repositories;

import javax.inject.Inject;

import org.carlspring.strongbox.domain.Pet;
import org.carlspring.strongbox.gremlin.adapters.PetAdapter;
import org.carlspring.strongbox.gremlin.repositories.GremlinVertexRepository;
import org.springframework.stereotype.Repository;

@Repository
public class PetRepository extends GremlinVertexRepository<Pet>
        implements PetQueries
{

    @Inject
    PetAdapter adapter;
    
    @Inject
    PetQueries queries;

    @Override
    protected PetAdapter adapter()
    {
        return adapter;
    }

    List<Pet> findByAgeGreater(Integer age)
    {
        return queries.findByAgeGreater(age);
    }

}

@Repository
interface PetQueries
        extends org.springframework.data.repository.Repository<Pet, String>
{

    @Query("MATCH (pet:Pet) " +
           "WHERE pet.age > $age " +
           "RETURN pet")
    List<Pet> findByAgeGreater(@Param("age") Integer age);

}
```

# Issues of `cypher-for-gremlin` and `neo4j-ogm`

First issue was the fact that `cypher-for-gremlin` not fully suport all Cypher syntax that produced by `neo4j-ogm` for CRUD operations. In more detail on every CRUD operation `neo4j-ogm` generate Cypher query which then translates into Gremlin by `cypher-for-gremlin`. As a workadound we modify Cypher queries produced by `neo4j-ogm` and replace some clauses (see `org.opencypher.gremlin.neo4j.ogm.request.GremlinRequest`). 

Another issue is that `cypher-for-gremlin` have some doubtful concept to work with `null` values in Gremlin. They put a lot of noisy tokens into Gremlin traversals which prevents JanusGraph engine to match expected indexes, this causes heavy fullscan on every query (see [#342](https://github.com/opencypher/cypher-for-gremlin/issues/342)).  This was the main reason of why we can't use `neo4j-ogm` for CRUD operations.
Anyway we still using it for custom Cypher queries with `@org.springframework.data.neo4j.annotation.Query` annotation. This is good option to have Cypher queries  instead of Gremlin because it looks more clear and takes less time to read existing and write new queries.

```
