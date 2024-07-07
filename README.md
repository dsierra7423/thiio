# Laravel Docker Environment

This environment includes:
- Laravel Application (PHP-FPM on Alpine)
- Nginx
- MySQL
- Random HTTP Docker Image

## Prerequisites

- Docker
- Docker Compose

## Setup

1. Clone the repository.

```sh
git clone <repository_url>
cd <repository_directory>



# INSTALL DOCKER
sudo yum update -y
sudo yum install docker
sudo service docker start
sudo usermod -a -G docker ec2-user
#Restart session 
docker info

# INSTALL DOCKER-COMPOSE
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose version


# INSTALL GIT
sudo dnf install git -y