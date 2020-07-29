# YourKit Java Profiler

## Intro

Having a fast running application requires a lot of efforts to find the cause of memory leaks, high CPU 
usage and do overall application profiling. We would like to thank [YourKit][yourkit-link] for sponsoring us and 
making our lives much easier! 

[![][yourkit-logo]][yourkit-link]

[YourKit][yourkit-link] supports open source projects with innovative and intelligent tools for monitoring and 
profiling Java and .NET applications. YourKit is the creator of [YourKit Java Profiler][yourkit-profiler-link], 
[YourKit .NET Profiler][yourkit-dotnet-profiler-link] and [YourKit YouMonitor][yourkit-monitor-link].

 
## Pre-requisites

* JDK 8
* [Running Strongbox instance](../building-strongbox-using-strongbox-instance.md)
* [YourKit Java Profiler][yourkit-profiler-link]
* `YOURKIT_PROFILER` environment variable pointing to the installation path.
* `YOURKIT_PROFILER_AGENT` environment variable pointing to the correct agent

## YourKit Java Profiler

There are a two ways to start profiling:

1. By automatically attaching profiler with an agent (preferred)
2. By manually attaching the profiler to a running JVM ([limitations][yourkit-profiler-manual-attach-limits])

### Agents

All possible OS agents can be found at [YourKit Java Profiler Help page][yourkit-profiler-agnets].

OS      | Platform         | Agent
------- | ---------------- | -----
Linux   | x86, 64-bit Java | `-agentpath:$YOURKIT_PROFILER/bin/linux-x86-64/libyjpagent.so`
macOS   | n/a              | `-agentpath:$YOURKIT_PROFILER/bin/mac/libyjpagent.dylib`
Windows | x86, 64-bit Java | `-agentpath:%YOURKIT_PROFILER%\bin\win64\yjpagent.dll`

### Start profiling

1. Start [YourKit Java Profiler][yourkit-profiler-link]
1. Set an environment variable with the agent corresponding to your OS:
   
    === "Linux"
        ```
        YOURKIT_PROFILER_AGENT=-agentpath:$YOURKIT_PROFILER/bin/linux-x86-64/libyjpagent.so
        ```
    === "MacOS"
        ```
        YOURKIT_PROFILER_AGENT=-agentpath:$YOURKIT_PROFILER/bin/mac/libyjpagent.dylib
        ```
    === "Windows"
        ```
        set YOURKIT_PROFILER_AGENT=-agentpath:%YOURKIT_PROFILER%\bin\win64\yjpagent.dll
        ```

2. Start a Strongbox instance

    === "Linux/Mac"
        ```
        For spring-boot:run:
          JAVA_TOOL_OPTIONS=$YOURKIT_PROFILER_AGENT mvn spring-boot:run
        
        For strongbox-distribution:
          JAVA_TOOL_OPTIONS=$YOURKIT_PROFILER_AGENT ./bin/strongbox start
        ```
            
    === "Windows"
        ```
        For spring-boot:run:
          set JAVA_TOOL_OPTIONS=%YOURKIT_PROFILER_AGENT% 
          mvn spring-boot:run
        
        For strongbox-distribution:
          set JAVA_TOOL_OPTIONS=%YOURKIT_PROFILER_AGENT% 
          ./bin/strongbox start
        ```
    
3. Select `StrongboxSpringBootApplication` in the profiler 

## See also

* [YourKit Java Profiler: Help](https://www.yourkit.com/docs/java/help/)
* [YourKit Java Profiler: Local Profiling](https://www.yourkit.com/docs/java/help/local_profiling.jsp)
* [YourKit Java Profiler: Enabling profiling manually](https://www.yourkit.com/docs/java/help/agent.jsp)


[yourkit-logo]: https://www.yourkit.com/images/yk_logo.png
[yourkit-link]: https://www.yourkit.com
[yourkit-profiler-link]: https://www.yourkit.com/java/profiler
[yourkit-dotnet-profiler-link]: https://www.yourkit.com/.net/profiler
[yourkit-monitor-link]: https://www.yourkit.com/youmonitor/
[yourkit-profiler-manual-attach-limits]: https://www.yourkit.com/docs/java/help/attach_agent.jsp#limitations
[yourkit-profiler-agnets]: https://www.yourkit.com/docs/java/help/agent.jsp
