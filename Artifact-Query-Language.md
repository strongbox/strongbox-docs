# Introduction

Artifact Query Language (AQL) allows to search artifacts easy and consistent across all layouts. 

## AQL Synax

Search queries are constructed using _**Tokens**_ where each token is a pair of `<key>:<value>` separated with `:`.

#### Keys

The full list of possible `keys` will vary depending on the enabled layout providers, but the following common list needs to work the same across all layouts:

| Key        | Description     | 
| ---------- |---------------- |
| storage    | Search for artifacts in a specific **storage id**|
| repository | Search for artifacts in a specific **repository id**|
| layout     | Search for artifacts in a specific **repository layout**|
| version    | Search an artifact by **version**|
| tag        | Search for artifacts with available **tag name**|
| from       | Search for uploaded artifacts starting **date** (unicode format, results include the date)|
| to         | Search for uploaded artifacts before **date** (unicode format, results include the date)|
| age        | Constant: `day`, `month`, `year`, etc.|
| asc        | Order results ascending|
| desc       | Order results descending|


The list below shows the specific `keys` for each layout.

||| 
| ---------- |---------------- |
| _**Maven**_      ||
|| groupId        |
|| artifactId     |
|| version        |
|| classifier     |
|| extension      |
| _**Nuget**_           ||
|| Id             |
|| Version        |
| _**Npm**_             ||
|| scope          |
|| name           |
|| version        |

#### Values

* _**Values**_ can be strings:
    * quoted with single quotes `'` when the value is more than one word (Valid Examples: `storage: storage0`, `layout: 'Maven 2'`)
    * separated with comma `,` for multiple values; you can consider this the same as `IN` operator in SQL  (Valid Examples: `repository: releases, snapshots`, `layout: 'Maven 2', NuGet`)
    * wildcards are supported `*` (Valid Examples: `group: org.carlspring.*`)

* _**Values**_ can be dates in unicode format: `2018-03-21 13:00:00`, `2018-03-21` (Valid Examples: `updated: 2018-03-21`, `updated: '2018-03-21 13:00'`)

* _**Values**_ can be keywords/constants: `day`, `month`, `year`, etc. (Valid Examples: `age: >= 30d`)

## Query expression

* Queries are composed using `Tokens` to create an expression:
    ```
    storage:storage0 repository:releases
    ```
&nbsp;    

* Expression parts can be surrounded by round brackets for more advanced queries. The following examples are equal: 
    ```
    storage:storage0 repository:releases
    ``` 
    ```
    (storage:storage0)(repository:releases)
    ```
    ```
    ((storage:storage0) (repository:releases))
    ```
&nbsp;    
* Expression parts can be joined by logical operators:
    * `AND` is implied by default and means logical conjunction (equivalent synonymous: `&`,`&&`)
    * `OR` means logical disjunction (equivalent synonymous: `|`,`||`)
    * The following examples are equal:
        ```
        storage:storage0 repository:releases
        ```
        ```
        (storage:storage0)(repository:releases)
        ``` 
        ```
        (storage:storage0) AND (repository:releases)
        ``` 
        ```
        storage:storage0 && repository:releases
        ```
&nbsp;    
* Expression parts can be prefixed with `+` and `-` for `inclusion` or `negation`. 
    * `+` is implied by default and means no negation (by and large does not mean anything, you can use it simply for clarity)
    * `-` means logical negation
    * The following examples are equal:
        ```
        storage:storage0 repository:releases NOT groupId: 'org.carlspring'
        ```
        ```
        storage:storage0 AND +repository:releases AND NOT groupId: 'org.carlspring'
        ``` 
        ```
        +(storage:storage0)+(repository:releases)-(groupId: 'org.carlspring')
        ``` 

# How to use

You can use AQL with UI search bar, which also provide autocomplete, or directly with REST API Endpoint.