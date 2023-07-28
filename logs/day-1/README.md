# DAY 1

**Requirement:**

- Docker / [Docker destop](https://www.docker.com/products/docker-desktop/)


### 1. Install minikube with homebrew

`brew install minikube`

### 2. Create minikube cluster

`minikube start`
![1.1](img/1.1.png)

### 3. Interact with cluster

Get all pods from all namespaces

`kubectl get po -A`
![1.2](img/1.2.png)

Start kubernetes dashboard

`minikube dashboard`
![1.3](img/1.3.png)
![1.4](img/1.4.png)