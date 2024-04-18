
docker run \
 -it \
 -h base_vault02 \
 --name base_vault2 \
 --rm \
 --cap-add=IPC_LOCK \
 -v ./config:/work_dir \
 -p 8202:8200 \
base_vault:latest \
./run.sh
#hashicorp/vault:latest \
#sh

#  -v ~/.vault/.profile./:/work_dir/.profile.d