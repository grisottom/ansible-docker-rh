
docker run \
 -it \
 -h base_vault01 \
 --name base_vault \
 --rm \
 --cap-add=IPC_LOCK \
 -e 'VAULT_DEV_ROOT_TOKEN_ID=vault_root_token' \
 -e 'VAULT_DEV_LISTEN_ADDRESS=0.0.0.0:8200' \
 -e 'VAULT_ADDR=http://0.0.0.0:8200' \
 -e 'VAULT_TOKEN=vault_root_token' \
 -v ./config:/work_dir \
 -p 8200:8200 \
hashicorp/vault:latest \
sh 