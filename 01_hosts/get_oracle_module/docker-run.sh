docker run \
 -it \
 -h base_get_host_01 \
 --rm \
 -v /tmp/ansible-tmp:/tmp/ansible-tmp \
 -v ./scripts:/scripts \
 --name=base_get_host_01 \
 get_oracle_module:latest \
 sh 
 #module-oracle.sh