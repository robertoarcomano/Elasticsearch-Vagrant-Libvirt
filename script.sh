#!/bin/bash
env TZ=Europe/Dublin
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install packages
apt update
apt install -y openjdk-11-jre-headless mc
JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64

USER=elastic
useradd -ms /bin/bash $USER
echo "export JAVA_HOME=$JAVA_HOME" >> /home/elastic/.profile

apt-get install apt-transport-https
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
add-apt-repository "deb https://artifacts.elastic.co/packages/7.x/apt stable main"
apt-get update
apt-get install elasticsearch

echo "
network.host: 0.0.0.0
cluster.name: myCluster1
node.name: \"myNode1\"
cluster.initial_master_nodes:
  - myNode1
" >> /etc/elasticsearch/elasticsearch.yml

systemctl enable elasticsearch.service
systemctl start elasticsearch.service

# Test
curl -X GET "http://localhost:9200/?pretty"
