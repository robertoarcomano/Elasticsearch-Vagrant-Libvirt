#!/bin/bash

# env TZ=Europe/Dublin
# ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install packages
# apt install -y openjdk-11-jre-headless mc
# JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64

# USER=elastic
# useradd -ms /bin/bash $USER
# echo "export JAVA_HOME=$JAVA_HOME" >> /home/elastic/.profile

# 1. Install base packages
apt-get install -y bats jq openjdk-11-jre-headless mc apt-transport-https

# 2. Activate repository and install elasticsearch
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
add-apt-repository "deb https://artifacts.elastic.co/packages/7.x/apt stable main"
apt-get update
apt-get install -y elasticsearch

# 3. Configure Elasticsearch
echo "
network.host: 0.0.0.0
cluster.name: myCluster1
node.name: \"myNode1\"
cluster.initial_master_nodes:
  - myNode1
" >> /etc/elasticsearch/elasticsearch.yml

# 4. Enable and start Elasticsearch
systemctl enable elasticsearch.service
systemctl start elasticsearch.service

# 5. Launch Unit Test
/vagrant/testElasticsearch.sh
