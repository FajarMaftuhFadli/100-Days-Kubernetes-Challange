# DAY 6

![Static Badge](https://img.shields.io/badge/Date-7--8--2023-f5f5f5?logo=googlecalendar&logoColor=f5f5f5)
![Static Badge](https://img.shields.io/badge/Docker-v24.0.2-2496ed?logo=docker&logoColor=2496ed)
![Static Badge](https://img.shields.io/badge/minikube-v1.30.1-326ce5?logo=kubernetes&logoColor=326ce5)
![Static Badge](https://img.shields.io/badge/Node.js-v19.9.0-339933?logo=nodedotjs&logoColor=339933)

## Containerize Node.js Google Wallet Passes Application

### 1. Initial Setup

First we must follow the guide in this [page](https://codelabs.developers.google.com/add-to-wallet-web#1) and finish the second (Setup) step. In the guide, the provisioning gcp project and service account is using _console_, but this time I use _terraform_ to provision it.

Then we clone this [repo](https://github.com/google-pay/wallet-web-codelab).

`git clone https://github.com/google-pay/wallet-web-codelab.git`

There is two main folder here `web` and `web_complete`. This time we only need the `web_complete` and delete the rest.

I made changes to the code by introducing the _dotenv_ package. Additionally, I stored the _ISSUERID_ and Service Account credential as base64 in a `.env` file and utilized the environment variable as required.

Before we test the app, we must install the dependency pacakge by `npm install .` and run `node app.js` and see if the app is working or not.

Open the url on `http://localhost:3000` and it should look like this.

![6.1](img/6.1.png)

### 2. Containerize

This is the `Dockerfile` that I use.

```dockerfile
FROM node:14
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["node", "app.js"]
```

I also need `.dockerignore` to exclude unnecessary files like `.env`, `node_modules`, etc.

We use the official node.js version 14 as the base image, install dependency package, copy the source on `/usr/src/app`, expose port 3000 where the app listening to, and run `node app.js` when the container started.

I also use docker-compose to define how to run the container.

```yaml
services:
  google-wallet-api-passes:
    image: google-wallet-api-passes
    build:
      context: .
      dockerfile: Dockerfile
    environment:
      - CREDENTIAL=${CREDENTIAL}
      - ISSUERID=${ISSUERID}
    ports:
      - '3000:3000'
```

Then we do `docker compose up -d` to start the build and run the container on the background.

## Navigation

[`◀︎ PREVIOUS`](../day-5/README.md) ∙ [ `HOME` ](../../README.md) ∙ [`NEXT ▶︎`](../day-7/README.md)

## Reference

- [Create passes on Web using the Google Wallet API](https://codelabs.developers.google.com/add-to-wallet-web)
- [Google Wallet Codelab](https://github.com/google-pay/wallet-web-codelab)
