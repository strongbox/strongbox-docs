# Artifact Coordinate Validators

## Introduction 

Artifact coordinate validators provide a way to verify that coordinate values match certain rules during deployment. 
These can be configured in the `strongbox.xml` file. Each layout provider has a set of default artifact coordinate 
validators that it uses, if non are specified.

## Generic Artifact Coordinate Validators

### GenericReleaseVersionValidator

This is a generic validator that checks, if the artifact being deployed is using a release version and whether the target repository is also one with a release policy.

<div class="no-table-header" markdown="1">
| | |
| --- | --- | 
| Configuration Key | generic-release-version-validator | 
| Class | org.carlspring.strongbox.storage.validation.artifact.version.GenericReleaseVersionValidator |
| Enabled by default | false | 
</div>

### Generic Snapshot Version Validator

This is a generic validator that checks, if the artifact being deployed is using a snapshot version and whether the target repository is also one with a snapshot policy.

<div class="no-table-header" markdown="1">
| | |
| --- | --- |
| Configuration Key | generic-snapshot-version-validator | 
| Class | org.carlspring.strongbox.storage.validation.artifact.version.GenericSnapshotVersionValidator |
| Enabled by default | false | 
</div>

### Re-deployment Validator

This validator checks if the repository allows the re-deployment of artifacts.

<div class="no-table-header" markdown="1">
| | |
| --- | --- |
| Configuration Key | redeployment-validator | 
| Class | org.carlspring.strongbox.storage.validation.deployment.RedeploymentValidator |
| Enabled by default | true | 
</div>

## Configuration

TODO: 

## Default Artifact Version Coordinate Validators

TODO: 
