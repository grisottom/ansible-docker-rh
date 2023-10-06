docker run \
 -it \
 -h key_pair01 \
 --rm \
 --name=my_keypair \
 -v ~/.ssh/master_ssh_key_pair/:/work_dir/shared_key_pair/ \
 key_pair:latest
 # The root-owned 'key pair' from the image is copied to the container's /work_dir/shared_key_pair and made available across the volume to the host