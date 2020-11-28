## Google Cloud Setup

#### Common Variables across clusters
```
PROJECT=<your-project-name>
LOCATION=us-east1-b
JFROG_CLUSTER=jfrog-cluster
JENKINS_CLUSTER=jenkins-cluster
DEV_CLUSTER=dev-cluster
MACHINE_TYPE=e2-standard-2
```
#### JFrog Cluster  
```
gcloud container clusters create $JFROG_CLUSTER --num-nodes=1 --zone=$LOCATION --machine-type=$MACHINE_TYPE --project=$PROJECT
```
#### Jenkins Cluster
```
gcloud container clusters create $JENKINS_CLUSTER --num-nodes=1 --zone=$LOCATION --machine-type=$MACHINE_TYPE --project=$PROJECT
```
#### Standard Cluster
```
gcloud container clusters create $DEV_CLUSTER --num-nodes=3 --zone=$LOCATION --project=$PROJECT
```

*...continue with the* 
- [JFrog setup](../infrastructure/jfrog/README.md)
- [Jenkins Setup](../applications/jenkins/README.md)
- or the [Standard Cluster Setup](../documentation/STANDARD_CLUSTER.md)