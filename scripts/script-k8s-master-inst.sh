#!/bin/bash
#Install Docker
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common 
sudo curl -fsSL https://get.docker.com | bash
sudo apt-get update -y

#Changing Docker Cgroup Driver
sudo mkdir /etc/docker
cat <<EOF | sudo tee /etc/docker/daemon.json
{ "exec-opts": ["native.cgroupdriver=systemd"],
"log-driver": "json-file",
"log-opts":
{ "max-size": "100m" },
"storage-driver": "overlay2"
}
EOF
sudo mkdir -p /etc/systemd/system/docker.service.d

#Reload Docker
sudo systemctl daemon-reload
sudo systemctl restart docker

#Install Kubernetes
sudo apt-get update && apt-get install -y apt-transport-https gnupg2
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" >> ~/kubernetes.list
sudo mv ~/kubernetes.list /etc/apt/sources.list.d
sudo apt update -y
sudo apt-get install -y kubelet kubeadm kubectl kubernetes-cni
sudo apt upgrade -y

#Disabling Swap Memory
sudo swapoff -a #in troubleshoot case, check with sudo nano /etc/fstab

#Setting Unique Hostnames
sudo hostnamectl set-hostname kubernetes-master
bash

#Letting Iptables See Bridged Traffic
sudo modprobe br_netfilter ip_vs_rr ip_vs_wrr ip_vs_sh nf_conntrack_ipv4 ip_vs
sudo sysctl net.bridge.bridge-nf-call-iptables=1 #verify with lsmod | grep br_netfilter

#Initializing the Kubernetes Master Node
sudo rm /etc/containerd/config.toml #this prevents preflight error of failed runtime
sudo systemctl restart containerd
sudo kubeadm config images pull
sudo kubeadm init --ignore-preflight-errors=NumCPU,Mem --pod-network-cidr=10.244.0.0/16
mkdir -p /home/ubuntu/.kube 
sudo cp -i /etc/kubernetes/admin.conf /home/ubuntu/.kube/config
sudo chown ubuntu:ubuntu /home/ubuntu/.kube/config #workaround do sudo chown $(id -u):$(id -g) /home/ubuntu/.kube/config pq o script roda no modo root

#Install net-tools
sudo apt-get install -y net-tools traceroute telnet

#Creating Docker user group
sudo newgrp docker
sudo chmod 666 /var/run/docker.sock
sudo usermod -aG docker ubuntu #workaround do sudo usermod -aG docker ${USER} pq o script roda em modo root 
exit

#Deploying a Pod Network
sudo ufw allow 6443
sudo ufw allow 6443/tcp
sudo -u ubuntu kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
sudo -u ubuntu kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml
