# Nuget and Chocolatey

This is an example of how to use the Strongbox artifact repository manager with Chocolatey using Nuget.

## Pre-requisites

Before you proceed please make sure you have installed and configured a [Strongbox Distribution](../getting-started.md).

## Example project

The "Hello, Strongbox!" example project can be found [here][hello-strongbox-nuget-chocolatey].

## Installing choco

!!! success "Windows"
    Chocolatey is available natively on Windows and can be installed following the [official documentation]

!!! warning "Mono"
    If you are running Linux/MacOS and would like to use [mono], there is no pre-built binary. 
    You will need to head to the [chocolatey repository][choco-repo] for instructions on how to build it. 
   
!!! success "Linux / MacOS / Docker"    
    We have already built a linux docker image with pre-built and configured [choco][choco] which we are also using 
    in our integration tests. It is published at [strongboxci/alpine] and you can feel free to use it for development
    purposes.

It is OK to ignore warnings about a system reboot being requested since the nothing here is affected by it.

## Configuring Choco

### Get API key

The NuGet protocol assumes that users need to be authenticated with `API Key` to be able to deploy or delete your packages.
Strongbox provides the REST API to get an API Key for specified user:

=== "Windows"
    ``` linenums="1"
    FOR /F %i IN ('curl -u admin http://localhost:48080/api/users/admin/generate-security-token') DO set API_KEY=%i
    echo %API_KEY%
    ```
