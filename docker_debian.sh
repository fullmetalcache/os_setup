apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common;

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -;

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable";

apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose;
