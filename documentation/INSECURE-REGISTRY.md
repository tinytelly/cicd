# Insecure Registry

### To register each node as an insecure registry
We have to do this to allow a docker instance on each node to be able to use an [insecure docker registry](https://docs.docker.com/registry/insecure/).

In gcp(google cloud console) do the following which will be similar for a Nutanix Node.
You need to login to the JFrog UI first and reset the admin password and set up docker repo.
Use the kubeconfig for the JFrog cluster and run the following command to get the ip address.
Tip: the IP address is the IP you used to login JFrog in the browser.
```
    export IP=$(kubectl --namespace artifactory-jcr get svc jfrog-container-registry-artifactory-nginx  -o jsonpath="{.status.loadBalancer.ingress[0].ip}")
    [ -z "${IP}" ] && export IP=$(kubectl --namespace artifactory-jcr get svc jfrog-container-registry-artifactory-nginx  -o jsonpath="{.status.loadBalancer.ingress[0].hostname}")
    echo "IP = $IP"
```
Now ssh onto the Node created for the jenkins or dev cluster
```
# Find the node name
kubectl get nodes
```
---
#### Add in the insecure-registry by IP
```
IP=<IP Address from JFrog cluster>
sudo vi /etc/default/docker

# add this to the end of DOCKER_OPTS 
"--insecure-registry $IP"

# restart docker 
sudo service docker restart 
OR 
sudo systemctl restart docker

# confirm the IP is in place
docker info | grep $IP
```
---

#### Add in the insecure-registry by hostname
For [AWS](AWS-SETUP.md)

get the nameserver from 
```
cat /etc/resolv.conf
```
then edit

```
sudo vi /etc/docker/daemon.json
```
adding this to the end of the file.

```
"insecure-registries" : [ "<DNS Hostname from JFrog cluster>" ],
"dns": ["<nameserver>", "8.8.8.8"]
```
now restart docker.
``` 
sudo service docker restart
```
Confirm the Insecure Registry is correct.
```
docker info
```
---
*...continue with the* 
- [JFrog setup](../infrastructure/jfrog/README.md)
- [Jenkins Setup](../applications/jenkins/README.md)
- or the [Standard Cluster Setup](../documentation/STANDARD_CLUSTER.md)