docker run \
 -it \
 -h base_get_host_01 \
 --rm \
 -v /tmp/ansible-tmp:/tmp/ansible-tmp \
 -v ./scripts:/scripts \
 --name=base_get_host_01 \
 get_postgres_module:latest \
 sh 
 #module-pg.sh