#### Kubernetes Management
This is where we manage things like [RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) and Credentials for an image repository.

### List all the roles in a cluster
```
kubectl get rolebindings,clusterrolebindings --all-namespaces -o custom-columns='KIND:kind,NAMESPACE:metadata.namespace,NAME:metadata.name,SERVICE_ACCOUNTS:subjects[?(@.kind=="ServiceAccount")].name'
```

### Logical view of our RBAC setup
```
admins 
  # admins have full cluster access including deleting clusters
    - blackmorem
ops
  # ops have read/write on clusters which is limited to the default namespace for now
    - woodm
    - newnamp
```
### To apply the RBAC
```
kubectl apply -f ClusterRoleBinding-admins-rbac.yaml -f ClusterRole-role-ops-rbac.yaml -f ClusterRoleBinding-ops-rbac.yaml
```