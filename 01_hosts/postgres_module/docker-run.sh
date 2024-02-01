docker run \
 -it \
 -h base_get_host_01 \
 --rm \
 -v ~/tmp/Downloads:/tmp/Downloads \
 -v ./scripts:/scripts \
 --name=base_get_host_01 \
 base_get:latest \
 sh module-config.sh