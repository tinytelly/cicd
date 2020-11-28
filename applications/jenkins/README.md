# Jenkins Helm Setup

### To build the docker image
We need to have docker running in jenkins.  To do this we build this [Dockerfile](Dockerfile) by 
running [build.sh](build.sh) on a linux server that has docker on it.

### How this chart works
Following this [example](https://estl.tech/accessing-docker-from-a-kubernetes-pod-68996709c04b)
We did the following
1. forked the stable [helm charts](https://github.com/tinytelly/helm-charts) 
2. allowed for [docker container to node access](https://github.com/jenkinsci/helm-charts/compare/main..tinytelly:main). 
3. add any overrides on the existing chart and update in [values.yaml](values.yaml).

## Set up the Jenkins cluster
Jenkins should exist on its own isolated cluster.  Set up a 1 node cluster with a minimum 8gb memory for this purpose.

#### Create the cluster
- [Nutanix Karbon](../../documentation/KARBON-SETUP.md)
- [Google Cloud](../../documentation/GCP-SETUP.md)
- [Amazon Cloud](../../documentation/AWS-SETUP.md)

### To register JFrog as an insecure registry
It's important to follow this to [register each node](../../documentation/INSECURE-REGISTRY.md) before installing Jenkins.  

### To install or upgrade jenkins 
an upgrade would be used if you changed [values.yaml](values.yaml) and wanted to apply those changes

#### On Linux run.
```
rm -Rf tinytelly-charts
git clone https://github.com/tinytelly/helm-charts tinytelly-charts
helm upgrade -f values.yaml --install jenkins tinytelly-charts/charts/jenkins --set master.docker.registry.url="$IP" --set master.docker.registry.username="admin" --set master.docker.registry.password="2TjtMDCE"
```
#### On Windows run.
```
set HOSTNAME=<DNS Hostname from JFrog cluster>
rd /s /q tinytelly-charts
git clone https://github.com/tinytelly/helm-charts tinytelly-charts
helm upgrade -f values.yaml --install jenkins tinytelly-charts/charts/jenkins --set master.docker.registry.url="%HOSTNAME%" --set master.docker.registry.username="admin" --set master.docker.registry.password="2TjtMDCE"
```

### Test Jenkins is working correctly
log into jenkins via the url below
```
export JENKINS_IP=$(kubectl get svc jenkins -o jsonpath="{.status.loadBalancer.ingress[0].ip}")
[ -z "${JENKINS_IP}" ] && export JENKINS_IP=$(kubectl get svc jenkins -o jsonpath="{.status.loadBalancer.ingress[0].hostname}")
echo "The Jenkins url to go to in your browser is : http://$JENKINS_IP:8080/" with the user/password of admin/admin
```
then goto http://$JENKINS_IP:8080/job/info/job/verify-jenkins/ and run this job.  
on completion, it will have proved we can run docker and push images to JFrog.

...now continue with the [Standard Cluster setup](../../documentation/STANDARD_CLUSTER.md) if you are running the full setup via the [Runbook](../../documentation/RUNBOOK.md).

### To add a bitbucket webhook
Adding a webhook in bitbucket will trigger commits to bitbucket firing off jenkins jobs.  
Follow the plugin instructions to [set up the webhook](https://plugins.jenkins.io/bitbucket/).

### To remove jenkins
```
helm uninstall jenkins
```

### To rebase the forked jenkins stable chart
```
# Add the remote, call it "upstream":
cd tinytelly-charts
git remote add upstream https://github.com/jenkinsci/helm-charts.git

# Fetch all the branches of that remote into remote-tracking branches,
# such as upstream/master:

git fetch upstream

# Make sure that you're on your master branch:

git checkout master

# Rewrite your master branch so that any commits of yours that
# aren't already in upstream/master are replayed on top of that
# other branch:

git rebase upstream/master

# It seems you have to change something to push
vi README.md
git add README.md
git commit -m 'update readme'
git push
```