### BPM
Builds and deploys [Camunda BPM](https://camunda.com/).

#### To build the docker image for BPM
There is a prebuilt job in Jenkins for this under <Jenkins Url>/job/applications/job/bpm.

#### To run BPM in a k8s cluster
If NOT using [GitOps](../../infrastructure/gitops/README.md) then you can run the helm chart manually, but ideally you would use GitOps to take care of this for you.
```
export DOCKER_REGISTRY_URL=<IP of JFrog>
helm upgrade --install bpm ./bpm \
--set image.repository="$DOCKER_REGISTRY_URL/docker/bpm" \
--set image.tag="1.0.0"
```

If you are using GitOps then you may need to change the IP address in [master.yaml](deployments/master.yaml) to reference the correct JFrog IP address is you are not using DNS to manage the endpoint of JFrog.

### Test BPM is working correctly
log into BPM via the url below
```
export BPM_IP=$(kubectl get svc bpm -o jsonpath="{.status.loadBalancer.ingress[0].ip}")
echo "The BPM url to go to in your browser is : http://$BPM_IP:8090/" with the user/password of demo/demo
```

### To remove aol
```
helm uninstall bpm
```
