### BPM-External-Service
This deploys all the external services that are part of a bpm deployment.

## Note
These external services rely on certain things to be running on start-up, like an Acurity Database.

If NOT using [GitOps](../../infrastructure/gitops/README.md) then you can run the helm chart manually, but ideally you would use GitOps to take care of this for you.

### To deploy bpm-worker-service
```
export DOCKER_REGISTRY_URL=<IP of JFrog>
helm upgrade --install -f bpm-worker-service-values.yaml bpm-worker-service ./bpm-external-service \
--set image.repository="$DOCKER_REGISTRY_URL/docker/bpm-worker-service" \
--set image.tag="master-1.0.0"
```