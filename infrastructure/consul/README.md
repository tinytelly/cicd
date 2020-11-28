## To install consul
Consul is used for [service discovery](https://www.consul.io/intro).
We use the [consul helm chart](https://github.com/hashicorp/consul-helm).
Consul requires a minimum 3 nodes in a cluster.

```
helm upgrade --install consul hashicorp/consul --set global.name=consul --set ui.service.type=LoadBalancer --set connectInject.enabled=true
```
## Find the consul ui service url 
```
    export CONSUL_UI_IP=$(kubectl get svc consul-ui  -o jsonpath="{.status.loadBalancer.ingress[0].ip}")
    echo "The Consul UI url to go to in your browser is : http://$CONSUL_UI_IP/"
```

### To add an application to consul
Adding an application to consul is achieved via adding annotations to the [values.yaml](../../applications/bpm/bpm/values.yaml) file that is part of the helm deployment.
A typical annotation would look like this.
```
podAnnotations:
  'consul.hashicorp.com/connect-inject': 'true'
  'consul.hashicorp.com/connect-service': 'bpm'
```