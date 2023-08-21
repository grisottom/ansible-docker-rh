docker run \
 -it \
 -h host01 \
 -v ~/.ssh/id_ed25519.pub:/root/.ssh/authorized_keys \
 --rm --privileged \
 --name=my_ansible_base_host \
 --network=ansible-net \
 ansible_base_host:latest