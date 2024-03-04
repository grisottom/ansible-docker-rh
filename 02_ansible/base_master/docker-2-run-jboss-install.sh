ANSIBLE_LOCAL_DIR=~/.ansible/

docker run \
  -it \
  -h master_ansible \
  -v ~/.ssh/master_ssh_key_pair/:/root/.ssh/ \
  -v ./ansible-2-jboss-install:/ansible \
  --mount type=bind,source=$ANSIBLE_LOCAL_DIR,target=/root/.ansible/ \
  --rm --privileged \
  --name=my_ansible_base_master \
  --network=ansible-net \
  --add-host=host.docker.internal:host-gateway \
  ansible_base_master:latest \
  sh 
  #ansible-playbook.sh
  