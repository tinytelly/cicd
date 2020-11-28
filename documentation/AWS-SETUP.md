## Amazon Web Service Setup

#### Install first
Install [eksctl](https://github.com/weaveworks/eksctl) on windows via chocolatey. 

Note: when using AWS you have to build as below based on the fact they use a [different docker network](https://github.com/awslabs/amazon-eks-ami/issues/183#issuecomment-463979068).
```
docker build --network host ...
```

Create a ssh key by running this and accepting the defaults.
```
ssh-keygen
```
Create a private key from your public key
```
1) run puttygen
2) browse the public key
3) save a private key
4) this is the key to use in putty to connect to the instance.
```

#### Common Variables across clusters
```
export JFROG_CLUSTER=jfrog
export JENKINS_CLUSTER=jenkins
export DEV_CLUSTER=dev
```
#### JFrog Cluster 
```
eksctl create cluster --name=$JFROG_CLUSTER --nodes=1
```

#### Jenkins Cluster 
```
eksctl create cluster --name=$JENKINS_CLUSTER --nodes=1 --ssh-access
```

#### Standard Development Cluster
This cluster uses a config file [dev-cluster.yaml](dev-cluster.yaml) as an example.
```
eksctl create cluster -f dev-cluster.yaml
```

#### Delete the clusters
```
eksctl delete cluster --name=$JFROG_CLUSTER
eksctl delete cluster --name=$JENKINS_CLUSTER
eksctl delete cluster --name=$DEV_CLUSTER
```

#### How to get the kubeconfig of a cluster
This will get the dev cluster kubeconfig
```
 eksctl utils write-kubeconfig --name=$DEV_CLUSTER
```

*...continue with the* 
- [JFrog setup](../infrastructure/jfrog/README.md)
- [Jenkins Setup](../applications/jenkins/README.md)
- or the [Standard Cluster Setup](../documentation/STANDARD_CLUSTER.md)