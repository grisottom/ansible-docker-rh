# ansible-docker-rh

Ansible development environment using docker and targeting RedHat 8 compatible containers.

## TL;DR

- key generation in host machine (bellow)

and

- run 'docker-compose up' on 01_hosts/ 
- run 'docker-compose up' on 02_ansible/ 
- run 'docker-compose up' on 03_traefik/ 

  the first creates the 'target hosts' containers,

  the second creates 'master ansible' container that installs some software on the 'target hosts',

  the third creates reverse proxy/load balancer with names 'web.localhost' and 'chess.localhost'.

### Troubleshoot

If you get the following error, close your active VPN connection.

```
✘ Network ansible-net  Error                                                                                                             0.0s 
failed to create network ansible-net: Error response from daemon: could not find an available, non-overlapping IPv4 address pool among the defaults to assign to the network
```

### Key generation in host machine 

Ansible uses ssh for connection between 'master ansible' and 'target hosts'. In order to easy that connection pubKey authentication is enabled and, using volumes, keys are shared between host machine and containers.

How to generate "id_ed25519":

> ssh-keygen -t ed25519  -C 'my host computer key'

This will create two files in 'home/user/.ssh/' in your host machine

```
    .ssh
    ├── id_ed25519
    ├── id_ed25519.pub
```

### Did it work out?

The software installed are Apache web server and deploy of javascript chess application on that server.

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

The base image is UBI8, the [new de facto container base image for Red Hat Enterprise Linux 8](https://developers.redhat.com/articles/ubi-faq).

Added to the base image we have:
- python3
- openssh-server

Added to configuration of 'ssh-server' in '/etc/ssh/sshd_config'

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
    privileged: true
    deploy:
      replicas: 2
    volumes:
      - ~/.ssh/id_ed25519.pub:/root/.ssh/authorized_keys
    command: chown root:root /root/.ssh/authorized_keys
    networks: 
      - ansible-net
```

Notice that web-host runs **privileged** which means that it run as root, running ssh-server on port 80 also can only run by the root user. 

Run as root user makes life easier for now. To run as a specific user is in the TODO list.

## Master ansible image

The image is alpine based, with added 

- ansible
- openssh-client
- git

Added to the configuration of 'ssh-client' in '/etc/ssh/ssh_config'

```
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
```

Meaning that ssh client will accept any key from any ssh server, our known hosts.

Finally the working directory is '/ansible':

```
WORKDIR /ansible
```

### docker-compose 'master ansible'

Excerpt from docker-compose.yml:

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

 Notice that the volume './base_master/ansible-apache-install' is mapped to the working directory 'ansible', allowing ansible to access any resource.

### docker run alternative

The services are also available by 'docker-run' alternatives in the same folder, ex.: docker-run-apache-install.sh

```
docker run \
  -it \
  -h master_ansible \
  -v ~/.ssh:/root/.ssh \
  -v ./ansible-apache-install:/ansible \
  --rm --privileged \
  --name=my_ansible_base_master \
  --network=ansible-net \
  ansible_base_master:latest \
  sh ansible-apache-install.sh
```

#### Ansible scripts

The ansible scripts, the main objective of this work, are available in two subfolders:

- ansible-apache-install and
- ansible-apache-deploy

Inside each folder there is a shell script with ansible commands, ex. 'ansible-apache-install.sh' 

```
ansible-galaxy install -r requirements.yml 
ansible-playbook -i inventory base.yml
```

The 'inventory' file  contains the groups of hosts

```
[web_hosts]
base-web-host-[1:2] ansible_user=root
```

The 'base.yml' file contain the Ansible tasks/roles, ex:

```
---
- hosts: web_hosts
  
  # vars_files:
  #   - vars/main.yml
  vars:
    apache_vhosts:
      - {servername: "web.localhost", documentroot: "/var/www/html/"}  
      - {servername: "chess.localhost", documentroot: "/var/www/root_chess_localhost/chess"}

  tasks:
    - name: install apache
      include_role: 
        name: geerlingguy.apache
    - name: install the latest version of rsync
      yum:
        name: rsync
        state: latest
```

Notice that we are including a community role from Ansible Galaxy called 'geerlingguy.apache' (see 'requirements.yml' file). This role does the job of installing Apache.


### docker-compose 'traefik'

You can access the web server through the IP attributed to the host, ex: 172.21.0.3, or access through a reverse proxy.

The load balancer traefik maps a two names to the web hosts, 'web.localhost' and 'chess.localhost', matching those configured on 'apache_vhosts' (above)

```
## DYNAMIC CONFIGURATION

http:
  routers:
    route-to-local-ip:
      rule: "Host(`web.localhost`,`chess.localhost`)"
      service: route-to-web-host

  services:
    route-to-web-host:
      loadBalancer:
        servers:
          - url: "http://base-web-host-1:80"
          - url: "http://base-web-host-2:80"
```          

