## To install dashboard
The [dashboard](https://github.com/kubernetes/dashboard) is like [portainer](https://www.portainer.io/) for kubernetes.
```
    helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
    helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --set service.type=LoadBalancer
```
### if you chose not to waste a loadbalancer ip
you can run the above and remove --set service.type=LoadBalancer
this will install the dashboard with a ClusterIP.
To port forward to that cluster ip.
```
    export POD_NAME=$(kubectl get pods -n default -l "app.kubernetes.io/name=kubernetes-dashboard,app.kubernetes.io/instance=kubernetes-dashboard" -o jsonpath="{.items[0].metadata.name}")
    echo https://127.0.0.1:8443/
    kubectl -n default port-forward $POD_NAME 8443:8443
# then if you open https://127.0.0.1:8443/ in your browser and on the first screen point at your kubeconfig file and you will log into the dashboard
```

### To get a token to login to the dashboard
```
kubectl -n kube-system get secret | grep deployment-controller-token
kubectl -n kube-system describe secret deployment-controller-XXXXX
```

## Alternative Dashboards

[weavescope](https://github.com/weaveworks/scope)
```
helm upgrade --install weave-scope stable/weave-scope --set global.service.type=LoadBalancer
```