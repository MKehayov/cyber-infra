#!/bin/bash

apt-get update
apt-get install -y curl wget rsync
# Create dirs for Velo binaries
for i in linux mac windows; do mkdir -p /opt/velociraptor/$i; done
# Get Velox binaries
WINDOWS_EXE_LINK=https://github.com/Velocidex/velociraptor/releases/download/v0.7.1/velociraptor-v0.7.1-1-windows-amd64.exe
WINDOWS_MSI_LINK=https://github.com/Velocidex/velociraptor/releases/download/v0.7.1/velociraptor-v0.7.1-1-windows-amd64.msi
LINUX_BIN_LINK=https://github.com/Velocidex/velociraptor/releases/download/v0.7.1/velociraptor-v0.7.1-linux-amd64
MAC_BIN_LINK=https://github.com/Velocidex/velociraptor/releases/download/v0.7.1/velociraptor-v0.7.1-darwin-amd64
wget -O /opt/velociraptor/linux/velociraptor "$LINUX_BIN_LINK"
wget -O /opt/velociraptor/mac/velociraptor_client "$MAC_BIN_LINK"
wget -O /opt/velociraptor/windows/velociraptor_client.exe "$WINDOWS_EXE_LINK"
wget -O /opt/velociraptor/windows/velociraptor_client.msi "$WINDOWS_MSI_LINK"
# Clean up 
apt-get remove -y --purge curl wget
apt-get clean

set -e
BIND_ADDRESS="0.0.0.0"
PUBLIC_PATH="public"
LOG_DIR="."
DATASTORE_LOCATION="./"
FILESTORE_DIRECTORY="./"
CLIENT_DIR="/velociraptor/clients"

# Move binaries into place
mkdir -p /velociraptor
cd /velociraptor
cp /opt/velociraptor/linux/velociraptor . && chmod +x velociraptor
mkdir -p $CLIENT_DIR/linux && rsync -a /opt/velociraptor/linux/velociraptor /velociraptor/clients/linux/velociraptor_client
mkdir -p $CLIENT_DIR/mac && rsync -a /opt/velociraptor/mac/velociraptor_client /velociraptor/clients/mac/velociraptor_client
mkdir -p $CLIENT_DIR/windows && rsync -a /opt/velociraptor/windows/velociraptor_client* /velociraptor/clients/windows/

# If no existing server config, set it up
if [ ! -f server.config.yaml ]; then
	./velociraptor config generate > server.config.yaml --merge '{"Frontend":{"public_path":"'$PUBLIC_PATH'", "hostname":"'$VELOX_FRONTEND_HOSTNAME'"},"API":{"bind_address":"'$BIND_ADDRESS'"},"GUI":{"bind_address":"'$BIND_ADDRESS'"},"Monitoring":{"bind_address":"'$BIND_ADDRESS'"},"Logging":{"output_directory":"'$LOG_DIR'","separate_logs_per_component":true},"Client":{"server_urls":["'$VELOX_SERVER_URL'"],"use_self_signed_ssl":true}, "Datastore":{"location":"'$DATASTORE_LOCATION'", "filestore_directory":"'$FILESTORE_DIRECTORY'"}}'
        #sed -i "s#https://localhost:8000/#$VELOX_CLIENT_URL#" server.config.yaml
	sed -i 's#/tmp/velociraptor#.#'g server.config.yaml
	./velociraptor --config server.config.yaml user add $VELOX_USER $VELOX_PASSWORD --role $VELOX_ROLE
fi

# Re-generate client config in case server config changed
./velociraptor --config server.config.yaml config client > client.config.yaml

# Repack clients
./velociraptor config repack --exe clients/linux/velociraptor_client client.config.yaml clients/linux/velociraptor_client_repacked
./velociraptor config repack --exe clients/mac/velociraptor_client client.config.yaml clients/mac/velociraptor_client_repacked
./velociraptor config repack --exe clients/windows/velociraptor_client.exe client.config.yaml clients/windows/velociraptor_client_repacked.exe
./velociraptor config repack --msi clients/windows/velociraptor_client.msi client.config.yaml clients/windows/velociraptor_client_repacked.msi

# Create indication that the configuration is done
touch /velociraptor/finished

# Start Velocoraptor
./velociraptor --config server.config.yaml frontend -v