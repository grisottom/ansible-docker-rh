docker run \
 -it \
 -h host01 \
 -v ~/.ssh/master_ssh_key_pair/id_ed25519.pub:/root/.ssh/authorized_keys \
 --rm --privileged \
 --name=my_target_host \
 --network=ansible-net \
 ansible_base_host:latest