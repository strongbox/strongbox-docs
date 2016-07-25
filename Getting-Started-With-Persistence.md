## Abstract

This page contains explanations and code samples for developers who need to store their entities into the database. 

The Strongbox project uses [OrientDB](http://orientdb.com/orientdb/) as its internal persistent storage through the [Spring Data](http://projects.spring.io/spring-data/) interface which, in term, is implemented as the [spring-data-orientdb](https://github.com/orientechnologies/spring-data-orientdb) open source project.

## Adding Dependencies

Let's assume that you, as a Strongbox developer, need to create a new module or write some persistence code in an existing module that does not contain any persistence dependencies yet. (Otherwise you will already have the proper `<dependencies/>` section in your `pom.xml`, similar to the one in the example below). You will need to add the following code snippet to your module's `pom.xml` under the `<dependencies>` section:

    <dependency>
        <groupId>${project.groupId}</groupId>
        <artifactId>strongbox-data-service</artifactId>
        <version>${project.version}</version>
    </dependency>

Notice that there is no need to define any direct dependencies on OrientDB or Spring Data - it's already done via the `strongbox-data-service` module.

## Creating Your Entity Class

Let's now assume that you have a POJO and you need to save it to the database (and that you probably have at least CRUD operation's implemented in it as well). Place your code under the `org.carlspring.strongbox.domain.yourstuff` package. For the sake of the example, let's pick `MyEntity` as the name of your entity.

If you want to store that entity properly you need to adopt the following rules:
* Extend the `org.carlspring.strongbox.data.domain.GenericEntity` class to inherit all required fields and logic from the superclass.
* Define getters and setters according to the `JavaBeans` coding convention for all non-transient properties in your class.
* Define a default empty constructor for safety (even if the compiler will create one for you, if you don't define any other constructors) and follow the `JPA` and `java.io.Serializable` standards.
* Override the `equals() `and `hashCode()` methods according to java `hashCode` contract (because your entity could be used in collection classes such as `java.util.Set` and if you don't define such methods properly other developers or yourself will be not able to use your entity).
* _Optional_ - define a `toString()` implementation to let yourself and other developers see something meaningful in the debug messages.

The complete source code example that follows all requirements should look something like this:

    package org.carlspring.strongbox.domain;
    
    import org.carlspring.strongbox.data.domain.GenericEntity;
    
    import com.google.common.base.Objects;
    
    public class MyEntity
            extends GenericEntity
    {
    
        private String property;
    
        public MyEntity()
        {
        }
    
        public String getProperty()
        {
            return property;
        }
    
        public void setProperty(String property)
        {
            this.property = property;
        }
    
        @Override
        public boolean equals(Object o)
        {
            if (this == o)
            {
                return true;
            }
            if (o == null || getClass() != o.getClass())
            {
                return false;
            }
            
            MyEntity myEntity = (MyEntity) o;

            return Objects.equal(property, myEntity.property);
        }
    
        @Override
        public int hashCode()
        {
            return Objects.hashCode(property);
        }
    
        @Override
        public String toString()
        {
            final StringBuilder sb = new StringBuilder("MyEntity{");
            sb.append("property='").append(property).append('\'');
            sb.append('}');
            
            return sb.toString();
        }
    }

## Creating a DAO Layer

You will need to create at least a repository and service classes to take advantage of [spring-data-orientdb](https://github.com/orientechnologies/spring-data-orientdb)'s code generation.

For the repository class, (don't forget that the interface is also a class in Java), you will need to follow this rules:
* Extend Spring Configuration with the package name that your repository classes are defined for the current module to make repositories observable using the `@EnableOrientRepositories` annotation:

`@EnableOrientRepositories(basePackages = "org.carlspring.strongbox.repository")`

* Annotate the repository interface with the `@Transactional` annotation
* Let your interface to the `OrientRepository<MyEntity>` class
* _Optional_ - define any other methods according to the Spring Data possibilities to generate the respective service code (take a look at the example below).

The complete code example for the repository class should look something like this:

    package org.carlspring.strongbox.users.repository;
    
    import org.carlspring.strongbox.data.repository.OrientRepository;
    import org.carlspring.strongbox.users.domain.MyEntity;
    import org.carlspring.strongbox.users.domain.User;
    
    import org.springframework.transaction.annotation.Transactional;
    
    /**
     * Spring Data CRUD repository for {@link org.carlspring.strongbox.users.domain.MyEntity}.
     *
     * @author Alex Oreshkevich
     */
    @Transactional
    public interface MyEntityRepository
            extends OrientRepository<MyEntity>
    {
        MyEntity findByProperty(String property);
    }

Besides the built-in CRUD methods, we also define a `findByProperty()` method which is equivalent to the following SQL code:

    SELECT * FROM MyEntity WHERE property = 'some_property';

Feel free to create additional methods if you need them. For the complete reference on how to work with repositories, please check the [Spring Data Commons : Using repositories](http://docs.spring.io/spring-data/data-commons/docs/current/reference/html/#repositories) reference.

Similar requirements are defined for all service interfaces. Please review the sample code below:

    package org.carlspring.strongbox.users.service;
    
    import org.carlspring.strongbox.data.service.CrudService;
    import org.carlspring.strongbox.users.domain.MyEntity;
    
    import org.springframework.transaction.annotation.Transactional;
    
    /**
     * CRUD service for managing {@link MyEntity} entities.
     *
     * @author Alex Oreshkevich
     */
    @Transactional
    public interface MyEntityService
            extends CrudService<MyEntity, String>
    {
    
        MyEntity findByProperty(String property);
    
    }

You will need to extend the `CrudService` with the second type parameter that corresponds to your ID's data type. Usually it's just strings. To read more about ID's in OrientDB, check [here](http://orientdb.com/docs/2.0/orientdb.wiki/Tutorial-Record-ID.html).

After that you will need to define an implementation of your service class. The repository class implementation would be generated internally.

Follow these rules for the service implementation:
* Name it like your service interface with an `Impl` suffix, for example `MyEntityServiceImpl`.
* Annotate your class with the Spring `@Service` and `@Transactional` annotations.
* Add `synchronized` modifier on all of your service class methods.
* Do **not** define your service class as public and use interface instead of class for injection (with `@Autowired`); this follows the best practice principles from Joshua Bloch 'Effective Java' book called Programming to Interface
* _Optional_ - feel free to use `@Cacheable` whenever you need to use second level cache that's already configured in the project (do not forget to modify `ehcache.xml` file accordingly) 
