FROM hashicorp/vault:latest

RUN apk add --no-cache --upgrade bash

ENTRYPOINT ["docker-entrypoint.sh"]

WORKDIR /work_dir

# Use the Vault user as the default user for starting this container.
USER vault

ENV VAULT_TOKEN=vault_root_token
ENV VAULT_ADDR=http://0.0.0.0:8200

ENV VAULT_DEV_ROOT_TOKEN_ID=vault_root_token
ENV VAULT_DEV_LISTEN_ADDRESS=0.0.0.0:8200

# # By default you'll get a single-node development server that stores everything
# # in RAM and bootstraps itself. Don't use this configuration for production.
#CMD ["server", "-dev"]