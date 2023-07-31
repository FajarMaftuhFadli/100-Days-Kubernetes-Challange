# DAY 2

![Static Badge](https://img.shields.io/badge/Date-31--7--2023-blue?logo=googlecalendar&logoColor=f5f5f5)

## Deploy and app

### 1. Deploy and app

To deploy an app to our cluster, we must create a **Kubernetes Deployment**. In this command, I use the Nginx app sample image stored in Google Cloud Container Registry (GCR).

`kubectl create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1`

> A Deployment is responsible for creating and updating instances of your application

Run this command to see our deployment.

`kubectl get deployments`

output:
```
NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
kubernetes-bootcamp   1/1     1            1           30m
```

We can also see our pods are ready.

`kubectl get pods`

output:
```
NAME                                   READY   STATUS    RESTARTS   AGE
kubernetes-bootcamp-5485cc6795-vckkb   1/1     Running   0          5m15s
```

### 2. View the app

Basically, when we use kubectl command, we are interacting through Kubernetes API.

But we can expose that API by using a proxy.

`kubectl proxy`

Then we can access that API from the local network on port 8001. 

Output the Kubernetes API version.

`curl http://localhost:8001/version`

output:
```
{
  "major": "1",
  "minor": "26",
  "gitVersion": "v1.26.3",
  "gitCommit": "9e644106593f3f4aa98f8a84b23db5fa378900bd",
  "gitTreeState": "clean",
  "buildDate": "2023-03-15T13:33:12Z",
  "goVersion": "go1.19.7",
  "compiler": "gc",
  "platform": "linux/arm64"
}%
```

Save the pod name that we created before into the environment variable so that we can reference it in another command later.

`export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')`

`echo Name of the Pod: $POD_NAME`

In here we try to fetch the pod info:

`curl http://localhost:8001/api/v1/namespaces/default/pods/$POD_NAME/`

output:
```
{
  "kind": "Pod",
  "apiVersion": "v1",
  "metadata": {
    .
    .
    .
  }
}
```