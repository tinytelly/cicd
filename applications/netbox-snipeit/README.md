# Netbox and SnipeIT Stack
This is how to run up a [snipeit](https://snipeitapp.com/) and [netbox](https://github.com/netbox-community/netbox-docker) stack in docker.

### Install SnipeIT
Following this [helm chart](https://hub.helm.sh/charts/t3n/snipeit/1.0.5)
```
# You need to run docker to get a key...we can't run docker on our VDI so you will need to run docker locally or somewhere else.
    docker run -i -t snipe/snipe-it php artisan key:generate --show
## Use the outputed key as below.

helm repo add t3n https://storage.googleapis.com/t3n-helm-charts
helm upgrade --install snipeit t3n/snipeit --set config.snipeit.key="base64:DJCZALkBBuebFPkq581bDh9IbvQZlR+UNY7EJsvMprw=" --set service.type=LoadBalancer

```

### Install Netbox
Following this [helm chart](https://github.com/bootc/netbox-chart)
```
helm repo add bootc https://charts.boo.tc
helm install netbox bootc/netbox --set service.type=LoadBalancer
```