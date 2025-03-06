## Introduction
Benefit from SIEM, CTI, SOAR, and Incident Response software all in one place.

The SIEM module of the CYBER platform consists of the open-source [Wazuh](https://wazuh.com/), [Graylog](https://graylog.org/), [Grafana](https://grafana.com/) and [ElastAlert](https://elastalert.readthedocs.io/) with UI [Praeco](https://github.com/johnsusek/praeco)

The cyber threat intelligence solution is [MISP](https://www.misp-project.org/).

The SOAR is [Shuffle](https://shuffler.io/).

And the Incident Response module is a combination of [Velociraptor](https://docs.velociraptor.app/) and [IRIS](https://dfir-iris.org/)

![platform architecture](./img/cyber-arch.webp)

## Directory Explanation

**individual-apps:** Directory where each of the applications can be deployed individually

**certs:** Storage for certificates.

**secrets:** Config files for secrets, in this case all the secrets needed for the wazuh software to work, dashboard creads, wazuh-indexer creds, authentication creds, for more information please consult the wazuh documentation.

**wazuh_managers:** Deployment files for the wazuh master and worker nodes with configuration files for some additional agent rules defined in the agent_groups folder, list of common ports that are "good", and some additonal advanced custom rule decoders for better detection.

**wazuh-dashboard:** Deployment files for the wazuh dashboard, which is a modified version of kibana.

## How To Run Locally

```bash
./certs/indexer_cluster/generate_certs.sh

<SNIP>

./certs/dashboard_http/generate_certs.sh

<SNIP>

kubectl apply -k overlays/local

<SNIP>

kubectl -n graylog port-forward service/graylog 9000:9000

<SNIP>

kubectl -n grafana port-forward service/dashboard 3000:443

<SNIP>

kubectl -n wazuh port-forward service/dashboard 8443:443

<SNIP>

kubectl -n elastalert port-forward service/praeco 8080:8080

<SNIP>

kubectl -n velociraptor port-forward service/velociraptor 8889:8889

<SNIP>

kubectl -n shuffle port-forward service/shuffle-frontend 8000:80

<SNIP>

kubectl -n misp port-forward service/misp 8081:80

<SNIP>

kubectl -n iris port-forward service/iris-app 8001:8000
```

The servers should be accessible on:

| Software      | Link                   | Credentials              |
| ------------- | ---------------------- | ------------------------ |
| Graylog       | http://localhost:9000  |       admin : admin      |
| Grafana       | https://localhost:3000 |   created on 1st login   |
| Wazuh         | https://localhost:8443 |  admin : SecretPassword  |
| Praeco        | http://localhost:8080  |             -            |
| Velociraptor  | https://localhost:8889 |       admin : admin      |
| Shuffle       | https://localhost:8000 |   created on 1st login   |
| MISP          | http://localhost:8081  | admin@admin.test : admin |
| IRIS          | http://localhost:8001  |      See IRIS README     |

## Requirements

| Software                         | Link                                          |
| -------------------------------- | --------------------------------------------- |
| Kubernetes                       | https://kubernetes.io/                        |
| kubectl                          | https://kubernetes.io/docs/reference/kubectl/ |
| kustomize                        | https://kustomize.io/                         |
| minikube (for local development) | https://minikube.sigs.k8s.io/                 |