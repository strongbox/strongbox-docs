# General

* All code must be accompanied with sufficiently thorough test cases which validate the functionality.
* Test cases should be self-sufficient and not rely on data produced by other tests, or the outcome of other tests in any other way.
* If tests are failing, they are a top priority.
* Pull requests shall not be merged, if there are failing tests.
* If working on the REST API, the respective REST client should be used. For any new functionality, there will have to be respective methods in the [RestClient](https://github.com/strongbox/strongbox/blob/master/strongbox-rest-client/src/main/java/org/carlspring/strongbox/client/RestClient.java) (or related client).

# Artifact-related Tests

For artifact-related test, you would normally want to extend the [TestCaseWithArtifactGeneration](https://github.com/strongbox/strongbox/blob/master/strongbox-testing/strongbox-testing-core/src/main/java/org/carlspring/strongbox/testing/TestCaseWithArtifactGeneration.java) class, as it contains most of the required functionality; (any missing such methods which could be re-used, should 

## Generating Artifacts

To generate an artifact, you can use the following code:

    generateArtifact(REPOSITORY_BASEDIR_RELEASES.getAbsolutePath(),
                     "org.carlspring.strongbox.resolve.only:foo",
                     new String[]{ "1.1" }); // Used by testResolveViaProxy()

If you're generating this from your test's `setUp` method, please, make sure that:
* The artifact generation part is only invoked once
* For each artifact you add a comment explaining which test method is using this resource

## Deploying Artifacts

The following is an example of artifact deployment taken from the [ArtifactDeployerTest](https://github.com/strongbox/strongbox/blob/master/strongbox-testing/strongbox-testing-core/src/test/java/org/carlspring/strongbox/artifact/generator/ArtifactDeployerTest.java):


    private static ArtifactClient client;
    
    
    @Before
    public void setUp()
            throws Exception
    {
        if (!BASEDIR.exists())
        {
            //noinspection ResultOfMethodCallIgnored
            BASEDIR.mkdirs();

            client = new ArtifactClient();
            client.setUsername("maven");
            client.setPassword("password");
            client.setPort(assignedPorts.getPort("port.jetty.listen"));
            client.setContextBaseUrl("http://localhost:" + client.getPort());
        }
    }

    @Test
    public void testArtifactDeployment()
            throws ArtifactOperationException,
                   IOException,
                   NoSuchAlgorithmException,
                   XmlPullParserException
    {
        Artifact artifact = ArtifactUtils.getArtifactFromGAVTC("org.carlspring.strongbox:test:1.2.3");

        String[] classifiers = new String[] { "javadocs", "jdk14", "tests"};

        ArtifactDeployer artifactDeployer = new ArtifactDeployer(BASEDIR);
        artifactDeployer.setClient(client);
        artifactDeployer.generateAndDeployArtifact(artifact, classifiers, "storage0", "releases", "jar");
    }


## Adding Artifacts To The Index

For test cases where you need to generate artifacts and add them to the index, please have a look at the [TestCaseWithArtifactGenerationWithIndexing](https://github.com/strongbox/strongbox/blob/master/strongbox-storage/strongbox-storage-indexing/src/test/java/org/carlspring/strongbox/testing/TestCaseWithArtifactGenerationWithIndexing.java) class.

Please, note that the above class is not currently something you can extend outside the scope of the `strongbox-storage-indexing` module.

# Testing REST calls

## Testing REST Calls For Artifacts

For artifact-related REST calls you should use the [ArtifactClient](https://github.com/strongbox/strongbox/blob/master/strongbox-client/src/main/java/org/carlspring/strongbox/client/ArtifactClient.java) class.

## Testing General REST Calls

For general purpose REST calls you should use the [RestClient](https://github.com/strongbox/strongbox/blob/master/strongbox-rest-client/src/main/java/org/carlspring/strongbox/client/RestClient.java) class.

For example:

    private static ArtifactClient client;
    
    
    @Before
    public void setUp()
            throws Exception
    {
        if (!BASEDIR.exists())
        {
            //noinspection ResultOfMethodCallIgnored
            BASEDIR.mkdirs();

            client = new ArtifactClient();
            client.setUsername("maven");
            client.setPassword("password");
            client.setPort(assignedPorts.getPort("port.jetty.listen"));
            client.setContextBaseUrl("http://localhost:" + client.getPort());
        }
    }

    @Test
    public void testDeleteArtifactAndEmptyTrashForRepository()
            throws Exception
    {
        client.deleteTrash(STORAGE, REPOSITORY_WITH_TRASH);

        assertFalse("Failed to empty trash for repository '" + REPOSITORY_WITH_TRASH + "'!", ARTIFACT_FILE_IN_TRASH.exists());
    }

# Dealing With Ports

For test cases which rely on ports that are dynamically assigned by Maven (this is related to testing such code via Jenkins builds), you can use the [AssignedPorts](https://github.com/strongbox/strongbox/blob/master/strongbox-testing/strongbox-testing-core/src/main/java/org/carlspring/strongbox/testing/AssignedPorts.java).

    @Autowired
    private AssignedPorts assignedPorts;
    
    private int jettyPort assignedPorts.getPort("port.jetty.listen");
