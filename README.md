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

## Volumes

  * `/opt/app-root/sandbox/var/lib` used to store the collected data
  * `/opt/app-root/sandbox/etc/munin/munin-conf.d` to add your own configuration

## Ports
  * `4948` - Munin HTTP server
