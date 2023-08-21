docker run \
  -it \
  -h master_ansible \
  -v ~/.ssh:/root/.ssh \
  --rm --privileged \
  --name=my_ansible_base_master \
  --network=ansible-net \
  ansible_base_master:latest \
  sh
#  ssh root@host01
#  ssh root@base-host-1