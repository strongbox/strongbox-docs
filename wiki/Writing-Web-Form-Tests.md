# General
## Basic rules
* The main goal of testing web form model classes is to check all possible validation combinations in the associated form.
* The classes from `strongbox-web-forms` module are tested inside the `strongbox-web-core` module, following the same package naming as its original module.
* A web form model class is testable **only** if it has any validation annotation (both library and custom annotations).
* The list of validation annotations to be used can be found at [Java EE Javadoc](https://javaee.github.io/javaee-spec/javadocs/javax/validation/constraints/package-summary.html).

# Web form model class
A web form model class is an entity that represents the fields in a form. In most occasions it will be needed to validate some or all the form fields, whose validation(s) will depend on the field type and its purpose. An example of a class like this would be:

```
package org.carlspring.strongbox.forms;

import javax.validation.constraints.NotEmpty;

public class PrivilegeForm
{

    @NotEmpty(message = "A name must be specified.")
    private String name;

    private String description;

    public PrivilegeForm()
    {
    }

    public PrivilegeForm(String name,
                         String description)
    {
        this.name = name;
        this.description = description;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public String getDescription()
    {
        return description;
    }

    public void setDescription(String description)
    {
        this.description = description;
    }
}
```

This class represents a form in which a user privilege will be managed. In this case, the `name` field is annotated with `@NotEmpty` validation and an error message. This means that the annotated element must not be null nor empty, otherwise the error message indicated will be prompted.

# Building the test for the web form model class
1. Annotate the class with `@IntegrationTest` and `@ExtendWith(SpringExtension.class)` to state that it is an integration test which uses JUnit 5 framework.
2. The class must be a sub-class of `RestAssuredBaseTest` class to inherit all rest-assured initialization stuff. In order to be initialized before each test method, it is needed to override the `init` method and annotate it with `@BeforeEach`.
3. The validator which will test the field must be injected into the class.
4. The system behaviour for this kind of tests are based in **Given-When-Then** style. The **given** part describes the state of the world before you begin the behavior you're specifying in this scenario. You can think of it as the pre-conditions to the test. The **when** section is that behavior that you're specifying. Finally the **then** section describes the changes you expect due to the specified behavior.
5. The part of form validation is pretty auto-explanable. These validations are saved into a set of constraint violations, and then it is checked if this set is empty or not. If it is not empty, it means that the web form model class has errors, and the error messages are checked.

```
package org.carlspring.strongbox.forms;

import org.carlspring.strongbox.config.IntegrationTest;
import org.carlspring.strongbox.rest.common.RestAssuredBaseTest;
import org.carlspring.strongbox.users.domain.Privileges;

import javax.inject.Inject;
import javax.validation.ConstraintViolation;
import javax.validation.Validator;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import static org.assertj.core.api.Java6Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;

@IntegrationTest
@ExtendWith(SpringExtension.class)
public class PrivilegeFormTestIT
        extends RestAssuredBaseTest
{

    @Inject
    private Validator validator;

    @Override
    @BeforeEach
    public void init()
            throws Exception
    {
        super.init();
    }

    @Test
    void testPrivilegeFormValid()
    {
        // given
        PrivilegeForm privilegeForm = new PrivilegeForm();
        String privilegeName = Privileges.AUTHENTICATED_USER.name();
        privilegeForm.setName(privilegeName);

        // when
        Set<ConstraintViolation<PrivilegeForm>> violations = validator.validate(privilegeForm);

        // then
        assertTrue(violations.isEmpty(), "Violations are not empty!");
    }

    @Test
    void testPrivilegeFormInvalidEmptyName()
    {
        // given
        PrivilegeForm privilegeForm = new PrivilegeForm();
        String privilegeName = StringUtils.EMPTY;
        privilegeForm.setName(privilegeName);

        // when
        Set<ConstraintViolation<PrivilegeForm>> violations = validator.validate(privilegeForm);

        // then
        assertFalse(violations.isEmpty(), "Violations are empty!");
        assertEquals(violations.size(), 1);
        assertThat(violations).extracting("message").containsAnyOf("A name must be specified.");
    }
}
```
