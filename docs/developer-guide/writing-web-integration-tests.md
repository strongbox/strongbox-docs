# Writing Web Integration Test

## Introduction

* Integration tests are mostly written to test the application end to end.
* Integration tests helps us to test basic working flows like how application will behave with consumer which in our case are tools like `pip, npm`.


## Writing Test

* Will take an example of `pypi layout provider` and `pip` as tool to explain how to write web integration tests.
* Create a new module in [strongbox-web-integration-tests](https://github.com/strongbox/strongbox-web-integration-tests) for layout provider to be tested.
* Create Base test class like [PypiWebIntegrationTest](https://github.com/strongbox/strongbox-web-integration-tests/blob/master/pypi/src/it/PypiWebIntegrationTest.groovy) having common methods which should be used by all the tests.
* For each test case a new [package](https://github.com/strongbox/strongbox-web-integration-tests/blob/master/pypi/src/it/common-flows/pip-package-upload-test) should be created so that test can be executed in isolation without affecting other tests.
* The package should have all the files and folders required by tool used for test like `setup.cfg`, `setup.py` for `pip`.
* Below are the steps which should be followed for tests:
    + Create a groovy based [test class](https://github.com/strongbox/strongbox-web-integration-tests/blob/master/pypi/src/it/common-flows/test-pypi-common-flows.groovy) for the test cases.
    + Import Base test class.
        ```java
              def baseScript = new GroovyScriptEngine("$project.basedir/src/it").with
              { 
                loadScriptByName('PypiWebIntegrationTest.groovy') 
              }
        ```
    + Determine Operation system and decide command to be run based on OS.
    + Execute the command and verify/assert the result.
        ```java
              // Assert directory exists for package uploaded
              Path packageDirectoryPath = uploadPackageDirectoryPath.resolve("dist");
              boolean pathExists =
                      Files.isDirectory(packageDirectoryPath,
                      LinkOption.NOFOLLOW_LINKS);
              
              assert pathExists == true
              
              // upload python package using pip command
              runCommand(uploadPackageDirectoryPath, packageUploadCommand)
              
              def commandOutput
              // Install uploaded python package using pip command and assert success
              def uploadedPackageName = "pip_upload_test"
              commandOutput = runCommand(uploadPackageDirectoryPath, pipInstallPackageCommand + " " + uploadedPackageName)
              assert commandOutput.contains("Successfully installed " + uploadedPackageName.replace("_" , "-") + "-1.0")
        ``` 