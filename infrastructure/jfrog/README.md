# JFrog
The first thing we need to manage kubernetes clusters is a place to put and pull docker images from.
Open source free images will always come from [docker hub](https://hub.docker.com/) but images that we manage and 
write code for need to be kept in a private repository.  If we were able to use SaaS we could use a private repository 
in the cloud, but we currently can't do that.
Given this we need to run up a private repository and will use [JFrog](https://jfrog.com/container-registry/) as its free to use it for this purpose.

## Set up the JFrog cluster
The image repository should exist on its own isolated cluster.  Set up a 1 node cluster with a minimum 8gb memory for this purpose.

#### Create the cluster
- [Nutanix Karbon](../../documentation/KARBON-SETUP.md)
- [Google Cloud](../../documentation/GCP-SETUP.md)
- [Amazon Cloud](../../documentation/AWS-SETUP.md)

## Install JFrog

following the official [JFrog Helm Chart](https://hub.helm.sh/charts/jfrog/artifactory-jcr)
```
    helm repo add center https://repo.chartcenter.io
    helm repo update
    kubectl create namespace artifactory-jcr    
    helm upgrade --install jfrog-container-registry --set postgresql.postgresqlPassword=1234 --namespace artifactory-jcr center/jfrog/artifactory-jcr
    watch kubectl -n artifactory-jcr get pods
```

### Log into JFrog and do the initial config
find the JFrog nginx service url
```
    export IP=$(kubectl --namespace artifactory-jcr get svc jfrog-container-registry-artifactory-nginx  -o jsonpath="{.status.loadBalancer.ingress[0].ip}")
    [ -z "${IP}" ] && export IP=$(kubectl --namespace artifactory-jcr get svc jfrog-container-registry-artifactory-nginx  -o jsonpath="{.status.loadBalancer.ingress[0].hostname}")
    echo "The JFrog url to go to in your browser is : http://$IP/"
```
log in with 
```
    User: admin
    Password: password
```    
You now need to change the default password and set up the default docker repository.  
The steps for how to do a basic set up can be found in this [example](https://jfrog.com/blog/how-to-set-up-a-private-remote-and-virtual-docker-registry/).  
The current password to set is 2TjtMDCE

...now continue with the [Jenkins setup](../../applications/jenkins/README.md) if you are running the full setup via the [Runbook](../../documentation/RUNBOOK.md).