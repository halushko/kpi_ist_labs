# In the windows terminal:
## Run WSL
1. wsl --set-default Ubuntu
2. wsl
3. sudo apt-get update
4. sudo apt-get upgrade

## Install docker in WSL
1. sudo apt install apt-transport-https ca-certificates curl software-properties-common
2. curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
3. sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
4. sudo apt update
5. apt-cache policy docker-ce
6. sudo apt install docker-ce
7. sudo systemctl status docker (OR service docker status)

# In the JetBrains:
## Docker >> Tools 
1. \\wsl$\Ubuntu\usr\bin\docker
2. \\wsl$\Ubuntu\usr\bin\docker-compose

## Service configuration: 
1. WSL: Ubuntu