=== "Linux"
    ``` linenums="1"
    API_KEY=`curl -u admin http://localhost:48080/api/users/admin/generate-security-token`
    echo $API_KEY
    ```

Enter your Strongbox password. (Default is: `admin/password`)

The output when `echo`ing the `%API_KEY%` should not be empty and should look something like this:

    eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJTdHJvbmdib3giLCJqdGkiOiJtU3N0TGVOMGpabzJNcmdleGdWSUVRIiwic3ViIjoiYWRtaW4iLCJzZWN1cml0eS10b2tlbi1rZXkiOiJhZG1pbi1zZWNyAMQifQ.SgpKb4yUidK8ATbGxDOfjGjHfEF22PIFyzlpk-Rpad0

### Save API key in choco

In this step, we will be setting the `apikey` which will be used to authenticate against the `source` in the future steps.

=== "Windows"
    ``` linenums="1"
    # This needs to be run in an administrative command prompt or powershell!
    set REPO_URL=http://localhost:48080/storages/storage-nuget/nuget-releases
    choco apikey -k %API_KEY% -s "%REPO_URL%"
    ```
=== "Linux"
    ``` linenums="1"
    REPO_URL=http://localhost:48080/storages/storage-nuget/nuget-releases
    choco apikey -k $API_KEY -s "$REPO_URL"
    ```

The output should be like follows:

```log
Chocolatey v.10.15
Added ApiKey for http://localhost:48080/storages/storage-nuget/nuget-releases
```

### Add Strongbox repository to Chocolatey package sources

To manage packages, you'll need to configure Chocolatey to access your storages by running the following command:

=== "Windows"
    ``` linenums="1"
    # This needs to be run as administrative command prompt or powershell!
    choco source add -n=strongbox -s "%REPO_URL%" --priority=1
    ``` 
=== "Linux"
    ``` linenums="1"
    choco source add -n=strongbox -s "$REPO_URL" --priority=1
    ```

The output should be like follows:

```log
Chocolatey v0.10.15
Added strongbox - http://localhost:48080/storages/storage-nuget/nuget-releases (Priority 1)
```

!!! tip "Important notes"
    * You cannot deploy to group repositories, as they are only for resolving artifacts. Also, please note that the `nuget-public` group includes the `nuget.org` repository itself
    * You can only deploy to hosted repositories. 
    * The deploy URLs would begin with `/storages/{storageId}/{repositoryId}` (i.e. `/storages/storage-nuget/nuget-releases`, `nuget-snapshot`, etc)


## How to

### Create a package

The command below will create a folder named `hello-chocolatey` with some files including a `.nuspec` and a folder 
called `tools`.

=== "Windows"
    ``` linenums="1"
    cd C:\some\path
    choco new --name=hello-chocolatey --version=1.0.0
    ``` 
=== "Linux"
    ``` linenums="1"
    cd /some/path
    choco new --name=hello-chocolatey --version=1.0.0
    ```

??? info "Example output"

    ```log
    Chocolatey <version>
    2 validations performed. 1 success(es), 0 warning(s), and 0 error(s).
    
    Creating a new package specification at C:\Users\User\Documents\hello-chocolatey
    Generating template to a file
     at 'C:\Users\User\Documents\hello-chocolatey\hello-chocolatey.nuspec'
    Generating template to a file
     at 'C:\Users\User\Documents\hello-chocolatey\tools\chocolateyinstall.ps1'
    Generating template to a file
     at 'C:\Users\User\Documents\hello-chocolatey\tools\chocolateybeforemodify.ps1'
    Generating template to a file
     at 'C:\Users\User\Documents\hello-chocolatey\tools\chocolateyuninstall.ps1'
    Generating template to a file
     at 'C:\Users\User\Documents\hello-chocolatey\tools\LICENSE.txt'
    Generating template to a file
     at 'C:\Users\User\Documents\hello-chocolatey\tools\VERIFICATION.txt'
    Generating template to a file
     at 'C:\Users\User\Documents\hello-chocolatey\ReadMe.md'
    Generating template to a file
     at 'C:\Users\User\Documents\hello-chocolatey\_TODO.txt'
    Successfully generated hello-chocolatey package specification files
     at 'C:\Users\User\Documents\hello-chocolatey'
    ```

#### Additional instructions

* Delete `_TODO.txt` and `ReadMe.md` in the `hello-chocolatey` directory.
* Delete `chocolateybeforemodify.ps1` and `chocolateyuninstall.ps1` in the tools sub-directory. 
  The `LICENSE.txt` and `VERIFICATION.txt` can also be deleted, although this is not required.
* Edit `chocolateyinstall.ps1` in the `tools` sub-directory with a text editor and replace the entire content with `Write-Output 'Package would install here'`. 
* If you are running on a Linux file system, edit `hello-chocolatey.nuspec` and replace `"tools\**"` with `"tools/**"`(backwards to forwards slash) in the `file` section. It should be the forth row from the bottom.
* You can also check against the [example files] located in the [strongbox-examples] repository.

### Make Chocolatey NuGet package

Execute the following command in the same directory as `hello-chocolatey.nuspec`:

=== "Windows"
    ``` linenums="1"
    cd C:\some\path\hello-chocolatey
    choco pack
    ``` 
=== "Linux"
    ``` linenums="1"
    cd /some/path/to/hello-chocolatey
    choco pack
    ```

??? info "Example output"

    ```log
    Chocolatey <version>
    2 validations performed. 1 success(es), 0 warning(s), and 0 error(s).
    
    Attempting to build package from 'hello-chocolatey.nuspec'.
    Successfully created package 'C:\Users\User\Documents\hello-chocolatey\hello-chocolatey.1.0.0.nupkg'
    ```

### Push NuGet package into Strongbox repository

Execute the following command in the directory with `hello-chocolatey.1.0.0.nupkg`:

=== "Windows"
    ``` linenums="1"
    cd C:\some\path\hello-chocolatey
    choco push --source "%REPO_URL%" --force
    ``` 

=== "Linux"
    ``` linenums="1"
    cd /some/path/to/hello-chocolatey
    choco push --source "$REPO_URL" --force
    ```

??? info "Example output"

    ```log
    Chocolatey <version>
    2 validations performed. 1 success(es), 0 warning(s), and 0 error(s).
    
    Attempting to push hello-chocolatey.1.0.0.nupkg to http://localhost:48080/storages/storage-nuget/nuget-releases
    hello-chocolatey 1.0.0 was pushed successfully to http://localhost:48080/storages/storage-nuget/nuget-releases
    ```

### Search for packages in Strongbox repositories

Execute the following command:

=== "Windows"
    ``` linenums="1"
    choco search -s "%REPO_URL%"
    ``` 
=== "Linux"
    ``` linenums="1"
    choco search -s "$REPO_URL"
    ```

??? info "Example output"

    ```log
    Chocolatey <version>
    2 validations performed. 1 success(es), 0 warning(s), and 0 error(s).
    
    hello-chocolatey 1.0.0
    1 packages found.
    ```

### Delete a Chocolatey package from strongbox

Chocolatey does not have a built in way to delete packages from the server. 
As a workaround, you can use `nuget` to delete packages, see [hello-strongbox-nuget-visual-studio] for more details.

### Install a package

To install a `choco` package you should use the command below. 

=== "Windows"
    ``` linenums="1"
    # Execute the following command as a administrator!
    choco install hello-chocolatey -s "%REPO_URL%"
    ```
=== "Linux"
    ``` linenums="1"
    choco install hello-chocolatey -s "$REPO_URL"
    ```

!!! tip "Tip"
    Adding `-s "{repo_url}"` is optional. However, `choco` will loop through all sources until it finds the package which
    might be time consuming so you might want to force `choco` using the right source.


??? info "Example output"

    ```log
    Chocolatey <version>
    2 validations performed. 1 success(es), 0 warning(s), and 0 error(s).
    
    Installing the following packages:
    hello-chocolatey.1.0.0.nupkg
    By installing you accept licenses for the packages.
    
    hello-chocolatey v1.0.0
    hello-chocolatey package files install completed. Performing other installation steps.
    Package would install here
     The install of hello-chocolatey was successful.
      Software install location not explicitly set, could be in package or
      default install location if installer.
    
    Chocolatey installed 1/1 packages.
     See the log for details (C:\ProgramData\chocolatey\logs\chocolatey.log).
    ```

### Uninstall a package

=== "Windows"
    ``` linenums="1"
    # Execute the following command as a administrator!
    choco uninstall hello-chocolatey
    ```
=== "Linux"
    ``` linenums="1"
    choco uninstall hello-chocolatey
    ```

??? info "Example output"

    ```log
    Chocolatey <version>
    2 validations performed. 1 success(es), 0 warning(s), and 0 error(s).
    
    Uninstalling the following packages:
    hello-chocolatey
    
    hello-chocolatey v1.0.0
     Skipping auto uninstaller - No registry snapshot.
     hello-chocolatey has been successfully uninstalled.
    
    Chocolatey uninstalled 1/1 packages.
     See the log for details (C:\ProgramData\chocolatey\logs\chocolatey.log).
    ```

## See also

* [Chocolatey commands reference][choco-reference]
* [Chocolatey docs][choco-docs]
* [hello-strongbox-nuget-chocolatey]

[choco]: https://chocolatey.org/
[choco-reference]: https://chocolatey.org/docs/commands-reference
[choco-docs]: https://chocolatey.org/docs
[choco-repo]: https://github.com/chocolatey/choco
[example files]: https://github.com/strongbox/strongbox-examples/tree/master/hello-strongbox-nuget-chocolatey
[mono]: https://www.mono-project.com/
[official documentation]: https://chocolatey.org/install
[strongboxci/alpine]: https://hub.docker.com/r/strongboxci/alpine/tags?page=1&name=choco
[strongbox-examples]: https://github.com/strongbox/strongbox-examples
[hello-strongbox-nuget-chocolatey]: https://github.com/strongbox/strongbox-examples/tree/master/hello-strongbox-nuget-chocolatey
[hello-strongbox-nuget-visual-studio]: https://github.com/strongbox/strongbox-examples/tree/master/hello-strongbox-nuget-visual-studio
