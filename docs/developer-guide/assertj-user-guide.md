# AssertJ User Guide

## Assertions

All AssertJ assertions are static methods in the `org.assertj.core.api.Assertions` class.

AssertJ assertions always looks like 
`assertThat(testedValue).<condition>(realValue)`

For example what we want to check the equality:

`assertThat("actual string").isEqualTo("expected string")`

If we want to add description for our assertion we should use `.as(description)`

For example:

`assertThat("actual string").as(Values should be equals).isEqualTo("expected string")`

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
