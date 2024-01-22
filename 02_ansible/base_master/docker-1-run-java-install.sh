ANSIBLE_LOCAL_DIR=~/.ansible/

docker run \
  -it \
  -h master_ansible \
  -v ~/.ssh/master_ssh_key_pair/:/root/.ssh/ \
  -v ./ansible-1-java-install:/ansible \
  --mount type=bind,source=$ANSIBLE_LOCAL_DIR,target=/root/.ansible/ \
  --rm --privileged \
  --name=my_ansible_base_master \
  --network=ansible-net \
  ansible_base_master:latest \
  sh ansible-playbook.sh

