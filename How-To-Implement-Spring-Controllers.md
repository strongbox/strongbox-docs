# Preface

This guideline aims to outline some of the basic expectations that must be met before you can commit your code. The scope
of this guide are controllers which will be used by the front-end. Controllers which are specific to handling traffic 
such as downloading/uploading/processing artifacts are out of this scope and need to be discussed before proceeding. 
In case you have doubts, conflicts or any questions/ideas, please don't hesitate to message us on gitter!

The key words "**MUST**", "**MUST NOT**", "**REQUIRED**", "**SHALL**", "**SHALL NOT**", "**SHOULD**", "**SHOULD NOT**", 
"**RECOMMENDED**", "**MAY**", and "**OPTIONAL**" in this document are to be interpreted as described in [RFC 2119](https://tools.ietf.org/html/rfc2119).

# General rules

<a name="general-rule-1"></a>
[1.](#general-rule-1) You **MUST** have your controller stored in `./strongbox-web-core/src/main/java/org/carlspring/strongbox/controllers` 
or a proper sub-directory in that path.

<a name="general-rule-2"></a> 
[2.](#general-rule-2) You **MUST** have test cases which cover as much as possible your controller.

<a name="general-rule-3"></a> 
[3.](#general-rule-3) Your endpoints **MUST** always be able to produce `MediaType.APPLICATION_JSON_VALUE`.

<a name="general-rule-4"></a> 
[4.](#general-rule-4) If your controller/method is going to be processing data submitted by a client, you **MUST** use 
Spring Form Validation and follow the [Spring Form Validation Rules](#form-validation) which also shows an example.

<a name="general-rule-5"></a>
[5.](#general-rule-5) You **MUST** respond with an appropriate status code and `successful` or `failed` message 
when an action has been completed (i.e. user created/updated/deleted). `BaseController` has already implemented methods for these cases.

   - Status code for **successful** operations **MUST** be `200 OK`
   - Status code for **failed** operations **SHOULD** be `400 Bad Request` or any other status code which better describes the issue.
   - When possible, the failure message **SHOULD** contain some information about why the operation has failed - i.e username already exists. 
   - You **SHOULD** avoid using `e.getMessage()` because it's not immediately apparent what's wrong and the user might not 
     even know what the exception message means. 

<a name="general-rule-5.1"></a>
[5.1](#general-rule-5.1) When returning a `successful` or `failed` message, you **MUST** also take into account 
the request's `Accept` header and respond with `MediaType.APPLICATION_JSON_VALUE` for `Accept: application/json` 
and `MediaType.TEXT_PLAIN_VALUE` for `Accept: text/plain`. 

   - Your `text/plain` response **MUST** only contain an informative message in the response body as shown in the examples below. 
   - Your `application/json` response **MUST** contain an informative message and **MAY** contain additional information (i.e. [form errors](#general-rule-5-example-json)) 
   
   <a name="general-rule-5-example-plain-text"></a> 
   - [Example for text/plain response](#general-rule-5-example-plain-text)  
     - Client `Accept: text/plain` and performed operation was ***successful***
       ```
       Status: 200 OK
       Body: User was successfully created!
       ```   
     - Client `Accept: text/plain` and performed operation has ***failed*** (i.e. form validation failed or something else happened)
       ```
       Status: 400 Bad Request
       Body: User cannot be saved because the submitted form contains errors!
       ```
     - Client `Accept: text/plain` and performed operation has ***failed*** (i.e. form validation failed or something else happened)
       ```
       Status: 409 Conflict
       Body: User with the same username has already been registered.  
       ```   

   <a name="general-rule-5-example-json"></a> 
   - [Examples for JSON response](#general-rule-5-example-json)  
     - Client `Accept: application/json` and performed operation was ***successful***
       ```
       Status: 200 OK
       Body: 
       {
          "message": "User was successfully created!"
       }     
       ```   
     - Client `Accept: application/json` and performed operation has ***failed*** because submitted form data was invalid.
       ```
       Status: 400 Bad Request
       Body:
       {
         "message": "User cannot be saved because the submitted form contains errors!",
         "errors": [
           {
             "password": [
               "This field is less than 6 characters long!",
               "This field requires at least 2 capital letters"
             ]
           },
           {
             "username": [
               "Username is already registered."
             ]
           }
         ]
       }
       ```
     - Client `Accept: application/json` and performed operation has ***failed*** for whatever other reason.
       ```
       Status: 409 Conflict
       Body:
       {
          "message": "User with the same username has already been registered."
       } 
       ```

<a name="general-rule-6"></a>
[6.](#general-rule-6) `EntityBody` objects **SHOULD** be stored:

  -  in `./strongbox-web-core/src/main/java/org/carlspring/strongbox/controllers/support` or a proper sub-directory in that path.
  -  in the path/sub-path of the controller - i.e. `.../controllers/users/support`
    

<a name="general-rule-7"></a> 
[7.](#general-rule-7) You **SHOULD NOT** return status code `500` in a controller, except for cases when it's really unclear what 
might have gone wrong and that's truly the only reasonable response.

<a name="general-rule-8"></a>
[8.](#general-rule-8) When you return `JSON` and it contains collections - you **SHOULD** return them as an `array of objects` and not an `object` with properties. Doing otherwise will have negative effects because:
 - In JavaScript `{}` is considered to be an `object` and `[]` is an array. What happens if you return a collection in `{}` is you end up having an `object` with properties instead of an `array of objects`. This could happen if you use `Map<String, Collection<String>>` or other similar java types in the class you are converting to `JSON`.
 - TypeScript has static type-checking and this "bad" json requires some ugly coding for the compiler to get the code working.
 - The UI has form validation and can display collections, but for this to work it **requires** an array. Receiving "bad" json will require converting it from an `object with properties` to an `array of objects` so it can work in the frontend. Afterwards it has to be converted back to the old format to be acceptable by the backend for when the form is being submitted to the server. 
 - The UI is using [class-transformer](https://github.com/typestack/class-transformer) which transforms the received `JSON` into an actual `Class` so that will be broken as well.

In case you have doubts about this - feel free to ask us in [gitter](https://gitter.im/strongbox/strongbox?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)!

 
  - **"BAD" JSON** - You should avoid this unless it's specifically mentioned in the issue you're doing or there is a very, **very** good reason for this which has been approved.
    ```
    {
      "user": {
          "username": "my-user"
          "permissions": {
              "/some/path": ["READ", "WRITE"],
              "/some/other/path": ["READ"]
          }
      }
    }
    ```

  - **GOOD JSON**
    ```
    {
      "user": {
          "username": "my-user"
          "permissions": [
             {
                "path": "/some/path",
                "permissions": ["READ", "WRITE"]
             },
             {
                "path": "/some/other/path",
                "permissions": ["READ"]
             }
          ]
      }
    }
    ```

<a name="form-validation"></a>

# Spring Form Validation Rules 

These rules are only applied for Controllers which have Spring Form Validation (form validation for short).

<a name="form-validation-1"></a> 
[1.](#form-validation-1) You **MUST** store `Form` classes in `./strongbox-web-core/src/main/java/org/carlspring/strongbox/forms/` or a proper 
sub-directory in that path.

<a name="form-validation-2"></a>
[2.](#form-validation-2) Unless said otherwise, your validation endpoint **MUST** only consume **JSON**. 

<a name="form-validation-3"></a>
[3.](#form-validation-3) You **MUST** add validation rules to your form fields to avoid saving invalid data.   

<a name="form-validation-4"></a> 
[4.](#form-validation-4) You **MUST** follow the [General Rule #5](#general-rule-5) and [General Rule #5.1](#general-rule-5.1) and return a `successful` or `failed` 
message when the form has been processed. 

- If the form is invalid, when returning the **failure** message you **MUST** also include `errors` array which contains
the error messages per field (i.e. min length is N but user gave N-1 / field requires int but got string). Check the [Examples for JSON response](#general-rule-5-example-json) 
section.

<a name="form-validation-5"></a>
[5.](#form-validation-5) In case you are implementing a custom validator - you **SHOULD** follow the [Spring Framework Reference](https://docs.spring.io/spring/docs/current/spring-framework-reference/core.html#validation-beanvalidation-spring-constraints). 

# Example code

## Example Controller

```
package org.carlspring.strongbox.controllers;

import org.carlspring.strongbox.controllers.support.ExampleEntityBody;
import org.carlspring.strongbox.forms.ExampleForm;
import org.carlspring.strongbox.validation.RequestBodyValidationException;

import java.util.Arrays;
import java.util.List;

import io.swagger.annotations.*;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * This oversimplified example controller is written following the How-To-Implement-Spring-Controllers guide.
 * It's purpose is entirely educational and is meant to help newcomers.
 * <p>
 * https://github.com/strongbox/strongbox/wiki/How-To-Implement-Spring-Controllers
 *
 * @author Przemyslaw Fusik
 * @author Steve Todorov
 */
@RestController
@RequestMapping("/example-controller")
@Api(value = "/example-controller")
public class ExampleController
        extends BaseController
{

    public static final String NOT_FOUND_MESSAGE = "Could not find record in database.";


    @ApiOperation(value = "List available examples")
    @ApiResponses(value = { @ApiResponse(code = 200, message = "Everything went ok") })
    @GetMapping(value = "/all",
                consumes = MediaType.APPLICATION_JSON_VALUE,
                produces = { MediaType.APPLICATION_JSON_VALUE })
    public ResponseEntity getExamples()
    {
        List<String> list = Arrays.asList("a", "foo", "bar", "list", "of", "strings");
        return getJSONListResponseEntityBody("examples", list);
    }

    @ApiOperation(value = "Show specific example")
    @ApiResponses(value = { @ApiResponse(code = 200, message = "Everything went ok") })
    @GetMapping(value = "/get/{example}",
                consumes = MediaType.APPLICATION_JSON_VALUE,
                produces = { MediaType.TEXT_PLAIN_VALUE,
                             MediaType.APPLICATION_JSON_VALUE })
    public ResponseEntity getExample(@ApiParam(value = "Get a specific example", required = true)
                                     @PathVariable String example,
                                     @RequestHeader(HttpHeaders.ACCEPT) String accept)
    {
        if (example.equals("not-found"))
        {
            return getNotFoundResponseEntity(NOT_FOUND_MESSAGE, accept);
        }

        ExampleEntityBody body = new ExampleEntityBody(example);
        return ResponseEntity.ok(body);
    }

    @ApiOperation(value = "Update example's credentials.")
    @ApiResponses(value = { @ApiResponse(code = 200, message = "Everything went ok"),
                            @ApiResponse(code = 400, message = "Validation errors occurred") })
    @PostMapping(value = "/update/{example}",
                 consumes = MediaType.APPLICATION_JSON_VALUE,
                 produces = { MediaType.TEXT_PLAIN_VALUE,
                              MediaType.APPLICATION_JSON_VALUE })
    public ResponseEntity updateExample(
            @ApiParam(value = "Update a specific example using form validation", required = true)
            @PathVariable String example,
            @RequestHeader(HttpHeaders.ACCEPT) String accept,
            @RequestBody(required = false) @Validated ExampleForm exampleForm,
            BindingResult bindingResult)
    {
        if (example.equals("not-found"))
        {
            return getNotFoundResponseEntity(NOT_FOUND_MESSAGE, accept);
        }

        // In case of form validation failures - throw a RequestBodyValidationException.
        // This will be automatically handled afterwards.
        if (exampleForm == null)
        {
            throw new RequestBodyValidationException("Empty request body", bindingResult);
        }
        if (bindingResult.hasErrors())
        {
            throw new RequestBodyValidationException("Validation error", bindingResult);
        }

        return getSuccessfulResponseEntity("Credentials have been successfully updated.", accept);
    }

    @ApiOperation(value = "Delete an example")
    @ApiResponses(value = { @ApiResponse(code = 200, message = "Everything went ok"),
                            @ApiResponse(code = 404, message = "Example could not be found.") })
    @DeleteMapping(value = "/delete/{example}",
                   consumes = MediaType.APPLICATION_JSON_VALUE,
                   produces = { MediaType.TEXT_PLAIN_VALUE,
                                MediaType.APPLICATION_JSON_VALUE })
    public ResponseEntity deleteExample(@ApiParam(value = "Delete a specific example", required = true)
                                        @PathVariable String example,
                                        @RequestHeader(HttpHeaders.ACCEPT) String accept)
    {
        if (example.equals("not-found"))
        {
            return getNotFoundResponseEntity(NOT_FOUND_MESSAGE, accept);
        }

        return getSuccessfulResponseEntity("example has been successfully deleted.", accept);
    }

    @ApiOperation(value = "Handling exceptions")
    @ApiResponses(value = { @ApiResponse(code = 200, message = "Everything went ok"),
                            @ApiResponse(code = 500, message = "Something really bad and unpredictable happened.") })
    @GetMapping(value = "/handle-exception",
                consumes = MediaType.APPLICATION_JSON_VALUE,
                produces = { MediaType.TEXT_PLAIN_VALUE,
                             MediaType.APPLICATION_JSON_VALUE })
    public ResponseEntity handleExceptions(@RequestHeader(HttpHeaders.ACCEPT) String accept)
    {
        try
        {
            throw new Exception("Something bad happened.");
        }
        catch (Exception e)
        {
            String message = "This example message will be logged in the logs and sent to the client.";
            return getExceptionResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR, message, e, accept);
        }
    }
    
    @ApiOperation(value = "Handling unhadled exceptions")
    @ApiResponses(value = { @ApiResponse(code = 200, message = "Everything went ok"),
                            @ApiResponse(code = 500, message = "Something really bad and unpredictable happened.") })
    @GetMapping(value = "/unhandled-exception", consumes = MediaType.APPLICATION_JSON_VALUE, produces = { MediaType.TEXT_PLAIN_VALUE,
                                                                                                          MediaType.APPLICATION_JSON_VALUE })
    public ResponseEntity unhandledExceptions(@RequestHeader(HttpHeaders.ACCEPT) String accept) throws Exception
    {
        throw new Exception("Something bad happened.");
    }

}

```

## Example Form

```
package org.carlspring.strongbox.forms;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * @author Przemyslaw Fusik
 */
@XmlRootElement
@XmlAccessorType(XmlAccessType.FIELD)
public class ExampleForm
{

    @NotNull
    @Size(max = 64)
    private String username;

    @Size(min = 6, message = "This field is less than 6 characters long!")
    @Pattern(regexp = ".*[A-Z].*[A-Z].*", message = "This field requires at least 2 capital letters")
    private String password;

    public String getUsername()
    {
        return username;
    }

    public void setUsername(final String username)
    {
        this.username = username;
    }

    public String getPassword()
    {
        return password;
    }

    public void setPassword(final String password)
    {
        this.password = password;
    }
}
```

## Example Controller Test Case

```
package org.carlspring.strongbox.controllers;

import org.carlspring.strongbox.config.IntegrationTest;
import org.carlspring.strongbox.forms.ExampleForm;
import org.carlspring.strongbox.rest.common.RestAssuredBaseTest;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import static io.restassured.module.mockmvc.RestAssuredMockMvc.given;
import static org.hamcrest.CoreMatchers.containsString;
import static org.hamcrest.Matchers.*;

/**
 * @author Przemyslaw Fusik
 * @author Steve Todorov
 */
@IntegrationTest
@RunWith(SpringJUnit4ClassRunner.class)
public class ExampleControllerTest
        extends RestAssuredBaseTest
{

    @Test
    public void testGetExamplesResponse()
            throws Exception
    {
        given().accept(MediaType.APPLICATION_JSON_VALUE)
               .contentType(MediaType.APPLICATION_JSON_VALUE)
               .when()
               .get("/example-controller/all")
               .peek() // Use peek() to print the output
               .then()
               .statusCode(HttpStatus.OK.value())
               .body("examples", hasSize(greaterThan(0)));
    }

    @Test
    public void testGetExampleResponse()
            throws Exception
    {
        given().accept(MediaType.APPLICATION_JSON_VALUE)
               .contentType(MediaType.APPLICATION_JSON_VALUE)
               .when()
               .get("/example-controller/get/foo-bar")
               .peek() // Use peek() to print the output
               .then()
               .statusCode(HttpStatus.OK.value())
               .body("name", not(nullValue()));
    }

    @Test
    public void testGetNonExistingJsonExampleResponse()
            throws Exception
    {
        given().accept(MediaType.APPLICATION_JSON_VALUE)
               .contentType(MediaType.APPLICATION_JSON_VALUE)
               .when()
               .get("/example-controller/get/not-found")
               .peek() // Use peek() to print the output
               .then()
               .statusCode(HttpStatus.NOT_FOUND.value())
               .body("message", not(nullValue()));
    }

    @Test
    public void testGetNonExistingPlainExampleResponse()
            throws Exception
    {
        given().accept(MediaType.TEXT_PLAIN_VALUE)
               .contentType(MediaType.APPLICATION_JSON_VALUE)
               .when()
               .get("/example-controller/get/not-found")
               .peek() // Use peek() to print the output
               .then()
               .statusCode(HttpStatus.NOT_FOUND.value())
               .body(containsString(ExampleController.NOT_FOUND_MESSAGE));
    }

    @Test
    public void testDeleteExampleResponse()
            throws Exception
    {
        given().accept(MediaType.APPLICATION_JSON_VALUE)
               .contentType(MediaType.APPLICATION_JSON_VALUE)
               .when()
               .delete("/example-controller/delete/foo-bar")
               .peek() // Use peek() to print the output
               .then()
               .statusCode(HttpStatus.OK.value())
               .body("message", not(nullValue()));
    }

    @Test
    public void testDeleteNonExistingExampleResponse()
            throws Exception
    {
        given().accept(MediaType.APPLICATION_JSON_VALUE)
               .contentType(MediaType.APPLICATION_JSON_VALUE)
               .when()
               .delete("/example-controller/delete/not-found")
               .peek() // Use peek() to print the output
               .then()
               .statusCode(HttpStatus.NOT_FOUND.value())
               .body("message", not(nullValue()));
    }

    @Test
    public void testBadFormRequestWithJsonResponse()
            throws Exception
    {
        ExampleForm exampleForm = new ExampleForm();
        exampleForm.setPassword("god");

        given().accept(MediaType.APPLICATION_JSON_VALUE)
               .contentType(MediaType.APPLICATION_JSON_VALUE)
               .body(exampleForm)
               .when()
               .post("/example-controller/update/foo-bar")
               .peek() // Use peek() to print the output
               .then()
               .statusCode(HttpStatus.BAD_REQUEST.value())
               .body("message", not(nullValue()))
               .body("errors", hasSize(greaterThan(0)));
    }

    @Test
    public void testBadFormRequestWithPlainTextResponse()
            throws Exception
    {
        ExampleForm exampleForm = new ExampleForm();
        exampleForm.setPassword("god");

        given().accept(MediaType.TEXT_PLAIN_VALUE)
               .contentType(MediaType.APPLICATION_JSON_VALUE)
               .body(exampleForm)
               .when()
               .post("/example-controller/update/foo-bar")
               .peek() // Use peek() to print the output
               .then()
               .statusCode(HttpStatus.BAD_REQUEST.value())
               .body(containsString("Validation error"));
    }

    @Test
    public void testEmptyFormRequestBodyWithJsonResponse()
            throws Exception
    {
        given().accept(MediaType.APPLICATION_JSON_VALUE)
               .contentType(MediaType.APPLICATION_JSON_VALUE)
               .when()
               .post("/example-controller/update/foo-bar")
               .peek() // Use peek() to print the output
               .then()
               .statusCode(HttpStatus.BAD_REQUEST.value())
               .body("message", not(nullValue()));
    }

    @Test
    public void testEmptyFormRequestBodyWithPlainTextResponse()
            throws Exception
    {
        given().accept(MediaType.TEXT_PLAIN_VALUE)
               .contentType(MediaType.APPLICATION_JSON_VALUE)
               .when()
               .post("/example-controller/update/foo-bar")
               .peek() // Use peek() to print the output
               .then()
               .statusCode(HttpStatus.BAD_REQUEST.value())
               .body(containsString("Empty request body"));
    }

    @Test
    public void testValidFormRequestWithJsonResponse()
            throws Exception
    {
        ExampleForm exampleForm = new ExampleForm();
        exampleForm.setPassword("abcDEF1234");
        exampleForm.setUsername("my-username");

        given().accept(MediaType.APPLICATION_JSON_VALUE)
               .contentType(MediaType.APPLICATION_JSON_VALUE)
               .body(exampleForm)
               .when()
               .post("/example-controller/update/foo-bar")
               .peek() // Use peek() to print the output
               .then()
               .statusCode(HttpStatus.OK.value())
               .body("message", not(nullValue()));
    }

    @Test
    public void testValidFormRequestWithPlainTextResponse()
            throws Exception
    {
        ExampleForm exampleForm = new ExampleForm();
        exampleForm.setPassword("abcDEF1234");
        exampleForm.setUsername("my-username");

        given().accept(MediaType.TEXT_PLAIN_VALUE)
               .contentType(MediaType.APPLICATION_JSON_VALUE)
               .body(exampleForm)
               .when()
               .post("/example-controller/update/foo-bar")
               .peek() // Use peek() to print the output
               .then()
               .statusCode(HttpStatus.OK.value())
               .body(containsString("Credentials have been successfully updated"));
    }

    @Test
    public void testExceptionHandlingWithJsonResponse()
            throws Exception
    {
        given().accept(MediaType.APPLICATION_JSON_VALUE)
               .contentType(MediaType.APPLICATION_JSON_VALUE)
               .when()
               .get("/example-controller/handle-exception")
               .peek() // Use peek() to print the output
               .then()
               .statusCode(HttpStatus.INTERNAL_SERVER_ERROR.value())
               .body("message", containsString("This example message will be logged in the logs and sent to the client."));
    }

    @Test
    public void testExceptionHandlingWithPlainTextResponse()
            throws Exception
    {
        given().accept(MediaType.TEXT_PLAIN_VALUE)
               .contentType(MediaType.APPLICATION_JSON_VALUE)
               .when()
               .get("/example-controller/handle-exception")
               .peek() // Use peek() to print the output
               .then()
               .statusCode(HttpStatus.INTERNAL_SERVER_ERROR.value())
               .body(containsString("This example message will be logged in the logs and sent to the client."));
    }

    @Test
    public void testUnhandledExceptionHandlingWithJsonResponse()
            throws Exception
    {
        given().accept(MediaType.APPLICATION_JSON_VALUE)
               .contentType(MediaType.APPLICATION_JSON_VALUE)
               .when()
               .get("/example-controller/unhandled-exception")
               .peek() // Use peek() to print the output
               .then()
               .statusCode(HttpStatus.INTERNAL_SERVER_ERROR.value())
               .body("error", containsString("Something bad happened."));
    }

    @Test
    public void testUnhandledExceptionHandlingWithPlainTextResponse()
            throws Exception
    {
        given().accept(MediaType.TEXT_PLAIN_VALUE)
               .contentType(MediaType.APPLICATION_JSON_VALUE)
               .when()
               .get("/example-controller/unhandled-exception")
               .peek() // Use peek() to print the output
               .then()
               .statusCode(HttpStatus.INTERNAL_SERVER_ERROR.value())
               .body(containsString("Something bad happened."));
    }
    
}
```
