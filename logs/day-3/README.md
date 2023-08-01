# DAY 3

![Static Badge](https://img.shields.io/badge/Date-1--8--2023-blue?logo=googlecalendar&logoColor=f5f5f5)

## Using a Service to Expose Your App

The **Service** allows us to access the application on our Pods. Within the Service, we can specify the **Pods** to which we want to direct traffic. The Service has various ways to be exposed by defining its type:

- **ClusterIP (default)** - Exposes the Service on an internal IP in the cluster. This type makes the Service only reachable from within the cluster.

- **NodePort** - Exposes the Service on the same port of each selected Node in the cluster using NAT. Makes a Service accessible from outside the cluster using `<NodeIP>:<NodePort>`. Superset of ClusterIP.

- **LoadBalancer** - Creates an external load balancer in the current cloud (if supported) and assigns a fixed, external IP to the Service. Superset of NodePort.

- **ExternalName** - Maps the Service to the contents of the externalName field (e.g. foo.bar.example.com), by returning a CNAME record with its value. No proxying of any kind is set up. This type requires v1.7 or higher of kube-dns, or CoreDNS version 0.0.8 or higher.

To expose our previous Pods we can use **expose** subcommand, define the type to **NodePort**, set the port to 8080

`kubectl expose deployment/kubernetes-bootcamp --type="NodePort" --port 8080`

`kubectl get services`

`kubectl describe services/kubernetes-bootcamp`

`minikube service kubernetes-bootcamp --url`

## Reference
- [Using a Service to Expose Your App](https://kubernetes.io/docs/tutorials/kubernetes-basics/expose/expose-intro/)