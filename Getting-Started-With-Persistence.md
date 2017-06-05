## Abstract

This page contains explanations and code samples for developers who need to store their entities into the database. 

The Strongbox project uses [OrientDB](http://orientdb.com/orientdb/) as its internal persistent storage through the corresponding `JPA` implementation and `spring-orm` middle tier. Also we use `JTA` for transaction management and `spring-tx` implementation module from Spring technology stack.

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

First of all you will need to extend the `CrudService` with the second type parameter that corresponds to your ID's data type. Usually it's just strings. To read more about ID's in OrientDB, check [here](http://orientdb.com/docs/2.0/orientdb.wiki/Tutorial-Record-ID.html).

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

After that you will need to define an implementation of your service class. 

Follow these rules for the service implementation:
* Inherit your CURD service from `CommonCrudService<MyEntity>` class:
* Name it like your service interface with an `Impl` suffix, for example `MyEntityServiceImpl`.
* Annotate your class with the Spring `@Service` and `@Transactional` annotations.
* Do **not** define your service class as public and use interface instead of class for injection (with `@Autowired`); this follows the best practice principles from Joshua Bloch 'Effective Java' book called Programming to Interface
* _Optional_ - feel free to use `@Cacheable` whenever you need to use second level cache that's already configured in the project (do not forget to modify `ehcache.xml` file accordingly) 
* _Optional_ - define any methods you need to work with your `MyEntity` class, based on common CRUD methods form `javax.persistence.EntityManager`, or custom queries (which can be done with 
 entityManager.getDelegate().command(oQuery).execute(params)`).

## Register entity schema in EntityManager
Before using entities you will need to register them. Consider the following example:

    @Inject
    private OEntityManager oEntityManager;

    @PostConstruct
    public void init() {
        oEntityManager.registerEntityClass(MyEntity.class);
    }