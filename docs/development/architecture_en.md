# k8s-loki Architecture

## Deployment

By default, the Loki component is deployed in the "monolithic" 
(also called "single binary") mode. It will spawn one "gateway" 
pod, which is the single entry point for the Loki cluster, directing 
both incoming logs and log queries. The second pod handles the 
actual log storage and retrieval. It also handles retention and 
compaction of logs. 

For each Kubernetes node, one loki-canary pod is spawned. 
The loki-canary pod is responsible for monitoring the health 
of the Loki cluster and ensuring that the cluster is functioning properly. 

The single binary mode can be scaled horizontally by increasing the amount
of replicas of the single binary pod, but this is not recommended.

Loki can also be run in a microservice mode where each component 
is deployed as a separate pod, with redundancy built in. Using the 
default parameters for this mode, about 15 pods will be deployed. Horizontal
scaling of these pods is possible, targeting the component that is 
responsible for the particular task that needs to be scaled.

## Storage

By default, k8s-loki stores data on the filesystem. A persistent volume claim
(PVC) is used to store the data. Filesystem storage is not recommended for large
deployments with daily traffic of more than several GB a day. An S3 object 
storage should be configured instead. 

# Retention and Compaction

Loki has a built-in compactor that handles both compaction and retention. There is 
a "retention period", meaning the amount of time that logs are kept in the system, a
"retention delete delay", the delay after which the Conpactor will actually delete the
logs that are marked for deletion.

Log compaction runs periodically according to the setting of the "compactor period"
parameter.