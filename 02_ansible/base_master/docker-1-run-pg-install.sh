ANSIBLE_LOCAL_DIR=/tmp/ansible/

docker run \
  -it \
  -h master_ansible \
  -v ~/.ssh/master_ssh_key_pair/:/root/.ssh/ \
  -v ./ansible-1-pg-install:/ansible \
  -v $ANSIBLE_LOCAL_DIR:/root/.ansible/ \
  --rm --privileged \
  --name=my_ansible_base_master \
  --network=ansible-net \
  --add-host=host.docker.internal:host-gateway \
  ansible_base_master:latest \
  sh 
  #--mount type=volume,source=$ANSIBLE_LOCAL_DIR,target=/tmp/.ansible_base_master/ \
  # ansible-playbook.sh
  