## Introduction
[MISP](https://www.misp-project.org/) is an open source threat intelligence platform. The project develops utilities and documentation for more effective threat intelligence, by sharing indicators of compromise.

![misp architecture](./img/cti-arch.webp)

## Directory Explanation

**base/config:** Contains shell script which starts iris installation inside the container. 

**base/iris_app:** Contains deployment scripts for the iris containers. 

**base/rabbitmq:** Contains deployment files for rabbitmq. 

**base/secrets:** Config files for secrets, in this case creds for postgres and iris itself.

**datastore:** Config files for postgresql.

## How To Run Locally

```bash
kubectl apply -k overlays/local

<SNIP>

kubectl -n misp port-forward service/misp 8081:80
```

The server should be accessible on [localhost:8081](http://localhost:8081) with the credentials **admin@admin.test : admin**.

## Requirements

| Software                         | Link                                          |
| -------------------------------- | --------------------------------------------- |
| Kubernetes                       | https://kubernetes.io/                        |
| kubectl                          | https://kubernetes.io/docs/reference/kubectl/ |
| kustomize                        | https://kustomize.io/                         |
| minikube (for local development) | https://minikube.sigs.k8s.io/                 |