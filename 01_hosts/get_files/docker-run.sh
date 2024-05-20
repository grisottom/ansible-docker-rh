docker run \
 -it \
 -h base_get_host_01 \
 --rm \
 -v /tmp/ansible-tmp:/tmp/ansible-tmp \
 -v ./scripts:/scripts \
 --name=base_get_host_01 \
 base_get:latest \
 bash
 # module-pg.sh