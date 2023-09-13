# ansible-docker-rh

Ansible development sample using docker and targeting RedHat 8 compatible containers.

## TL;DR

- key generation in host machine (bellow)

and

- run 'docker-compose up' on 01_hosts/ 
- run 'docker-compose up' on 02_ansible/ 

  the first creates the 'target hosts' containers,

  the second creates 'master ansible' container and install software on the 'target hosts',

Ansible uses ssh for connection between 'master ansible' and 'target hosts'. 

In order to easy that connection pubKey authentication is enabled and, using volumes, keys are shared between host machine and containers.

### Key generation in host machine 

How to generate "id_ed25519":

> ssh-keygen -t ed25519  -C 'my host computer key'

This will create two files in 'home/user/.ssh/' in your host machine

```
    .ssh
    ├── id_ed25519
    ├── id_ed25519.pub
```

### Did it work out?

You can assert that apache is running by accessing "http://web.localhost". 

The 'chess' application in "http://chess.localhost". 

"Chess Game Using JavaScript" application was obtained in https://www.sourcecodester.com/javascript/14325/chess-game-using-javascript.html (Apache License), no modifications made.

## Details
---

This work is inspired mainly by two others:

- [1 - ansible-lab-docker](https://github.com/LMtx/ansible-lab-docker/tree/master)
- [2 - Running Ansible from inside Docker image for CI/CD pipeline](https://michalklempa.com/2020/05/ansible-in-docker/)

Classically the development of Ansible roles in the catalog is done in VMs on the developer's own machine, optionally with the help of Vagrant to provide standardization.
  
There are a series of difficulties in developing using VMs such as problems with host machine virtualization, host machine overload, network configurations, mount points.
  
As an alternative to using VMs, we propose the use of containers as a basis for developing Ansible roles.
  
"Containers consume much less resources making it possible to create larger test environments on your computer. The container is much faster to start/terminate than the standard virtual machine, which is important when you experiment and turn the entire environment on and off." [1]

The idea is to use containers with the aim of
- facilitate the development of Ansible roles for late use in a VM environments,
- share the work developed between DEVs and OPS in a reproducible way.

To achieve this objective, we will need to
- standardize the base image of target hosts, compatible with the VM OS,
- standardize the ansible base image, master node,
- compose environment images (docker-compose), according to the project,
- run the roles in the image inventory, according to the project.

The idea in not to run services on containers, but to develop roles through experimentation in a flexible container based environment.

## Target host image

It is the base host image, enabled to receive ansible commands. 

The base image is UBI8, the (new de facto container base image for Red Hat Enterprise Linux 8)[https://developers.redhat.com/articles/ubi-faq].

Added to the base image we have:
- python3
- openssh-server

Added configuration of 'ssh-server' to '/etc/ssh/sshd_config'

```
  PasswordAuthentication no
  PermitRootLogin yes
  PubKeyAuthentication yes
  PubkeyAcceptedKeyTypes ssh-ed25519
  UsePAM yes
```

### docker-compose 'target host'

Here a sample of 'docker-compose.yml' where image 'target_host' is constructed from: './base_host':

```
  web-host: 
    build: ./base_host
    image: target_host
    depends_on: 
      - reverse-proxy
    privileged: true
    deploy:
      replicas: 2
    volumes:
      - ~/.ssh/id_ed25519.pub:/root/.ssh/authorized_keys
    command: chown root:root /root/.ssh/authorized_keys
    networks: 
      - ansible-net
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.web_localhost.rule=Host(`web.localhost`,`chess.localhost`)"
      - "traefik.docker.network=ansible-net"
      - "traefik.http.services.web_localhost.loadbalancer.server.port=80" 
```

Notice that web-host runs **privileged** which means that it run as root, running ssh-server on port 80 also can only run by the root user. 

Run as root user make life easy for now. Run as specific user is in TODO list.

In 'labels' are configuration of traefik reverse-proxy. Later the two names 'web.localhost' and 'chess.localhost' will be configured in 'vhosts' of apache.

## Master ansible image

The image is alpine based, with added 

- ansible
- openssh-client
- git

Added to the configuration of 'ssh-client' to '/etc/ssh/ssh_config'

```
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
```

Meaning that ssh client will accept any key from any ssh server, our known hosts

Finally the working directory 

```
WORKDIR /ansible
```

## docker-compose 'master ansible'

Excerpt of docker-compose.yml, notice that the volume './base_master/ansible-apache-install' is mapped to the working directory 'ansible', allowing ansible to access any resource.

```
  apache-install:
    build: ./base_master
    image: ansible_base_master:latest
    privileged: true
    volumes:
      - ~/.ssh:/root/.ssh
      - ./base_master/ansible-apache-install:/ansible
    networks: 
      - ansible-net       
    command: ["/bin/sh","-c","./ansible-apache-install.sh"]
```

