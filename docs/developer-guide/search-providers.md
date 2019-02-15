# Search Providers

## Introduction

Search providers offer a way to execute searches against different search engines. By default, searches are executed 
against OrientDB, unless a search provider has been specified.

The idea behind search providers is that certain layout providers could require their own search engine, as is the 
case with Maven. Information about Maven artifacts is stored both in OrientDB and in the [Maven Indexer]. 
As the [Maven Indexer] can actually be consumed by various clients and tools (such as other repository managers, 
IDE-s and so on), we provided a way to further extend the searches for both existing and future layout providers which 
might also need to have their own search engine implementations, apart from the built-in one (OrientDB).  


## Implemented Search Providers

### OrientDbSearchProvider

The [OrientDbSearchProvider] is the default search provider which uses OrientDB.

### MavenIndexerSearchProvider

The [MavenIndexerSearchProvider] is the search provider for Maven artifacts when the [Maven Indexer] Lucene indexes 
should be queried.

## Implementing a Search Provider

Custom search providers should implement [SearchProvider] and register with [SearchProviderRegistry].

## Executing A Search Programmatically

### MavenIndexerSearchProvider Example

```java
@Inject
private ArtifactIndexesService artifactIndexesService;

// Run a search against the index and get a list of
// all the artifacts matching this exact GAV
SearchRequest request = new SearchRequest(storageId,
                                          repositoryId,
                                          "+g:" + groupId + " " +
                                          "+a:" + artifactId + " " +
                                          "+v:" + version,
                                          MavenIndexerSearchProvider.ALIAS);

try
{
    SearchResults results = artifactSearchService.search(request);
    
    for (SearchResult result : results.getResults())
    {
        String artifactPath = result.getArtifactCoordinates().toPath();
          
        logger.debug("Artifact path " + artifactPath);
          
        // Do something else here that is more meaningful
    }
}
catch (SearchException e)
{
    logger.error(e.getMessage(), e);
}
```

### OrientDbSearchProvider Example

```java
@Inject
private ArtifactIndexesService artifactIndexesService;

// Run a search against the database and get a list of
// all the artifacts matching this exact GAV
String query = "groupId=org.carlspring.strongbox.searches;" +
               "artifactId=test-project;";

SearchRequest request = new SearchRequest(storageId,
                                          repositoryId,
                                          query,
                                          OrientDbSearchProvider.ALIAS);

try
{
    SearchResults results = artifactSearchService.search(request);
    
    for (SearchResult result : results.getResults())
    {
        String artifactPath = result.getArtifactCoordinates().toPath();
          
        logger.debug("Artifact path " + artifactPath);
          
        // Do something else here that is more meaningful
    }
}
catch (SearchException e)
{
    logger.error(e.getMessage(), e);
}
```

## See Also
* [Maven Indexer]
* [REST-API]


[SearchProvider]: https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-api/src/main/java/org/carlspring/strongbox/providers/search/SearchProvider.java
[SearchProviderRegistry]: https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-api/src/main/java/org/carlspring/strongbox/providers/search/SearchProviderRegistry.java
[OrientDbSearchProvider]: https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-api/src/main/java/org/carlspring/strongbox/providers/search/OrientDbSearchProvider.java
[MavenIndexerSearchProvider]: https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-layout-providers/strongbox-storage-maven-layout-provider/src/main/java/org/carlspring/strongbox/providers/search/MavenIndexerSearchProvider.java
[REST-API]: ../user-guide/rest-api.md
[Maven Indexer]: ./maven-indexer.md
