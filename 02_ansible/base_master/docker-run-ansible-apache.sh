docker run \
  -it \
  -h master_ansible \
  -v ~/.ssh:/root/.ssh \
  -v ./ansible-apache:/ansible \
  --rm --privileged \
  --name=my_ansible_base_master \
  --network=ansible-net \
  ansible_base_master:latest \
  sh ansible-run.sh

#ansible-galaxy install -r requirements.yml && sh
#ansible-playbook -i inventory base.yml
