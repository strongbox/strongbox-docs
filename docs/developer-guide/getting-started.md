# Getting started (Developer)

## Pre-requisites

* `Maven 3.6.3` (latest version preferred)
* `OpenJDK 1.8`, or `OracleJDK 1.8` (higher versions will not work yet)
* `Git` installed and in your `PATH` variable

## Before you continue

Please, place this [settings.xml]({{resources}}/maven/settings.xml) file under your `~/.m2` directory.
We have dependencies which are only available through our repository and if you skip this it will cause build failure.

```Linux tab= linenums="1"
mkdir ~/.m2
curl -o ~/.m2/settings.xml \
        {{resources}}/maven/settings.xml
```

```Windows tab= linenums="1"
mkdir %HOMEPATH%\.m2
curl -o %HOMEPATH%\.m2\settings.xml ^
        {{resources}}/maven/settings.xml
```

!!! tip
    You can use a different location to save our `settings.xml`. For example, you could save it as   
    `~/.m2/settings-strongbox.xml` and then specify this path when executing maven commands:
    ```
    mvn -s ~/.m2/settings-strongbox.xml clean install
    ```
