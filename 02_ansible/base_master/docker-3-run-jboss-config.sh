ANSIBLE_LOCAL_DIR=~/.ansible_base_master/

docker run \
  -it \
  -h master_ansible \
  -v ~/.ssh/master_ssh_key_pair/:/root/.ssh/ \
  -v ./ansible-3-jboss-config:/ansible \
  -v $ANSIBLE_LOCAL_DIR:/root/.ansible/ \  
  --rm --privileged \
  --name=my_ansible_base_master \
  --network=ansible-net \
  ansible_base_master:latest \
  sh 
  #ansible-playbook.sh
  