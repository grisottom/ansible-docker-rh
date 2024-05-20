docker run \
  -it \
  -h master_ansible \
  -v /tmp/.ansible-tmp/master_ssh_key_pair/:/root/.ssh/ \
  -v ./ansible-ping:/workdir \
  --rm --privileged \
  --name=my_ansible_base_master \
  --network=ansible-net \
  ansible_base_master:latest \
  sh 
  #ansible-playbook.sh
  #ansible-playbook -i inventory ping_all.yml
