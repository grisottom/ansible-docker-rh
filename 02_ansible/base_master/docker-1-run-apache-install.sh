docker run \
  -it \
  -h master_ansible \
  -v ~/.ssh/master_ssh_key_pair/:/root/.ssh/ \
  -v ./ansible-1-apache-install:/ansible \
  --rm --privileged \
  --name=my_ansible_base_master \
  --network=ansible-net \
  ansible_base_master:latest \
  sh 
  #ansible-playbook.sh
  