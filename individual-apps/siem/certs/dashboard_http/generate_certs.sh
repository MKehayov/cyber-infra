#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $DIR
cd ../../base/wazuh/certs/dashboard_http

openssl req -x509 -batch -nodes -days 365 -newkey rsa:2048 -keyout key.pem -out cert.pem

cp cert.pem ../../../grafana/certs
cp key.pem ../../../grafana/certs