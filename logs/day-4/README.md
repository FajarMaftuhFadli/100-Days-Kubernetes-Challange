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

### 3. Scale Down

## Navigation

[`◀︎ PREVIOUS`](../day-3/README.md) ∙ [ `HOME` ](../../README.md) ∙ [`NEXT ▶︎`](../day-5/README.md)

## Reference

- [Running Multiple Instances of Your App](https://kubernetes.io/docs/tutorials/kubernetes-basics/scale/scale-intro/)