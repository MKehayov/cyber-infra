#!/bin/bash

# Updates and installs
apt-get update
apt-get upgrade -y
apt-get autoremove -y 
apt-get clean
apt-get install -y p7zip-full pgp rsync postgresql-client git

useradd -m iris

mkdir /iriswebapp/
mkdir /tmp/iriswebapp/
mkdir -p /home/iris/certificates
mkdir -p /home/iris/user_templates
mkdir -p /home/iris/server_data
mkdir -p /home/iris/server_data/backup
mkdir -p /home/iris/server_data/updates
mkdir -p /home/iris/server_data/custom_assets
mkdir -p /home/iris/server_data/datastore

git clone https://github.com/dfir-iris/iris-web.git /tmp/iriswebapp/
cd /tmp/iriswebapp/
git checkout tags/v2.3.3

cp -r source/dependencies /dependencies
cp source/requirements.txt /

python -m venv /opt/venv

cd /

pip3 install -r requirements.txt

export PATH="/opt/venv/bin:$PATH"
export PYTHONUNBUFFERED=1

cd /iriswebapp/

cp /tmp/iriswebapp/docker/webApp/iris-entrypoint.sh .
cp /tmp/iriswebapp/docker/webApp/wait-for-iriswebapp.sh .
cp -r /tmp/iriswebapp/source/* .

chmod +x /iriswebapp/dependencies/evtxdump_binaries/linux/x64/fd
chmod +x /iriswebapp/dependencies/evtxdump_binaries/linux/x64/evtx_dump

chmod +x iris-entrypoint.sh
chmod +x wait-for-iriswebapp.sh