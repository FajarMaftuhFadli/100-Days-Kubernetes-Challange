# DAY 1

![Static Badge](https://img.shields.io/badge/Date-28--7--2023-f5f5f5?logo=googlecalendar&logoColor=f5f5f5)
![Static Badge](https://img.shields.io/badge/Docker-v24.0.2-2496ed?logo=docker&logoColor=2496ed)
![Static Badge](https://img.shields.io/badge/minikube-v1.30.1-326ce5?logo=kubernetes&logoColor=326ce5)

## Kubernetes

### What is Kubernetes?

Kubernetes, also known as **K8s**, a widely used open-source platform, facilitates the deployment, scaling, and management of container applications. Initially created by **Google**, Kubernetes is versatile enough to operate in various infrastructure environments, including on-premise, cloud, and hybrid setups.

### Key features

- Automated rollouts and rollbacks
- Service discovery and load balancing
- Storage orchestration
- Self-healing
- Secret and configuration management
- Automatic bin packing
- Batch execution
- Horizontal scaling
- IPv4/IPv6 dual-stack
- Designed for extensibility

### Minikube

Minikube is a local Kubernetes implementation that runs on a single machine. It is designed for development and testing, and it is not intended to be used in production. Minikube is a good way to learn about Kubernetes and to test your applications before you deploy them to a production cluster.

## Getting Started

**Requirement:**

For this practice I use **Docker**/[Docker Destop](https://www.docker.com/products/docker-desktop/) as the virtual infrastructure.

I also use [kubectl](https://kubernetes.io/docs/tasks/tools/) as the Kubernetes command-line tool, allows us to interact with the Kubernetes cluster using commands.

### 1. Install minikube 

**minikube** is accessible on various platforms and package managers, including **Homebrew** which I use in this exercise.

`brew install minikube`

### 2. Create minikube cluster

Before we can start using Kubernetes, we must first set up the cluster on our local machine's Docker.

`minikube start`

output:
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

### 3. Interact with cluster

Using kubectl we can get all pods from all namespaces.

`kubectl get po -A`

output:
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

> *Pods* are the smallest deployable units of computing that you can create and manage in Kubernetes.

> In Kubernetes, *namespaces* provides a mechanism for isolating groups of resources within a single cluster.

minikube also provides a Kubernetes dashboard, which enables us to obtain valuable information and oversee our cluster.

We can start the dashboard server locally using this command.

`minikube dashboard`

output:
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

Once the dashboard is prepared, you can simply access the URL through your web browser.

![1.1](img/1.1.png)

## Navigation

[ HOME ](../../README.md) ∙ [NEXT ▶](../day-2/README.md)

## Reference
- [kubernetes](https://kubernetes.io/)
- [pods](https://kubernetes.io/docs/concepts/workloads/pods/)
- [minikube start](https://minikube.sigs.k8s.io/docs/start/)