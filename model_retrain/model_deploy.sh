#!/bin/bash

if [[ -z $1 ]]; then
	echo "No version is given !!!"
	exit
fi

version=$1
mkdir -p $HOME/DL-Pipeline-Tutorial/tf-serving/x_test
cp -r $HOME/DL-Pipeline-Tutorial/saved_model/x_test/$version $HOME/DL-Pipeline-Tutorial/tf-serving/x_test/$version
sed -i "s/rest_api_port=850[0-9]/rest_api_port=850$version/" $HOME/DL-Pipeline-Tutorial/tf-serving/Dockerfile
docker build $HOME/DL-Pipeline-Tutorial/tf-serving -t cwhuang29/tf-serving:v$version
docker push cwhuang29/tf-serving:v$version

# tfserving.yml -> tfserving_v#.yml
cp $HOME/DL-Pipeline-Tutorial/keadm-v1.4.0-linux-amd64/keadm/tfserving.yml $HOME/DL-Pipeline-Tutorial/keadm-v1.4.0-linux-amd64/keadm/tfserving_v$version.yml
# metadata.name
sed -i "s/tfserving-deployment.*/tfserving-deployment-v$version/" $HOME/DL-Pipeline-Tutorial/keadm-v1.4.0-linux-amd64/keadm/tfserving_v$version.yml
# spec.template.spec.containers.image
sed -i "s/tf-serving:v[0-9]\+/tf-serving:v$version/" $HOME/DL-Pipeline-Tutorial/keadm-v1.4.0-linux-amd64/keadm/tfserving_v$version.yml
# spec.template.spec.containers.ports.containerPort
sed -i "s/containerPort: 850[0-9]\+/containerPort: 850$version/" $HOME/DL-Pipeline-Tutorial/keadm-v1.4.0-linux-amd64/keadm/tfserving_v$version.yml
# spec.template.spec.containers.ports.hostPort
sed -i "s/hostPort: 850[0-9]\+/hostPort: 850$version/" $HOME/DL-Pipeline-Tutorial/keadm-v1.4.0-linux-amd64/keadm/tfserving_v$version.yml
kubectl apply -f $HOME/DL-Pipeline-Tutorial/keadm-v1.4.0-linux-amd64/keadm/tfserving_v$version.yml
#if [[ -z ~/keadm-v1.4.0-linux-amd64/keadm/tfserving_v$version.yml ]]; then
#        echo "File not found !!!!!!!!!!!!";
#fi
