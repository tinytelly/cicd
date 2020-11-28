# Standard Cluster
A Standard Cluster is the place to expect to find dev, test, production deployments.
Each logical area will get its own cluster, so all test environments would be on the test cluster as an example.

## Set up the Standard cluster
Set up a minimum 3 node cluster with a minimum 8gb memory.

#### Create the cluster
- [Nutanix Karbon](../documentation/KARBON-SETUP.md)
- [Google Cloud](../documentation/GCP-SETUP.md)
- [Amazon Cloud](../documentation/AWS-SETUP.md)

#### Create a secret to pull the docker images
```
export DOCKER_REGISTRY_URL=$IP
export DOCKER_REGISTRY_USERNAME=admin
export DOCKER_REGISTRY_PASSWORD=2TjtMDCE

echo DOCKER_REGISTRY_URL = $DOCKER_REGISTRY_URL

kubectl create secret docker-registry docker-image-creds \
--docker-server=$DOCKER_REGISTRY_URL \
--docker-username=$DOCKER_REGISTRY_USERNAME \
--docker-password=$DOCKER_REGISTRY_PASSWORD \
--docker-email=matt.wood@mmc.com
```

## To register JFrog as an insecure registry
It's important to follow this to [register each node](INSECURE-REGISTRY.md) before installing any applications.

## To install GitOps so that we can have automatic deployments. 
follow steps for setting up [GitOps](../infrastructure/gitops/README.md).

## To install Consul so that we can have a Service Discovery 
follow steps for setting up [Consul](../infrastructure/consul/README.md).

## To install Aol on the development cluster
follow steps for setting up [Aol](../applications/acurity/aol/README.md).

## To install BPM on the development cluster
follow steps for setting up [BPM](../applications/bpm/README.md).