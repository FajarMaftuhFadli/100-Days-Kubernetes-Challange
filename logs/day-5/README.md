# DAY 5

![Static Badge](https://img.shields.io/badge/Date-3--8--2023-f5f5f5?logo=googlecalendar&logoColor=f5f5f5)
![Static Badge](https://img.shields.io/badge/Docker-v24.0.2-2496ed?logo=docker&logoColor=2496ed)
![Static Badge](https://img.shields.io/badge/minikube-v1.30.1-326ce5?logo=kubernetes&logoColor=326ce5)

## Performing a Rolling Update

The rolling update involves sequentially updating our Pods. This process enables K8s to update applications without any downtime. By default, K8s creates a new updated Pod and replaces an old one, but this behavior can be modified. If any issues arise with the new version, we have the option to rollback to the previous version of our apps.

### 1. Update the version of the app

Previously I have 2 replicas in the deployment as we can confirm here.

`kubectl get deployments`

And there is two pods that are in READY state.

`kubectl get pods`

We can also see the current image version by **describe** our pods.

`kubectl describe pods`

```
    .
    .
    Image:          gcr.io/google-samples/kubernetes-bootcamp:v1
    .
    .
```

To update our app we can use `set image` to our **kubernetes-bootcamp** deployment using newer image version which is v2.

`kubectl set image deployments/kubernetes-bootcamp kubernetes-bootcamp=jocatalin/kubernetes-bootcamp:v2`

We can verify that the update process is functioning correctly, as we observe an extra pod with a `ContainerCreating` status.

`kubectl get pods`

```
NAME                                   READY   STATUS              RESTARTS      AGE
kubernetes-bootcamp-6bf7958f5f-jtfvz   1/1     Running             1 (17m ago)   27h
kubernetes-bootcamp-6bf7958f5f-shbc7   1/1     Running             1 (17m ago)   27h
kubernetes-bootcamp-7dd8b87c5c-lvzb2   0/1     ContainerCreating   0             26s
```

## Navigation

[`◀︎ PREVIOUS`](../day-4/README.md) ∙ [ `HOME` ](../../README.md) ∙ [`NEXT ▶︎`](../day-6/README.md)

## Reference

- [Performing a Rolling Update](https://kubernetes.io/docs/tutorials/kubernetes-basics/update/update-intro/)