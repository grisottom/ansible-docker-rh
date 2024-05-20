ANSIBLE_LOCAL_DIR=/tmp/ansible/

docker run \
  -it \
  -h master_ansible \
  -v /tmp/.ansible-tmp/master_ssh_key_pair/:/root/.ssh/ \
  -v /tmp/.ansible-tmp/:/root/.ansible/ \
  -v ./ansible-1-pg-install:/workdir \
  --rm --privileged \
  --name=my_ansible_base_master \
  --network=ansible-net \
  --add-host=host.docker.internal:host-gateway \
  ansible_base_master:latest \
  sh 
  #--mount type=volume,source=/tmp/.ansible-tmp/,target=/tmp/.ansible_base_master/ \
  # ansible-playbook.sh
  