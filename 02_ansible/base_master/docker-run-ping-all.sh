docker run \
  -it \
  -h master_ansible \
  -v /tmp/.ansible-tmp/master_ssh_key_pair/:/root/.ssh/ \
  -v ./ansible-ping:/ansible \
  --rm --privileged \
  --name=my_ansible_base_master \
  --network=ansible-net \
  ansible_base_master:latest \
  ansible-playbook -i inventory ping_all.yml
