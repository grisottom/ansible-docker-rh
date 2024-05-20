ANSIBLE_LOCAL_DIR=~/.ansible_base_master/

docker run \
  -it \
  -h master_ansible \
  -v /tmp/.ansible-tmp/master_ssh_key_pair/:/root/.ssh/ \
  -v /tmp/.ansible-tmp/:/root/.ansible/ \
  -v ./ansible-3-jboss-config:/workdir \
  --rm --privileged \
  --name=my_ansible_base_master \
  --network=ansible-net \
  ansible_base_master:latest \
  sh 
  #ansible-playbook.sh
  