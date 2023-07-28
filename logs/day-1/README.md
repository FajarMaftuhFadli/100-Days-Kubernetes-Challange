# DAY 1



**Requirement:**

- Docker / [Docker destop](https://www.docker.com/products/docker-desktop/)


## 1. Install minikube with homebrew

`brew install minikube`

## 2. Create minikube cluster

`minikube start`

```
😄  minikube v1.30.1 on Darwin 13.4.1 (arm64)
✨  Using the docker driver based on existing profile
👍  Starting control plane node minikube in cluster minikube
🚜  Pulling base image ...
🏃  Updating the running docker "minikube" container ...
🐳  Preparing Kubernetes v1.26.3 on Docker 23.0.2 ...
🔗  Configuring bridge CNI (Container Networking Interface) ...
🔎  Verifying Kubernetes components...
    ▪ Using image docker.io/kubernetesui/dashboard:v2.7.0
    ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
    ▪ Using image docker.io/kubernetesui/metrics-scraper:v1.0.8
💡  Some dashboard features require the metrics-server addon. To enable all features please run:

        minikube addons enable metrics-server


🌟  Enabled addons: default-storageclass, storage-provisioner, dashboard
🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default
```

## 3. Interact with cluster

Get all pods from all namespaces

`kubectl get po -A`

```
NAMESPACE     NAME                               READY   STATUS    RESTARTS        AGE
kube-system   coredns-787d4945fb-57fn4           1/1     Running   1 (8m42s ago)   10m
kube-system   etcd-minikube                      1/1     Running   1 (8m47s ago)   10m
kube-system   kube-apiserver-minikube            1/1     Running   1 (8m36s ago)   10m
kube-system   kube-controller-manager-minikube   1/1     Running   1 (8m47s ago)   10m
kube-system   kube-proxy-sdwfn                   1/1     Running   1 (8m47s ago)   10m
kube-system   kube-scheduler-minikube            1/1     Running   1 (8m47s ago)   10m
kube-system   storage-provisioner                1/1     Running   3 (4m56s ago)   10m
```

Start kubernetes dashboard

`minikube dashboard`

```
🔌  Enabling dashboard ...
    ▪ Using image docker.io/kubernetesui/dashboard:v2.7.0
    ▪ Using image docker.io/kubernetesui/metrics-scraper:v1.0.8
💡  Some dashboard features require the metrics-server addon. To enable all features please run:

        minikube addons enable metrics-server


🤔  Verifying dashboard health ...
🚀  Launching proxy ...
🤔  Verifying proxy health ...
🎉  Opening http://127.0.0.1:51214/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/ in your default browser...
```
![1.1](img/1.1.png)

## Reference
- [minikube start](https://minikube.sigs.k8s.io/docs/start/)