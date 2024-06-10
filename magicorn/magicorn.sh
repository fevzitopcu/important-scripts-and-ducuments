saml2aws login -a upujamlog
saml2aws login -a petrolig
saml2aws login -a qdelivery

aws eks update-kubeconfig --region us-east-1 --profile qdelivery --name teleport-magicorn-eks-cluster-dev

aws eks --region us-east-1 update-kubeconfig --name teleport-magicorn-eks-cluster-dev


#Yerel Bilgisayardan Bastion Host Üzerinden EKS Cluster'a Erişim (Opsiyonel)
ssh -i /path/to/your/private-key.pem -L 8001:<eks-api-endpoint>:443 ubuntu@<bastion-host-ip> -N


#remote dosya kopyalama
$ scp -i /path/to/your/private-key.pem -r ~/.aws ec2-user@bastion_host:/home/ec2-user
$ scp -i ./qd-teleport.pem -r ~/.aws ubuntu@44.223.189.92:/home/ubuntu

#bastion üstünden eks cluster bağlantısı
aws eks update-kubeconfig --region us-east-1 --profile magicorn --name education-eks-I1MGwHUN

tsh login --proxy=teleport.magicorn.org:443 --auth=local --user=teleport-admin
tctl tokens add --type=trusted_cluster --ttl=25m

tctl get trusted_cluster/teleport.magicorn.org > trusted_cluster.yaml

tsh login --proxy=qdelivery.magicorn.org:443 --auth=local --user=teleport-qd
tsh login --proxy=gateway.magicorn.net:443 --auth=local --user=fevzi