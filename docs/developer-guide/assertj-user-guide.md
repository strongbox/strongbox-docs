# AssertJ User Guide

## Assertions

All AssertJ assertions are static methods in the `org.assertj.core.api.Assertions` class.

AssertJ assertions always look like 
`assertThat(testedValue).<condition>(realValue)`.

For example, when we want to check if objects are equal, we would use:

`assertThat("actual string").isEqualTo("expected string")`

If we would like to to add a description to our assertion, we would use `as(description)`.

For example:

`assertThat("actual string").as("Values should be equal").isEqualTo("expected string")`

| Assertion     | Condition     | 
 | ------------- | ------------- |
 | `fail()` | Fails a test with the given failure message |
 | `isTrue()` | If we want to verify that a boolean value is true |
 | `isSameAs(object)` | If we want to ensure that two objects refer to the same object |
 | `isNull()` | If we want to verify that an object is null |
 | `hasSize(int)` | If we want to verify size of collection |
 | `isEmpty()` | If we want to verify that collection is empty |
 | `isNotSameAs(object)` | If we want to ensure that two objects don't refer to the same object |
 | `isNotEqualTo(object)` | If we want to verify that the expected value (or object) is not equal to the actual value (or object) |
 | `isNotNull()` | If we want to verify that an object is not null |
 | `isFalse()`| If we want to verify that a boolean value is false |
 | `isEqualTo()` | If we want to verify that the expected value (or object) is equal to the actual value (or object) |
 | `isThrownBy(supplier)` | If we want to write assertions for the exceptions thrown by the system |
