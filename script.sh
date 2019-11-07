#!/bin/bash
# 0. Read Arguments
MASTER=$1

# 1. Update hosts file and elaborate hosts list
cat /vagrant/hosts >> /etc/hosts
LISTHOSTS=$(awk '{print "\""$1"\""}' /vagrant/hosts|tr "\n" ","|sed -r "s/,$//g")

# 2. Install base packages
apt-get install -y bats jq openjdk-11-jre-headless mc apt-transport-https
IP=$(ip a|grep 192.168.10|awk '{print $2}'|awk -F'/' '{print $1}')

# 3. Activate repository and install elasticsearch
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
add-apt-repository "deb https://artifacts.elastic.co/packages/7.x/apt stable main"
apt-get update
apt-get install -y elasticsearch

# 4. Configure Elasticsearch
echo "
network.host: 0.0.0.0
cluster.name: Elasticsearch_Cluster
node.name: \"$HOSTNAME\"
cluster.initial_master_nodes:
  - $MASTER
discovery.zen.ping.unicast.hosts: [$LISTHOSTS]
" >> /etc/elasticsearch/elasticsearch.yml

# 5. Enable and start Elasticsearch
systemctl enable elasticsearch.service
systemctl start elasticsearch.service
