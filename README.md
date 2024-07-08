# Laravel Docker Environment

This environment includes:
- Laravel Application (PHP-FPM on Alpine)
- Nginx
- MySQL
- Random HTTP Docker Image

## Prerequisites

- EC2 Instance Amazon LInux 2023
- Docker
- Docker Compose
- Configure seguritygroup to accept 80 port

## Install


1. Docker on Amazon Linux 2023.

```sh
sudo yum update -y
sudo yum install docker
sudo service docker start
sudo usermod -a -G docker ec2-user
#Restart session 
docker info
```

2. Docker Compose on Amazon Linux 2023.

```sh
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose version
```

3. Install Git .

```sh
sudo dnf install git -y
```

4. Clone repository .

```sh
git clone https://github.com/dsierra7423/thiio.git
cd thiio
```

## Install

1. Run the Docker Compose service .

```sh
docker-compose --profile random up
```

sudo echo "127.0.0.1 devops.test" >> /etc/hosts
