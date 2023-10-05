docker run \
  -it \
  -h master_ansible \
  -v ~/.ssh/master_ssh_key_pair/:/root/.ssh/ \
  --rm --privileged \
  --name=my_ansible_base_master \
  --network=ansible-net \
  ansible_base_master:latest \
  ansible all  --user root -i 'base-web-host-1,' -m ping  
