## To install metallb which provides LoadBalancing for a private cloud.
Following this [Karbon Conmmunity Blog](https://next.nutanix.com/architectural-best-practices-74/utilizing-metallb-to-provide-loadbalancer-services-for-nutanix-karbon-32966) we install metallb following their [instructions](https://metallb.universe.tf/installation/#installation-by-manifest).

A) Deploy metallb.

```
    METALLB=v0.9.3 # find the latest version here : https://github.com/metallb/metallb/releases
    kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/$METALLB/manifests/namespace.yaml
    kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/$METALLB/manifests/metallb.yaml
# On first install only
    kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
```

B) Get the IP Address of the karbon worker nodes.
Run this and use the first 3 columns of the subnet range to create a range to config metallb with.
```
kubectl describe nodes | grep Internal 
```
```
e.g. if your range is 
  InternalIP:  10.100.96.100
  InternalIP:  10.100.96.33
  InternalIP:  10.100.96.60
```
  
then your ip range could be based on the instructions in the [blog](https://next.nutanix.com/architectural-best-practices-74/utilizing-metallb-to-provide-loadbalancer-services-for-nutanix-karbon-32966) we install metallb following their [instructions](https://metallb.universe.tf/installation/#installation-by-manifest)
```
  10.100.96.11
  10.100.96.15

```
C) Create the config map for metallb.
See the [metallb configmap](metallb-config.yaml) with the IP addresses set from the karbon cluster.
Apply the config map running the below.
```
kubectl apply -f metallb-config.yaml
```
