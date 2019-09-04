# Search Providers

## Introduction

Search providers offer a way to execute searches against different search engines. By default, searches are executed 
against OrientDB.

## Implemented Search Providers

### OrientDbSearchProvider

Currently [OrientDbSearchProvider] is the only one supported search provider and it uses OrientDB.

## Executing A Search Programmatically

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
                                          query);

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
* [REST-API]


[SearchProvider]: https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-api/src/main/java/org/carlspring/strongbox/providers/search/SearchProvider.java
[OrientDbSearchProvider]: https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-api/src/main/java/org/carlspring/strongbox/providers/search/OrientDbSearchProvider.java
[REST-API]: ../user-guide/rest-api.md