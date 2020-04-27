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
* `YOURKIT_MONITOR` environment variable pointing to the installation path.
* `dialog` (if you use `mvn-profiler.sh`)

## YourKit YouMonitor

### Repository setup 

1. When you start [YouMonitor][yourkit-monitor-link] you will see the `Get Started with YouMonitor` screen:

    1. Monitor Builds in IDE or Command line
    2. Monitor builds on continuous integration server

    Since we are using the free version, we are going to be using only be monitoring builds through IDE or command line.
    Selecting it will popup a new window - choose `Command Line`

    ![][yourkit-monitor-welcome-screen]

2. You will be prompted to setup a "repository" - this is where [YouMonitor][yourkit-monitor-link] will
keep the build history. Enter a `(Project) Name` and leave the `Location` as it is. 

    !!! note
        The `Location` points to `$HOME/.youmonitor/repositories/[random-string]` by default. 
        The same pattern is used later in the [mvn-profiler] bash script.

3.  Click `Open Instructions` which will give you instructions on how to `run` a maven build with 
[YouMonitor][yourkit-monitor-link]. The instruction will ask you to create a script called `xmvn.sh` with some env vars
exported. Although this works fine, but it fast becomes annoying and error-prone. Continue to the next section for guidance on 
automating this.

### mvn-profiler

In order for [YouMonitor][yourkit-monitor-link] to record and keep track of build performance you need to export 
`LD_LIBRARY_PATH` and `MAVEN_OPTS` pointing to the correct YouMonitor repository and `LD_LIBRARY`. This quickly becomes 
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
   
   !!! warn 
       Obviously, this script works only for Linux/MacOS and won't work on Windows. 
       Pull requests are more than welcome. 
   
## Build Profiling

1. Start YouMonitor 

2. Execute
    * If you are using `mvn-profiler.sh`:
       ```
       mvn-profiler clean install
       ```
    * If you are using the `xmvn.sh` (as suggested in the instructions):
       ```
       xmvn.sh clean install
       ```

3. Monitor the build in YouMonitor.
   
    ![][yourkit-monitor-monitor-02]
    ![][yourkit-monitor-monitor-03]

   
## See also

* [YourKit YouMonitor: Help](https://www.yourkit.com/docs/youmonitor/help/)

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
