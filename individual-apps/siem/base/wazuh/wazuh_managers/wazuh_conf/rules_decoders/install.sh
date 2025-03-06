#!/bin/bash

apt-get update
apt-get autoremove -y 
apt-get clean
apt-get install -y git

mkdir /tmp/wazuh_rules_backup
git clone https://github.com/socfortress/Wazuh-Rules.git /tmp/Wazuh-Rules
cd /tmp/Wazuh-Rules || exit 1
find . -name '*xml' -exec mv {} /var/ossec/etc/rules/ \;
find /var/ossec/etc/rules/ -name 'decoder-linux-sysmon.xml' -exec mv {} /var/ossec/etc/decoders/ \;
find /var/ossec/etc/rules/ -name 'yara_decoders.xml' -exec mv {} /var/ossec/etc/decoders/ \;
find /var/ossec/etc/rules/ -name 'auditd_decoders.xml' -exec mv {} /var/ossec/etc/decoders/ \;
find /var/ossec/etc/rules/ -name 'naxsi-opnsense_decoders.xml' -exec mv {} /var/ossec/etc/decoders/ \;
find /var/ossec/etc/rules/ -name 'maltrail_decoders.xml' -exec mv {} /var/ossec/etc/decoders/ \;
find /var/ossec/etc/rules/ -name 'decoder-manager-logs.xml' -exec mv {} /var/ossec/etc/decoders/ \;
/var/ossec/bin/wazuh-control info 2>&1 | tee /tmp/version.txt
chown wazuh:wazuh /var/ossec/etc/rules/*
chmod 660 /var/ossec/etc/rules/*
cd /var/ossec || exit 1
rm -rf /tmp/Wazuh-Rules