The different layout formats (like Maven, NuGet, NPM and so on) are implemented as what we call "layout providers".

Layout providers are responsible for handling things like:
- Deployment of artifacts
- Resolving of artifacts
- Management of artifacts
- Implementation of commands and features, specific only to the respective layout provider

# Information For Developers

The code for the layout providers is located under the [strongbox-storage-layout-providers](https://github.com/strongbox/strongbox/tree/master/strongbox-storage/strongbox-storage-layout-providers/).

For more details on how to implement your own layout provider, please check the guide on [[How To Implement Your Own Repository Format]].
