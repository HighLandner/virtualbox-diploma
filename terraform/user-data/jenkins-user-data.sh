#!/bin/bash

pluginList=("blueocean" "pipeline-utility-steps" "workflow-cps")

apt-get update && apt-get install -y openjdk-11-jdk
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -
sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
apt-get update && apt-get install -y jenkins

while [ ! -f /var/lib/jenkins/secrets/initialAdminPassword ]; do
    echo "Secrets not found ..."
    sleep 2
done

key=$(cat /var/lib/jenkins/secrets/initialAdminPassword)
echo $key 

while [ `echo $response | grep 'Authenticated' | wc -l` = 0 ]; do
  response=`java -jar /var/cache/jenkins/war/WEB-INF/lib/cli-*.jar -s http://localhost:8080 -auth admin:$key who-am-i `
  echo $response
  echo "Jenkins not started yet, waiting for 2 seconds ..."
  sleep 2
done

for plugin in ${pluginList[@]}; do 
  java -jar /var/cache/jenkins/war/WEB-INF/lib/cli-*.jar -s http://localhost:8080 -auth admin:$key install-plugin $plugin
done

echo "Finish"
