# Maven Artifact Coordinate Validators

The following are a list of Maven-specific artifact coordinate validators.

## Maven Release Version Validator

This validator checks if the repository accepts release versions and whether the artifact version is a release. 

<div class="no-table-header" markdown="1">
| | |
| --- | --- | 
| Configuration Key | maven-release-version-validator | 
| Class | org.carlspring.strongbox.storage.validation.version.MavenReleaseVersionValidator |
| Enabled by default | true | 
</div>

## Maven Snapshot Version Validator

This validator checks if the repository accepts snapshot versions and whether the artifact version is a snapshot. 

<div class="no-table-header" markdown="1">
| | |
| --- | --- | 
| Configuration Key | maven-snapshot-version-validator | 
| Class | org.carlspring.strongbox.storage.validation.version.MavenSnapshotVersionValidator |
| Enabled by default | true | 
</div>

## Maven `groupId` Lowercase Validator

This validator checks, if the `groupId` of the Maven artifact is lowercase.

<div class="no-table-header" markdown="1">
| | |
| --- | --- | 
| Configuration Key | maven-groupid-lowercase-validator | 
| Class | org.carlspring.strongbox.storage.validation.groupid.MavenGroupIdLowercaseValidator |
| Enabled by default | false | 
</div>

## Maven `artifactId` Lowercase Validator

This validator checks, if the `groupId` of the Maven artifact is lowercase.

<div class="no-table-header" markdown="1">
| | |
| --- | --- | 
| Configuration Key | maven-artifactid-lowercase-validator | 
| Class | org.carlspring.strongbox.storage.validation.artifactid.MavenArtifactIdLowercaseValidator |
| Enabled by default | false | 
</div>

## Semantic Versioning Validator

This coordinate validator enforces semantic versioning.

<div class="no-table-header" markdown="1">
| | |
| --- | --- | 
| Configuration Key | semantic-version-validator | 
| Class | org.carlspring.strongbox.storage.validation.artifact.version.SemanticVersioningValidator |
| Enabled by default | false | 
</div>
