# AIS - Placeholder
Note this is not currently operational! 
### What ais is expecting to serve
```
http://localhost:8980/DoJob?WSDL
```

### To install the AIS Placeholder
```
helm repo add nginx-stable https://helm.nginx.com/stable
helm repo update
helm upgrade -f values.yaml --install ais-placeholder nginx-stable/nginx-ingress
```