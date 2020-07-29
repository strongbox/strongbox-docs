# YourKit YouMonitor

## Intro

Having a fast running application requires a lot of efforts to find the cause of memory leaks, high CPU 
usage and do overall application profiling. In addition to [YourKit Java Profiler][yourkit-profiler-link] we are also
using [YourKit YouMonitor][yourkit-monitor-link] to keep our build times as fast as possible and pin-point slow tests.

[![][yourkit-logo]][yourkit-link]

[YourKit][yourkit-link] supports open source projects with innovative and intelligent tools for monitoring and 
profiling Java and .NET applications. YourKit is the creator of [YourKit Java Profiler][yourkit-profiler-link], 
[YourKit .NET Profiler][yourkit-dotnet-profiler-link] and [YourKit YouMonitor][yourkit-monitor-link].

## Pre-requisites

* JDK 8
* [Running Strongbox instance](../building-strongbox-using-strongbox-instance.md)
* `YOUMONITOR_HOME` environment variable pointing to the installation path.
* `YOUMONITOR_REPOSITORIES` environment variable pointing to a YouMonitor repositories path 
* `dialog` and `jq` (if you use `mvn-profiler.sh`)

    !!! warning
        The guide shows the setup process for Linux/Mac. 
        Most of us are not using Windows which is why this guide might lack some instructions specific to Windows.
        Feel free to open up PRs and help us improve the docs. 

## YourKit YouMonitor

### Installation

Download [YouMonitor][yourkit-monitor-link] and then:

=== "Linux"
    ``` linenums="1"
    unzip YourKit-YouMonitor-*.zip
    
    (Optional) Add environment variables to `.bashrc`, `/etc/profile`
    or set them in the mvn-profiler.sh script:

        YOUMONITOR_HOME=\$HOME/.youmonitor
        YOUMONITOR_REPOSITORIES=\$YOUMONITOR_HOME/repositories
    ```

=== "MacOS"
    ``` linenums="1"
    Install the .dmg into Applications.
     
    (Optional) Add environment variables to `.bashrc`, `/etc/profile`
    or set them in the mvn-profiler.sh script:

        YOUMONITOR_HOME=\$HOME/.youmonitor
        YOUMONITOR_REPOSITORIES=\$YOUMONITOR_HOME/repositories
    ```
    
=== "Windows"

    ``` linenums="1"
    Install the `.exe`
    ```

### Repository setup 

1. When you start [YouMonitor][yourkit-monitor-link] the `Get Started with YouMonitor` screen will have the following options:

    1. Monitor Builds in IDE or Command line
    2. Monitor builds on continuous integration server

2. Since we are using the free version, we can only be using `Monitor builds through IDE or command line`.
3. Select `Command Line`

    ![][yourkit-monitor-welcome-screen]

4. You will be prompted to setup a "repository" - this is where [YouMonitor][yourkit-monitor-link] will
keep the build history. Enter a `(Project) Name` and leave the `Location` as it is. 

    !!! note
        The `Location` points to `$HOME/.youmonitor/repositories/[random-string]` by default. 
        The same pattern is used later in the [mvn-profiler] bash script.

5.  Click `Open Instructions` which will give you further instructions on how to `run` a maven build with 
[YouMonitor][yourkit-monitor-link]. The instructions will ask you to create a script called `xmvn.sh` with some env vars
exported. Although this works fine, it becomes annoying and error-prone when you have to switch between multiple projects. 
Continue to the next section for guidance on automating this.

### mvn-profiler

In order for [YouMonitor][yourkit-monitor-link] to record and keep track of build performance you need to export 
`LD_LIBRARY_PATH` and `MAVEN_OPTS` pointing to the correct YouMonitor `repository` and `LD_LIBRARY`. This quickly becomes 
annoying and error-prone when you need to switch between multiple project within Strongbox. 

In an attempt to ease this pain, we have created a [mvn-profiler] bash script which does this automatically and allows
you to select existing YouMonitor repositories from `$HOME/.youmonitor/repositories` before starting the maven build.
To install:

1. Download `mvn-profiler.sh`

    ```
    curl -o mvn-profiler \
           {{resources}}/yourkit/mvn-profiler.sh
    ```

2. Install into `/usr/local/bin`
    ```
    sudo mv mvn-profiler /usr/local/bin/mvn-profiler
    ```
   
    !!! warning 
        Obviously, this script only works for Linux/MacOS and won't work on Windows. 
        Pull requests are more than welcome. 

## Build Profiling

1. Start YouMonitor 

2. Execute
    * If you are using `mvn-profiler.sh`:
       ```
       mvn-profiler clean install
       ```
    * If you are using the `xmvn.sh` or `xmvn.bat` (as suggested in the instructions):
       ```
       xmvn.sh clean install
       ```

3. Monitor the build in YouMonitor.
   
    ![][yourkit-monitor-monitor-02]
    ![][yourkit-monitor-monitor-03]
   
## See also

* [YourKit YouMonitor: Help](https://www.yourkit.com/docs/youmonitor/help/)
* [YourKit YouMonitor: Build Insights](https://www.yourkit.com/docs/youmonitor/help/build_insights.jsp)
* [YourKit YouMonitor: JUnit](https://www.yourkit.com/docs/youmonitor/help/junit.jsp)
* [YourKit YouMonitor: Maven](https://www.yourkit.com/docs/youmonitor/help/maven.jsp)
* [YourKit YouMonitor: Event details](https://www.yourkit.com/docs/youmonitor/help/event_details.jsp)

[yourkit-logo]: https://www.yourkit.com/images/yk_logo.png
[yourkit-link]: https://www.yourkit.com
[yourkit-profiler-link]: https://www.yourkit.com/java/profiler
[yourkit-dotnet-profiler-link]: https://www.yourkit.com/.net/profiler
[yourkit-monitor-link]: https://www.yourkit.com/youmonitor/
[yourkit-monitor-welcome-screen]: ../../assets/screenshots/yourkit/01.png
[yourkit-monitor-monitor-02]: ../../assets/screenshots/yourkit/02.png
[yourkit-monitor-monitor-03]: ../../assets/screenshots/yourkit/03.png
[mvn-profiler]: #mvn-profiler
[mvn-profiler-link]: {{resources}}/yourkit/mvn-profiler.sh
