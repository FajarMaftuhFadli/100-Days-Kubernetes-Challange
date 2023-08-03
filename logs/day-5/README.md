# DAY 5

![Static Badge](https://img.shields.io/badge/Date-3--8--2023-f5f5f5?logo=googlecalendar&logoColor=f5f5f5)
![Static Badge](https://img.shields.io/badge/Docker-v24.0.2-2496ed?logo=docker&logoColor=2496ed)
![Static Badge](https://img.shields.io/badge/minikube-v1.30.1-326ce5?logo=kubernetes&logoColor=326ce5)

## Performing a Rolling Update

The rolling update involves sequentially updating our Pods. This process enables K8s to update applications without any downtime. By default, K8s creates a new updated Pod and replaces an old one, but this behavior can be modified. If any issues arise with the new version, we have the option to roll back to the previous version of our apps.

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

### 2. Verify an update

We try to verify that our update is succesfull. First lets make sure that we still has our NodePort service.

`kubectl describe services/kubernetes-bootcamp`

Then we start the minikube tunnel to our service.

`minikube service kubernetes-bootcamp --url`

We can confirm that our app is updated to version 2 as we see here `v=2`.

```
Hello Kubernetes bootcamp! | Running on: kubernetes-bootcamp-7dd8b87c5c-5l2tw | v=2
```

### 3. Roll back an update

Let's try updating our app again to version 10 this time.

`kubectl set image deployments/kubernetes-bootcamp kubernetes-bootcamp=gcr.io/google-samples/kubernetes-bootcamp:v10`

using `get pods` we found that there is a problem on the new updating pods, `ImagePullBackOff`.

`kubectl get pods`

```
NAME                                   READY   STATUS             RESTARTS   AGE
kubernetes-bootcamp-7dd8b87c5c-5l2tw   1/1     Running            0          62m
kubernetes-bootcamp-7dd8b87c5c-lvzb2   1/1     Running            0          63m
kubernetes-bootcamp-b78dfb55-bm7wb     0/1     ImagePullBackOff   0          49s
```

To identiy our problem we can check the events logs here.

`kubectl describe pods`

We found that the version 10 is not found or does not exist.

```
.
.
Events:
  Type     Reason     Age                    From               Message
  ----     ------     ----                   ----               -------
  Normal   Scheduled  4m44s                  default-scheduler  Successfully assigned default/kubernetes-bootcamp-b78dfb55-bm7wb to minikube
  Normal   Pulling    3m10s (x4 over 4m43s)  kubelet            Pulling image "gcr.io/google-samples/kubernetes-bootcamp:v10"
  Warning  Failed     3m7s (x4 over 4m41s)   kubelet            Failed to pull image "gcr.io/google-samples/kubernetes-bootcamp:v10": rpc error: code = Unknown desc = Error response from daemon: manifest for gcr.io/google-samples/kubernetes-bootcamp:v10 not found: manifest unknown: Failed to fetch "v10" from request "/v2/google-samples/kubernetes-bootcamp/manifests/v10".
  Warning  Failed     3m7s (x4 over 4m41s)   kubelet            Error: ErrImagePull
  Warning  Failed     2m54s (x6 over 4m41s)  kubelet            Error: ImagePullBackOff
  Normal   BackOff    2m42s (x7 over 4m41s)  kubelet            Back-off pulling image "gcr.io/google-samples/kubernetes-bootcamp:v10"
```

Therefore we should roll back to the previous stable version of our apps by using `rollout undo` subcommands.

`kubectl rollout undo deployments/kubernetes-bootcamp`

We can confirm here that the problematic pods are no more.

`kubectl get pods`

```
NAME                                   READY   STATUS    RESTARTS   AGE
kubernetes-bootcamp-7dd8b87c5c-5l2tw   1/1     Running   0          69m
kubernetes-bootcamp-7dd8b87c5c-lvzb2   1/1     Running   0          70m
```

We also can see that our pods are using the version 2 of the image.

`kubectl describe pods`

```
    .
    Image:          jocatalin/kubernetes-bootcamp:v2
    .
    .
```

### 4. Clean Up

Since it appears that our resources is no longer required, we should proceed to clean our cluster

`kubectl delete deployments/kubernetes-bootcamp services/kubernetes-bootcamp`

`kubectl get all`

```
NAME                                       READY   STATUS        RESTARTS   AGE
pod/kubernetes-bootcamp-7dd8b87c5c-5l2tw   1/1     Terminating   0          77m
pod/kubernetes-bootcamp-7dd8b87c5c-lvzb2   1/1     Terminating   0          78m

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   6d4h
```

```
    |\__/,|   (`\
  _.|o o  |_   ) )
-(((---(((--------

```

## Navigation

[`◀︎ PREVIOUS`](../day-4/README.md) ∙ [ `HOME` ](../../README.md) ∙ [`NEXT ▶︎`](../day-6/README.md)

## Reference

- [Performing a Rolling Update](https://kubernetes.io/docs/tutorials/kubernetes-basics/update/update-intro/)