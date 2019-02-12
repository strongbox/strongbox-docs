# Layout Providers

## Introduction

The different layout formats (like Maven, NuGet, NPM and so on) are implemented as what we call `layout providers`.

Layout providers are responsible for handling things like:

- Deployment of artifacts
- Resolving of artifacts
- Management of artifacts
- Implementation of commands and features, specific only to the respective layout provider

## See also

* [Writing a layout provider]
* [Built-in providers]

[Writing a layout provider]: ../developer-guide/layout-providers/how-to-implement-your-own-repository-format.md
[Built-in providers]: ../developer-guide/layout-providers/maven-2-layout-provider.md
