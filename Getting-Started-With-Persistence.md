## Abstract
This page contains explanations and code samples for developers who need to store their entities in the database. 

The Strongbox project uses [OrientDB](http://orientdb.com/orientdb/) as internal persistent storage through Spring Data interface that's implemented in open source project [spring-data-orientdb](https://github.com/orientechnologies/spring-data-orientdb).

## Adding dependencies
Let's assume that you as Strongbox developer was asked to create a new module or writing persistence code in the existing module that do not contain persistence dependencies yet. Otherwise you will have proper section in `pom.xml` as you will see in the code sample below. So, your module pom.xml file should contain the following code snippet in the `<dependencies>` section:

    <dependency>
        <groupId>${project.groupId}</groupId>
        <artifactId>strongbox-data-service</artifactId>
        <version>${project.version}</version>
    </dependency>

Notice that there is no need to define dependencies on OrientDB or Spring Data directly. It's already done in the `strongbox-data-service` module.

## Creating your entity class
Assume that you have some POJO and you need to save it in the database and probably have at least CRUD operation's under it as well. Your package will end up with the domain we believe and the name we just picked up was `MyEntity`. If you want to store that entity properly you need to adopt the following rules:
* extend `org.carlspring.strongbox.data.domain.GenericEntity` to receive all required fields and logic from superclass
* define getters and setters according to `JavaBeans` coding conventions for all non-transient properties in your class
* define default empty constructor for safety (even if compiler will create one for you if and only if you do not define other constructors) and to follow `JPA` and `java.io.Serializable` standards
* override properly `equals() `and `hashCode()` methods according to java hashCode contract (your entity could be used in the collection classes like `java.util.Set` somewhere, and, if you do not define such methods properly other developers or yourself will be not able to use your entity)
* _optional_ - define proper `toString()` implementation to let yourself and other developers see something meaningful in the debug messages

The complete source code example that follows all requirements could looks like the following:

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
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
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

## Creating DAO layer
You will need to create at least repository and service classes to take advantages of [spring-data-orientdb](https://github.com/orientechnologies/spring-data-orientdb) code generation.

For the repository class (don't forget, interface is also class in Java) you will need to follow this rules:
* extend Spring Configuration with package name where your repository classes are defined for current module to make repositories observable using `@EnableOrientRepositories` annotation:

`@EnableOrientRepositories(basePackages = "org.carlspring.strongbox.repository")`

* put `@Transactional` on the top of the repository interface
* let your interface to extend `OrientRepository<MyEntity>`
* _optional_ - define any other methods according to Spring Data possibilities to generate respective service code (take a look at the example below)

The complete code example for the repository class could looks like the following:

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

Besides the build-in CRUD methods we also define `findByProperty()` method that is equivalent to SQL code:

    select * from MyEntity where property = 'some_property';

Feel free to create additional methods if you need them. For the complete reference on how to work with repositories please visit [Spring Data Commons : Using repositories](http://docs.spring.io/spring-data/data-commons/docs/current/reference/html/#repositories) page.

Similar requirements are defined for all service interfaces. Please review code sample below:

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

You will need to extend CrudService with the second type parameter that corresponds to your ID's data type. Usually it's just strings. Read more about ID's in the OrientDB [here](http://orientdb.com/docs/2.0/orientdb.wiki/Tutorial-Record-ID.html).

After that you will need to define implementation for your service class. Repository class implementation would be generated internally. Follow this rules for the service implementation:
* name it like your service interface plus `Impl` tail, for example `MyEntityServiceImpl`
* put Spring `@Service` and `@Transactional` annotations on top of your class
* add `synchronized` modifier on all of your service class methods
* do NOT define your service class as public and use interface instead of class for injection (with `@Autowired`); it follows best practice principle from Joshua Bloch 'Effective Java' book called Programming to Interface
* _optional_ - feel free to use @Cacheable whenever you need to use second level cache that's already configured in the project (do not forget to modify `ehcache.xml` file accordingly) 

