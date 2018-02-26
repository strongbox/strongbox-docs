Artifact coordinate validators provide a way to verify that coordinate values match certain rules during deployment. These can be configured in the `strongbox.xml` file. Each layout provider has a set of default artifact coordinate validators that it uses, if non are specified.

# Available Artifact Coordinate Validators

## Generic

### GenericReleaseVersionValidator

This is a generic validator that checks, if the artifact being deployed is using a release version and whether the target repository is also one with a release policy.

<table>
  <tr>
    <td>Configuration Key</td>
    <td>generic-release-version-validator</td>
  </tr>
  <tr>
    <td>Class</td>
    <td>org.carlspring.strongbox.storage.validation.artifact.version.GenericReleaseVersionValidator</td>
  </tr>
  <tr>
    <td>Enabled by default</td>
    <td>No</td>
  </tr>
</table>

### Generic Snapshot Version Validator

This is a generic validator that checks, if the artifact being deployed is using a snapshot version and whether the target repository is also one with a snapshot policy.

<table>
  <tr>
    <td>Configuration Key</td>
    <td>generic-snapshot-version-validator</td>
  </tr>
  <tr>
    <td>Class</td>
    <td>org.carlspring.strongbox.storage.validation.artifact.version.GenericSnapshotVersionValidator</td>
  </tr>
  <tr>
    <td>Enabled by default</td>
    <td>No</td>
  </tr>
</table>

### Re-deployment Validator

This validator checks if the repository allows the re-deployment of artifacts.

<table>
  <tr>
    <td>Configuration Key</td>
    <td>redeployment-validator</td>
  </tr>
  <tr>
    <td>Class</td>
    <td>org.carlspring.strongbox.storage.validation.deployment.RedeploymentValidator</td>
  </tr>
  <tr>
    <td>Enabled by default</td>
    <td>Yes</td>
  </tr>
</table>

## Maven

The following are a list of Maven-specific artifact coordinate validators.

### Maven Release Version Validator

This validator checks if the repository accepts release versions and whether the artifact version is a release. 

<table>
  <tr>
    <td>Configuration Key</td>
    <td>maven-release-version-validator</td>
  </tr>
  <tr>
    <td>Class</td>
    <td>org.carlspring.strongbox.storage.validation.version.MavenReleaseVersionValidator</td>
  </tr>
  <tr>
    <td>Enabled by default</td>
    <td>Yes</td>
  </tr>
</table>

### Maven Snapshot Version Validator

This validator checks if the repository accepts snapshot versions and whether the artifact version is a snapshot. 

<table>
  <tr>
    <td>Configuration Key</td>
    <td>maven-snapshot-version-validator</td>
  </tr>
  <tr>
    <td>Class</td>
    <td>org.carlspring.strongbox.storage.validation.version.MavenSnapshotVersionValidator</td>
  </tr>
  <tr>
    <td>Enabled by default</td>
    <td>Yes</td>
  </tr>
</table>

### Maven Group Id Lowercase Validator

This validator checks, if the `groupId` of the Maven artifact is lowercase.

<table>
  <tr>
    <td>Configuration Key</td>
    <td>maven-groupid-lowercase-validator</td>
  </tr>
  <tr>
    <td>Class</td>
    <td>org.carlspring.strongbox.storage.validation.groupid.MavenGroupIdLowercaseValidator</td>
  </tr>
  <tr>
    <td>Enabled by default</td>
    <td>No</td>
  </tr>
</table>

### Maven Artifact Id Lowercase Validator

This validator checks, if the `groupId` of the Maven artifact is lowercase.

<table>
  <tr>
    <td>Configuration Key</td>
    <td>maven-artifactid-lowercase-validator</td>
  </tr>
  <tr>
    <td>Class</td>
    <td>org.carlspring.strongbox.storage.validation.artifactid.MavenArtifactIdLowercaseValidator</td>
  </tr>
  <tr>
    <td>Enabled by default</td>
    <td>No</td>
  </tr>
</table>

## Semantic Versioning Validator

This coordinate validator enforces semantic versioning.

<table>
  <tr>
    <td>Configuration Key</td>
    <td>semantic-version-validator</td>
  </tr>
  <tr>
    <td>Class</td>
    <td>org.carlspring.strongbox.storage.validation.artifact.version.SemanticVersioningValidator</td>
  </tr>
  <tr>
    <td>Enabled by default</td>
    <td>No</td>
  </tr>
</table>

# Configuration

# Default Artifact Version Coordinate Validators

