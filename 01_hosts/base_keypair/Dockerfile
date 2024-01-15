FROM alpine:latest

#install common required packages
RUN ["apk","add","--no-cache","openssh-keygen"]

WORKDIR /work_dir

#creates ssh_key_pair owned by 'root', because docker run as root
RUN ["mkdir","-p","image_key_pair"]
RUN ssh-keygen -t ed25519 -f image_key_pair/id_ed25519 -q -N '' -C 'ssh ansible_docker key' 

#creates script to copy 'ssh key pair' from image_key_pair/ to shared_key_pair/
RUN echo "cp image_key_pair/* shared_key_pair/" > run.sh
RUN ["chmod","755","run.sh"]

RUN ["mkdir","-p","shared_key_pair"]

#run run.sh, at start of container.
ENTRYPOINT ["/bin/sh","/work_dir/run.sh"]

#shared_key_pair/ is be mapped to volume on host, see docker-compose.yml
#    volumes:
#      - ~/.ssh/master_ssh_key_pair/:/work_dir/shared_key_pair/

#this indirection of copying the key to a shared folder after the container is started exists
#because, with volumes, the host content overrides the container container when container starts (left -> right)
