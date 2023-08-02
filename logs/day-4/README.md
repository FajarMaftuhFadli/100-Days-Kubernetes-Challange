# DAY 4

![Static Badge](https://img.shields.io/badge/Date-2--8--2023-f5f5f5?logo=googlecalendar&logoColor=f5f5f5)
![Static Badge](https://img.shields.io/badge/Docker-v24.0.2-2496ed?logo=docker&logoColor=2496ed)
![Static Badge](https://img.shields.io/badge/minikube-v1.30.1-326ce5?logo=kubernetes&logoColor=326ce5)

## Running Multiple Instances of Your App

### 1. Scaling a deployment

Scaling Pods in K8s involves modifying the replica count in the deployment. This process offers several benefits, including:

- High Availability: Horizontal scaling allows for the redirection of traffic to other functioning Pods in case one Pod fails or malfunctions.
- Enhanced Performance: K8s can increase the number of Pod replicas to meet growing traffic demands, ensuring optimal performance.
- And numerous other advantages...

Here we scale up the deployment replicas to 4.

`kubectl scale deployments/kubernetes-bootcamp --replicas=4`

We can verify the scaling progress by examining the READY data. In this case, we observe that the ratio is 4/4, indicating that we currently have 4 Pods, matching the desired 4 Replicas.

`kubectl get deployments`

```
NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
kubernetes-bootcamp   4/4     4            4           46h
```

By using `-o wide` here we can also see that each Pods have its own IP address.

`kubectl get pods -o wide`

The process of scale up the replicas that we have recently done is recorded in the events logs here.

`kubectl describe deployments/kubernetes-bootcamp`

### 2. Load Balancing

Because I delete the service yesterday, now we need to create the service again.

`kubectl expose deployments.apps kubernetes-bootcamp --type=NodePort --port=8080`

Create a mininkube tunnel to that service.

`minikube service kubernetes-bootcamp --url`

Open the URL provided using a browser.

```
Hello Kubernetes bootcamp! | Running on: kubernetes-bootcamp-6bf7958f5f-dp7gj | v=1

Hello Kubernetes bootcamp! | Running on: kubernetes-bootcamp-6bf7958f5f-jtfvz | v=1
.
.
.
```

From the output, we observe that the suffix is varying, indicating that it originated from various Pods, and the Load Balancer is functioning correctly.

### 3. Scale Down

We can also utilize **scale** for reducing the size of our deployment.

`kubectl scale deployments/kubernetes-bootcamp --replicas=2`

We can verify that the available pods are fully occupied, with a total of 2 out of 2 being in use.

`kubectl get deployments.apps`

Two of these Pods are currently undergoing termination, as we can see from their status.

`kubectl get pods -o wide`

```
NAME                                   READY   STATUS        RESTARTS        AGE     IP            NODE       NOMINATED NODE   READINESS GATES
kubernetes-bootcamp-6bf7958f5f-dp7gj   1/1     Terminating   1 (3h54m ago)   23h     10.244.0.21   minikube   <none>           <none>
kubernetes-bootcamp-6bf7958f5f-jtfvz   1/1     Running       0               3h40m   10.244.0.27   minikube   <none>           <none>
kubernetes-bootcamp-6bf7958f5f-shbc7   1/1     Running       0               3h40m   10.244.0.25   minikube   <none>           <none>
kubernetes-bootcamp-6bf7958f5f-zvtbx   1/1     Terminating   0               3h40m   10.244.0.26   minikube   <none>           <none>
```

## Navigation

[`◀︎ PREVIOUS`](../day-3/README.md) ∙ [ `HOME` ](../../README.md) ∙ [`NEXT ▶︎`](../day-5/README.md)

## Reference

- [Running Multiple Instances of Your App](https://kubernetes.io/docs/tutorials/kubernetes-basics/scale/scale-intro/)