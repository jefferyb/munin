# jefferyb/munin

Munin Docker image | http://hub.docker.com/u/jefferyb/munin

## Using Openshift CLI

```bash
# development release
$ oc new-app --name=munin jefferyb/munin

# stable release
$ oc new-app --name=munin jefferyb/munin:stable
```

## Using Kubernetes CLI

```bash
# development release
$ kubectl run munin --image=jefferyb/munin

# stable release
$ kubectl run munin --image=jefferyb/munin:stable
```

## Using Docker

```bash
# development release
$ docker run -itd --name munin -p 4948:4948 jefferyb/munin

# stable release
$ docker run -itd --name munin -p 8080:8080 jefferyb/munin:stable
```

## Volumes
#### development release

  * `/opt/app-root/sandbox/var/lib` used to store the collected data
  * `/opt/app-root/sandbox/etc/munin/munin-conf.d` to add your own configuration

#### stable release

  * `/var/lib/munin` used to store the collected data
  * `/etc/munin/conf.d` to add your own configuration

## Ports
  * `4948` - Munin HTTP server (latest development release)
  * `8080` - Munin HTTP server (latest stable release)
