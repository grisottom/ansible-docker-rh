ANSIBLE_LOCAL_DIR=~/.ansible_base_master/

docker run \
  -it \
  -h master_ansible \
  -v /tmp/.ansible-tmp/master_ssh_key_pair/:/root/.ssh/ \
  -v /tmp/.ansible-tmp/:/root/.ansible/ \
  -v ./ansible-2-jboss-install:/workdir \
  --rm --privileged \
  --name=my_ansible_base_master \
  --network=ansible-net \
  --add-host=host.docker.internal:host-gateway \
  ansible_base_master:latest \
  sh 
  #ansible-playbook.sh
  