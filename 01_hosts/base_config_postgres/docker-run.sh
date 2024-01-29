docker run \
 -it \
 -h download_host_01 \
 -v ~/Downloads/postgres/modules:/tmp/Downloads/postgres/modules \
 -v ./scripts:/scripts \
 --name=download_host_01 \
 download_host:latest \
 sh