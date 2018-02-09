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


<a name="form-validation"></a>

Spring Form Validation Rules 
=====

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


Example code
=====

 * [ExampleController.java](https://github.com/strongbox/strongbox/blob/master/strongbox-web-core/src/main/java/org/carlspring/strongbox/controllers/ExampleController.java)
 * [ExampleControllerTest.java](https://github.com/strongbox/strongbox/blob/master/strongbox-web-core/src/test/java/org/carlspring/strongbox/controllers/ExampleControllerTest.java)
 * [ExampleForm.java](https://github.com/strongbox/strongbox/blob/master/strongbox-web-core/src/main/java/org/carlspring/strongbox/forms/ExampleForm.java)
