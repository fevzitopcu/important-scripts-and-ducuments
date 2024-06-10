#!/bin/bash

docker stop teleport
docker rm -f teleport

sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install jq -y

sudo snap install docker

sudo groupadd docker 
sudo usermod -aG docker $USER 
newgrp docker
sudo reboot

mkdir -p ~/teleport/config ~/teleport/data

docker run --hostname teleport --rm \
--entrypoint=/usr/local/bin/teleport \
public.ecr.aws/gravitational/teleport-distroless-debug:15.3.0 configure --roles=proxy,auth --acme --acme-email=admin@magicorn.org  --cluster-name=teleport.magicorn.org  > ~/teleport/config/teleport.yaml


docker run --hostname teleport --name teleport \
--restart unless-stopped \
-v ~/teleport/config:/etc/teleport \
-v ~/teleport/data:/var/lib/teleport \
-p 443:443 -p 3023:3023 -p 3024:3024 -p 3025:3025 \
-d public.ecr.aws/gravitational/teleport-distroless-debug:15.3.0

docker logs -f teleport

docker exec -it 35af5f8c69df tctl users add teleport-admin --roles=editor,access --logins=root,ubuntu
docker exec -it 35af5f8c69df tctl users rm teleport-admin