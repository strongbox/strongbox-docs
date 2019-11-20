# How to inspect a Hazelcast cache

## Introduction

Strongbox uses [Hazelcast] for caching. While developing it can be useful to get detailed information on the Hazelcast cache clusters. By installing the [Hazelcast management center], it is possible to monitor the overall state of Hazelcast clusters, as well as detailed analysis and browsing of data structures in real time, updating map configurations, and taking thread dumps from nodes.

## Getting the Management Center up and running

Download the Hazelcast Management Center from [this page]. Unpack the ZIP or TAR file locally.

For Windows, run `start.bat`. For Linux, run `start.sh`. This will start the application using default settings at `http://localhost:8080/hazelcast-mancenter`.

Navigate to `http://localhost:8080/hazelcast-mancenter` in a browser. You will be prompted for user configuration details. Fill these in and submit.

The Management Center is now ready to receive statistics from the Hazelcast cache clusters in Strongbox.

## Pointing the Strongbox at Management Center
Setting the `cacheManagerConfiguration.managementCenter.enabled` property to `true` will configure Strongbox to send detailed statistics to the Management Center. By default, Strongbox will use the default URL from above, but this can be overridden by using the `cacheManagerConfiguration.managementCenter.url` property.

Once Strongbox is started, detailed information will be available in the Management Center.

## Restrictions

The open source edition of Hazelcast Management Center can at most be used by three members in the cluster. Refer to the [Hazelcast documentation] for more information. 

[Hazelcast]: https://hazelcast.org
[Hazelcast management center]: https://hazelcast.com/product-features/management-center
[this page]: https://hazelcast.org/download/#management-center
[Hazelcast documentation]: https://docs.hazelcast.org/docs/management-center/latest/manual/html/index.html#getting-started