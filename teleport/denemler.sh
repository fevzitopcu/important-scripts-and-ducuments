sudo teleport configure -o file \
    --acme --acme-email=user@magicorn.co \
    --cluster-name=qdelivery.magicorn.org



tsh login --proxy=teleport.magicorn.org --user=teleport-admin
tsh clusters
tsh ssh --cluster=qdelivery.magicorn.org visitor@qdelivery-magicorn-org

tsh login --proxy=gateway.magicorn.net --user=fevzi

ssh tunnel

$ ssh -i ./qd-teleport.pem -f -N -L 3306:coredb.cluster-ro-cyfpkacdgbkz.us-east-1.rds.amazonaws.com:3306 ubuntu@44.221.29.116 -v

'''
SSH bağlantılarını yapılandırmak için ~/.ssh/config dosyasını kullanabilirsiniz. Bu dosya, özelleştirilmiş SSH bağlantı ayarlarını tanımlamanıza olanak sağlar.

'''

Host rds-tunnel
    HostName 44.221.29.116
    User ubuntu
    IdentityFile ./qd-teleport.pem
    LocalForward 3306 coredb-1.cyfpkacdgbkz.us-east-1.rds.amazonaws.com:3306


Bu yapılandırma, rds-tunnel adında bir host tanımlar. Bu tanımlama, SSH bağlantısı yaparken bu ismi kullanmanızı sağlar. HostName belirtilen IP adresine bağlanır. User belirtilen kullanıcı adını kullanır ve IdentityFile belirtilen özel anahtar dosyasını kullanır. LocalForward ise yerel port 3306'yı RDS'e yönlendirir.

Artık aşağıdaki gibi bağlanabilirsiniz:

$ ssh -f -N rds-tunnel -v
$ ssh -f -N bastion-vpn -v


Bağlantıyı sonlandırmak için aşağıdaki adımları izleyebilirsiniz:

ps aux | grep ssh
kill <PID>




aws eks update-kubeconfig --region us-east-1 --profile qdelivery --name teleport-magicorn-eks-cluster-dev

CREATE USER fevzi IDENTIFIED WITH AWSAuthenticationPlugin AS 'RDS';


GRANT ALL ON `%`.* TO 'fevzi'@'%';


sudo teleport db configure create \
   --token=5db70083afc491476bc4e5204f618408 \
   --ca-pin=sha256:66382f4224804992390b4931ea9ae56985ff6237743a21a95297ba48cc1a3bfc \
   --proxy=qdelivery.magicorn.org:443 \
   --name=coredb \
   --protocol=mysql \
   --uri=coredb.cluster-cyfpkacdgbkz.us-east-1.rds.amazonaws.com:3306 \
   --output file:///etc/teleport.yaml

   teleport db configure bootstrap -c /etc/teleport.yaml --attach-to-role teleport-qd-magicorn-rds-role 
   
CREATE USER admin;
GRANT rds_iam TO admin;