# jefferyb/munin

Munin Docker image | http://hub.docker.com/u/jefferyb/munin

## Using Openshift CLI

```bash
# Deploy Munin
$ oc new-app --name=munin jefferyb/munin
```

## Using Kubernetes CLI

```bash
# Deploy Munin
$ kubectl run munin --image=jefferyb/munin
```

## Using Docker

```bash
# Deploy Munin
$ docker run -itd --name munin -p 4948:4948 jefferyb/munin
```
