Preface
===

This guideline aims to outline some of the basic expectations that must be met before you can commit your code. The scope
of this guide are controllers which will be used by the front-end. Controllers which are specific to handling traffic 
such as downloading/uploading/processing artifacts are out of this scope and need to be discussed before proceeding. 
In case you have doubts, conflicts or any questions/ideas, please don't hesitate to message us on gitter!

[![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/strongbox/strongbox?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)  

The key words "**MUST**", "**MUST NOT**", "**REQUIRED**", "**SHALL**", "**SHALL NOT**", "**SHOULD**", "**SHOULD NOT**", 
"**RECOMMENDED**", "**MAY**", and "**OPTIONAL**" in this document are to be interpreted as described in [RFC 2119](https://tools.ietf.org/html/rfc2119).

General rules
=====

<a name="genral-rule-1"></a>
[1.](#genral-rule-1) You **MUST** have your controller stored in `./strongbox-web-core/src/main/java/org/carlspring/strongbox/controllers` 
or a proper sub-directory in that path.

<a name="genral-rule-2"></a> 
[2.](#genral-rule-2) You **MUST** have test cases which cover as much as possible your controller.

<a name="genral-rule-3"></a> 
[3.](#genral-rule-3) You **MUST** be able to respond with both `MediaType.TEXT_PLAIN_VALUE` and `MediaType.APPLICATION_JSON_VALUE` in your methods 
based on the `Accept` header the client provides. Only exception to this rule is [Spring Form Validation Rules #1](#spring-form-validation-rules-1)
in which case you only follow [CASE 2](#genral-rule-3-case-2) and return `406 Not Acceptable` for any other `Accept` header.

<a name="genral-rule-3-case-1"></a> 
   - [CASE 1](#genral-rule-3-case-1): When client header is `Accept: text/plain` - you **MUST** respond with the appropriate `text/plain` body.  
<a name="genral-rule-3-case-2"></a> 
   - [CASE 2](#genral-rule-3-case-2): When client header is `Accept: application/json` - you **MUST** respond with the appropriate **JSON** body.

<a name="genral-rule-4"></a>
[4.](#genral-rule-4) You **MUST** respond with an appropriate status code and `success` or `fail` message when an action has been completed 
(i.e. user created/updated/deleted). 
   
   - Status code for **successful** operations **MUST** be `200 OK` 
   - Status code for **failed** operations **SHOULD** be `400 Bad Request` or any other status code which better describes the issue.
   - When possible, the failure message **SHOULD** contain some information on why the operation has failed - i.e username already exists. 
     If possible, avoid using `e.getMessage()` because it's not immediately apparent what's wrong and the user might not 
     even know what the exception message means. 
   
     <a name="genral-rule-4-example-plain-text"></a> 
     [Example for text/plain response](#genral-rule-4-example-plain-text)  
     - Client `Accept: text/plain` and preformed operation was ***successful***
       ```
       Status: 200 OK
       Body: User was successfully created!
       ```   
     - Client `Accept: text/plain` and preformed operation has ***failed***
       ```
       Status: 400 Bad Request
       Body: Could not update strongbox port.
       ```
     - Client `Accept: text/plain` and preformed operation has ***failed***
       ```
       Status: 409 Conflict
       Body: User with the same username has already been registered.  
       ```   

     <a name="genral-rule-4-example-json"></a> 
     [Examples for JSON response](#genral-rule-4-example-json)  
     - Client `Accept: application/json` and preformed operation was ***successful***
       ```
       Status: 200 OK
       Body: 
       {
          "message": "User was successfully created!"
       }     
       ```   
     - Client `Accept: application/json` and preformed operation has ***failed***
       ```
       Status: 400 Bad Request
       Body:
       {
          "message": "Could not update strongbox port."
       } 
       ```
     - Client `Accept: application/json` and preformed operation has ***failed***
       ```
       Status: 409 Conflict
       Body:
       {
          "message": "User with the same username has already been registered."
       } 
       ```

<a name="genral-rule-5"></a> 
[5.](#genral-rule-5) You **SHOULD NOT** return status code `500` in a controller, except for cases when it's really unclear what 
might have gone wrong and that's truly the only reasonable response.


Spring Form Validation Rules 
=====

These rules are only applied for Controllers which have Spring Form Validation (form validation for short).

<a name="form-validation-1"></a>
[1.](#spring-form-validation-rules-1) You **MUST** only consume and produce **JSON** and **MUST NOT** accept nor respond 
with `text/plain`. In case you receive `Accept` header other than `Accept: application/json` respond with `406 Not Acceptable`. 

<a name="form-validation-2"></a> 
[2.](#spring-form-validation-rules-2) You still **MUST** follow the [General Rule #4](#genral-rule-4) excluding any parts related to `text/plain`.

- In addition, requests which have **failed** because of invalid form data 
(i.e. min lenth is N but user gave N-1 / field requires int but got string) **MUST** also include an additional array 
with the error messages for each field. For an example of how to do this, please visit [PR-507](https://github.com/strongbox/strongbox/pull/507)
and have a look at the [ValidationExampleController.java](https://github.com/strongbox/strongbox/pull/507/files#diff-6eb303eefb08293554763ba386061a34), 
[ExampleForm.java](https://github.com/strongbox/strongbox/pull/507/files#diff-af0bb63fe4729dfbd02811fb1a420dbc) and the 
[ValidationExampleControllerTest.java](https://github.com/strongbox/strongbox/pull/507/files#diff-2b07e0f2aa71c7474882ed0319c7dfcf).
In case you need to implement a custom validator, please follow the [Spring Framework Reference](https://docs.spring.io/spring/docs/current/spring-framework-reference/core.html#validation-beanvalidation-spring-constraints). 

  **Example JSON response**
  ```
  Status: 400 Bad Request
  Body:
  {
    "message": "Could not create user!",
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

<a name="form-validation-3"></a> 
[3.](#spring-form-validation-rules-3) You **MUST** store `Form` classes in `./strongbox-web-core/src/main/java/org/carlspring/strongbox/forms/` or a proper 
sub-directory in that path.
