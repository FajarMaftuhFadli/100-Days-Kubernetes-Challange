# DAY 3

![Static Badge](https://img.shields.io/badge/Date-1--8--2023-f5f5f5?logo=googlecalendar&logoColor=f5f5f5)
![Static Badge](https://img.shields.io/badge/Docker-v24.0.2-2496ed?logo=docker&logoColor=2496ed)
![Static Badge](https://img.shields.io/badge/minikube-v1.30.1-326ce5?logo=kubernetes&logoColor=326ce5)

## Using a Service to Expose Your App

### 1. Create a new Service

The **Service** allows us to access the application on our Pods. Within the Service, we can specify the **Pods** to which we want to direct traffic. The Service has various ways to be exposed by defining its type:

- **ClusterIP (default)** - Exposes the Service on an internal IP in the cluster. This type makes the Service only reachable from within the cluster.

- **NodePort** - Exposes the Service on the same port of each selected Node in the cluster using NAT. Makes a Service accessible from outside the cluster using `<NodeIP>:<NodePort>`. Superset of ClusterIP.

- **LoadBalancer** - Creates an external load balancer in the current cloud (if supported) and assigns a fixed, external IP to the Service. Superset of NodePort.

- **ExternalName** - Maps the Service to the contents of the externalName field (e.g. foo.bar.example.com), by returning a CNAME record with its value. No proxying of any kind is set up. This type requires v1.7 or higher of kube-dns, or CoreDNS version 0.0.8 or higher.

To expose our previous Pods we can use **expose** subcommand, define the type to **NodePort**, set the port to 8080

`kubectl expose deployment/kubernetes-bootcamp --type="NodePort" --port 8080`

Let see our services:

`kubectl get services`

```
NAME                  TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
kubernetes            ClusterIP   10.96.0.1      <none>        443/TCP          4d5h
kubernetes-bootcamp   NodePort    10.98.21.129   <none>        8080:31536/TCP   10m
```

We can also view the detail of our service.

`kubectl describe services/kubernetes-bootcamp`

```
Name:                     kubernetes-bootcamp
Namespace:                default
Labels:                   app=kubernetes-bootcamp
Annotations:              <none>
Selector:                 app=kubernetes-bootcamp
Type:                     NodePort
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.98.21.129
IPs:                      10.98.21.129
Port:                     <unset>  8080/TCP
TargetPort:               8080/TCP
NodePort:                 <unset>  31536/TCP
Endpoints:                10.244.0.20:8080
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>
```

In the above output, we can see some important info such as Port, Labels, Type, etc.

Since we utilize minikube within a docker, it becomes necessary to execute this command. By doing so, minikube establishes a tunnel connecting the minikube cluster to our local machine and assigns the service to the local port.

`minikube service kubernetes-bootcamp --url`

```
http://127.0.0.1:54449
❗  Because you are using a Docker driver on darwin, the terminal needs to be open to run it.
```

### 2. Using labels

**Labels** are essentially text-based key-value pairs that get associated with different resources within Kubernetes (K8s). You can apply multiple labels to a single resource. These labels can be utilized as selectors to identify specific resources, or they can be used to group and categorize resources based on common characteristics.

We can view the label from a resource using **describe**

`kubectl describe deployments.apps kubernetes-bootcamp`

```
.
.
Pod Template:
  Labels:       app=kubernetes-bootcamp
  Annotations:  kubectl.kubernetes.io/restartedAt: 2023-08-01T15:38:04+07:00
.
.
```

Utilize the `-l` option to employ the label selector. The label selector can be applied to different types of resources as well.

`kubectl get pods -l app=kubernetes-bootcamp`

I export the pod name to the env var so that we can use it later.

`export POD_NAME="$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')"`

Here we add label `version=v1` to the pod

`kubectl label pods "$POD_NAME" version=v1`

```
pod/kubernetes-bootcamp-6bf7958f5f-dp7gj labeled
```

Thus we can see the new label when we describe.

`kubectl describe pods "$POD_NAME"`

We can used it in label selector as well.

`kubectl get pods -l version=v1`

### 3. Deleting a service

We can do other operation such as **delete** using label selector too.

`kubectl delete service -l app=kubernetes-bootcamp`

Get the services to confirm if the service is deleted.

`kubectl get services`

## Navigation

[`◀︎ PREVIOUS`](../day-2/README.md) ∙ [ `HOME` ](../../README.md) ∙ [`NEXT ▶︎`](../day-4/README.md)

## Reference
- [Using a Service to Expose Your App](https://kubernetes.io/docs/tutorials/kubernetes-basics/expose/expose-intro/)