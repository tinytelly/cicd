## Nutanix Karbon Setup
The following is steps for setting up clusters on Nutanix Karbon.

## To setup via a k8s cluster
download the kubeconfig of the cluster
```
export KUBECONFIG=/path/to/kubeconfig
# e.g export KUBECONFIG=/d/work/archimate/MASAHV-KB1-kubectl.cfg

# check you can see the cluster
kubectl get svc
```

This will be documented at a later date.  If using a Karbon cluster you are going
to need [metallb](../infrastructure/metallb/README.md) to provide an external load balanced IP address.
```
karboncli ...
```

*...continue with the* 
- [JFrog setup](../infrastructure/jfrog/README.md)
- [Jenkins Setup](../applications/jenkins/README.md)
- or the [Standard Cluster Setup](../documentation/STANDARD_CLUSTER.md)