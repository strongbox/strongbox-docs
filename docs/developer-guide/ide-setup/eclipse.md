# Eclipse

!!! tip "Before continuing, please make sure you've built the code using [Building / Building the code / Building strongbox] section."

## Choose eclipse distribution
The `Eclipse IDE for Java Developers` package is a sufficient base for strongbox project development.

## Install ANTLR4 IDE plugin
Follow ANTLR4 Eclipse plugin installation guide `Prerequisites` and `Installation` sections from [here][ANTLR4 Eclipse plugin]

* Download and add as default distribution the `antlr-4.x-complete.jar` version which matches `version.antlr` variable from [here][parent pom] in Window -> Preferences -> ANTLR 4 -> Tool
![Window -> Preferences -> ANTLR 4 -> Tool | Add | Apply and Close][ANTLR 4 tool]

## Install Groovy-Eclipse M2E Integration 
Install from your eclpise distro update site [here][Groovy-Eclipse M2E]. Necessary dependencies will be automatically selected.

## Set up eclipse workspace

### Create empty workspace
You should create an empty workspace - this is the default behavior when you first start eclipse. Just make sure you untick the "Always show Welcome at start up" checkbox before closing the welcome screen to see the usual perspective on startup.
![Welcome X | V Always show Welcome at start up][Hide Welcome]

### Import Maven project
* Choose `File -> Import -> Maven -> Existing Maven Projects`
* Point the `Root Directory` to the strongbox cloned repository.
* Click `Finish` button.
![Import -> Existing Maven Project -> Finish][Import Maven Project]

### Workaround m2e connectors
If a popup `Discover m2e connectors` appears - click `Resolve All Later` and `Finish`. Issues with m2e connectors are known and we workaround this through maven command line build:

![Discover m2e connectors | Resolve All Later | Finish][Discover m2e connectors]
    
* In `Window -> Preferences -> Maven -> Errors/Warnings -> Plugin execution not covered by lifecycle configuration` choose `Ignore` and hit `Apply`
* Click Import icon and browse `From preference file` to a local saved copy of [this file][Ignore m2e mapping errors epf]

    ![Window -> Preferences -> Maven -> Errors/Warnings -> Plugin execution not covered by lifecycle configuration -> Ignore | Apply | Import -> From preference file -> Finish -> Restart][Ignore m2e mapping errors]

### Configure `strongbox-storage-nuget-layout-provider` project
* Expand the `src/main` directory and select `antlr4` folder, then right click and pick `Build path -> Use as Source Folder`

    ![strongbox-storage-nuget-layout-provider/src/main/antlr4 -> Build Path -> Use as Source Folder][Nuget ANTLR Build Path]

### Configure `strongbox-aql` project
* Expand the `src/main` directory and select `groovy` and `twig` folders, then right click and pick `Build path -> Use as Source Folder`
    ![strongbox-aql/src/main/groovy & twig ->  Build Path -> Use as Source Folder][AQL groovy and twig Build Path]

* Right click the project and pick Properties 
    * `Java Build Path -> Libraries -> Add Library -> Groovy Runtime Libraries`. Note that if on right click you pick directly Build path adding the groovy libraries gives an error
        ![strongbox-aql -> Properties -> Java Build Path -> Add Library -> Groovy Runtime Libraries][AQL groovy project nature]
    * `Project Natures -> Add -> Groovy Nature`
        ![strongbox-aql -> Properties -> Project Natures -> Add -> Confirm Project Nature update -> Groovy Nature][AQL groovy libraries in Build Path]
* Build the project through command line `mvn clean install` (append `-DskipTests` optionally if tests are not necessary at this point)
* Select all eclipse projects, Right click -> Refresh 
* Select `strongbox-masterbuild` project, Right click -> Maven -> Update Project
    ![strongbox-masterbuild -> Maven -> Update Project][masterbuild maven update]

[Building / Building the code / Building strongbox]: ../developer-guide/building-the-code.html#building-strongbox
[Hide Welcome]: {{assets}}/screenshots/09-eclipse-hide-welcome.png "Hide Welcome"
[Import Maven Project]: {{assets}}/screenshots/10-eclipse-import-maven-project.png "Import Maven Project"
[Discover m2e connectors]: {{assets}}/screenshots/11-eclipse-discover-m2e-connectors.png "Discover m2e connectors"
[Ignore m2e mapping errors epf]: {{resources}}/ide/eclipse/eclipse-ignore-m2e-connector-errors.epf
[Ignore m2e mapping errors]: {{assets}}/screenshots/12-eclipse-ignore-m2e-mapping-errors.png "Ignore m2e lifecycle errors"
[ANTLR4 Eclipse plugin]: https://github.com/antlr4ide/antlr4ide#eclipse-installation
[parent pom]: https://github.com/strongbox/strongbox-parent/blob/master/pom.xml
[Groovy-Eclipse M2E]: https://github.com/groovy/groovy-eclipse/wiki#releases
[ANTLR 4 tool]: {{assets}}/screenshots/13-eclipse-antlr-tool.png "ANTLR 4 tool"
[Nuget ANTLR Build Path]: {{assets}}/screenshots/14-eclipse-nuget-antlr-to-build-path.png "Nuget ANTLR Build Path"
[AQL groovy and twig Build Path]: {{assets}}/screenshots/15-eclipse-aql-groovy-twig-to-build-path.png "AQL groovy and twig Build Path"
[AQL groovy libraries in Build Path]: {{assets}}/screenshots/16-eclipse-aql-groovy-libraries.png "AQL groovy libraries in Build Path"
[AQL groovy project nature]: {{assets}}/screenshots/17-eclipse-aql-groovy-nature.png "AQL groovy project nature"
[masterbuild maven update]: {{assets}}/screenshots/18-eclipse-masterbuild-maven-update.png "masterbuild maven update"