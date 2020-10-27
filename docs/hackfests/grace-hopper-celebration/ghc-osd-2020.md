# Grace Hopper Celebration Open Source Day (2020)

## About The Event

The Grace Hopper Celebration: Opensource Day (2020) will be a one-day virtual event taking place on the 1st of October.

For more details, check [here][anitab-ghc-oss-day-details].

### Pre-requisites

As a first step, please, make sure you have had a proper read through our page on [Hackfests], as it provides all the
information you will need.

## Plan

* We will host a 30 minute presentation of the project starting at 9:55 a.m. PT over Zoom.
* We will keep the Zoom conference line open between 9:55-18:00 PT.
* We will not use the Zoom chat for chatting, and will use the [chat][anitab-ghc-chat] for this, as this will
  preserve the history.
  
For more details, check [here][anitab-ghc-oss-day-details].

## Chat

Please, note that the [chat][anitab-ghc-chat] (on Slack) for the Grace Hopper Celebration Opensource Day will be hosted on
AnitaB.org's infrastructure and this will not be the same as our own [chat channel][chat]. You will need to be a
registered participant of the event in order to join this chat.

Please, note that the Slack chat channel will remain open for about 2 weeks after the event and will then be suspended.

## Help

To help you stay on course, our partners at the Grace Hopper event have elected the following mentors that should be
able to answer your basic technical needs:

* Prachi Sharma 
* Priyanka Tiwari  
* Sreeja Das
* Vaishnavi Mukundhan

In addition to this we will have two of our founding members (marked as representatives):

* Martin Todorov (`carlspring`)
* Steve Todorov (`steve-todorov`)

You can also take advice from our many contributors on our official channel. Here are some of them:

* Pablo Tirado (`ptirado`)
* Anki Tomar (`ankit`)

## Presentation

We will give a brief presentation on:

* What Open Source is
* What Strongbox, what we have implemented so far and what we could use your help with

You can find the presentation of the event [here][presentation-file].

## Topics

This section outlines the areas that we could you help with. Please, pick one that interests you, or one that you're
experienced in.

### Dependency Upgrades

We need to upgrade the dependencies in our `master` branch. A lot of these have become outdated due to our focus on the
work for our [#1649: Migrate Strongbox From OrientDB to JanusGraph][issue-1649] task (done on the `issues/1659` branch).

The upgrades are done via the [strongbox-parent] project and are tested via the [strongbox] project. You will need to
follow the steps outlines in the [Upgrading Dependencies][upgrading-dependencies] guide.

A list of these tasks can be found [here][list-of-dependency-upgrades].

### Build plugins upgrade

Plugins should be generally safer to upgrade, but there can sometimes be surprises, so please, check the section above
for the Dependency Upgrades tasks. 

A list of these tasks can be found [here][list-of-dependency-upgrades]. Look for ones with "plugin" in the title.

### Integration tests tool upgrade 

For our [strongbox-web-integration-tests] we have built our [own Docker images][ci-build-images] and we need help
with upgrading some of the tools we use in these images. Obviously, the upgrade will involve making sure that things
are still working. 

### Testing out our layout provider support with different versions of the tools under different operating systems 

We have currently implemented layout providers support for the Maven, NPM, Nuget and Raw and need more people
to test these in different environments with the respective tools for them and to provide us feedback. Please, feel free
to raise issues in our issue tracker, if you find and bugs. 

### Stabilizing and testing the issues/1649 branch 

We need more people to test out our work on the `issues/1649` branch and report any bugs that might be discovered.
We'd also like to get some help with the sub-tasks of [#1649: Migrate Strongbox From OrientDB to JanusGraph][issue-1649].

### JDK11 support

We are working on introducing support for JDK11. The work for this is currently only for the `issues/1649` branch,
but we would like to apply the same changes to the `master` branch as well. For more details, you can check
[#1111: Test our build with JDK 11 and fix any issues with it][issue-1111].

### LDAP support

We would like some help with further improving our support for LDAP.

Here's a [list of our tasks][list-of-ldap-tasks] for our tasks for this.

[<--# Links -->]: #
[chat]: ../../chat-redirect.md

[strongbox]: https://github.com/strongbox/strongbox/
[strongbox-parent]: https://github.com/strongbox/strongbox-parent/
[strongbox-web-integration-tests]: https://github.com/strongbox/strongbox-web-integration-tests/
[ci-build-images]: https://github.com/strongbox/ci-build-images

[hackfests]: ../index.md
[upgrading-dependencies]: ../../developer-guide/upgrading-dependencies-and-plugins.md

[good-first-issue-link]: https://github.com/strongbox/strongbox/issues?q=is%3Aissue+is%3Aopen+label%3A%22good%20first%20issue%22
[good-first-issue-badge]: https://img.shields.io/github/issues-raw/strongbox/strongbox/good%20first%20issue.svg?label=good%20first%20issue
[help-wanted-link]: https://github.com/strongbox/strongbox/issues?q=is%3Aissue+is%3Aopen+label%3A%22help%20wanted%22
[help-wanted-badge]: https://img.shields.io/github/issues-raw/strongbox/strongbox/help%20wanted.svg?label=help%20wanted&color=%23856bf9&

[gracehopperosd-link]: https://github.com/strongbox/strongbox/issues?q=is%3Aissue+is%3Aopen+label%3AGraceHopperOSD
[gracehopperosd-badge]: https://img.shields.io/github/issues-raw/strongbox/strongbox/GraceHopperOSD.svg?label=GraceHopperOSD

[anitab-ghc-oss-day-details]: https://ghc.anitab.org/programs-and-awards/open-source-day/2020
[anitab-ghc-chat]: https://app.slack.com/client/T017FULSEU8/C018WM3KLR3

[presentation-file]: https://docs.google.com/presentation/d/1HR7Vn59aBBdmGWDw_Yna74i76Bc9vyNr79TN7n6FM9M/edit?usp=sharing
[issue-1111]: https://github.com/strongbox/strongbox/issues/1111
[issue-1649]: https://github.com/strongbox/strongbox/issues/1649
[list-of-dependency-upgrades]: https://github.com/strongbox/strongbox/issues?q=is%3Aissue+is%3Aopen+label%3Adependencies
[list-of-ldap-tasks]: https://github.com/strongbox/strongbox/issues?q=is%3Aissue+is%3Aopen+label%3AGraceHopperOSD+ldap
