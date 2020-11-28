### Acurity AOL
Builds and deploys [AOL](https://www.iress.com/software/superannuation/acurity-online/).

It is typical to require AOL when the deployment is as follows
```
[DB] <=> [AIS] <=> [AOL]
```

#### To build the docker image for aol
There is a prebuilt job in Jenkins for this under <Jenkins Url>/job/applications/job/aol, 
but you can also run this same job locally.
```
export DOCKER_REGISTRY_URL=
export DOCKER_REGISTRY_USERNAME=admin
export DOCKER_REGISTRY_PASSWORD=2TjtMDCE

./ci.sh
```

#### To run aol in a k8s cluster
If using [consul](../../../infrastructure/consul/README.md) then create this config map for [aol.xml](consul/aol.xml)
```
kubectl create configmap aol-xml-for-fss-configmap --from-file=consul/aol.xml
```
otherwise, create this config map for the [aol.xml](fss/aol.xml) where the paths are hardcoded server names
```
kubectl create configmap aol-xml-for-fss-configmap --from-file=fss/aol.xml
```

If NOT using [GitOps](../../../infrastructure/gitops/README.md) then you can run the helm chart manually, but ideally you would use GitOps to take care of this for you.
```
export DOCKER_REGISTRY_URL=<IP of JFrog>
helm upgrade --install aol-fss ./aol \
--set client="fss" \
--set image.repository="$DOCKER_REGISTRY_URL/docker/acurity-aol" \
--set image.tag="18.2.2-fss"
```

If you are using GitOps then you may need to change the IP address in [master-fss.yaml](deployments/master-fss.yaml) to reference the correct JFrog IP address is you are not using DNS to manage the endpoint of JFrog.

### To remove aol
```
helm uninstall aol-fss
```

#### To split up aol.war
see [splitting war](war/README.md).