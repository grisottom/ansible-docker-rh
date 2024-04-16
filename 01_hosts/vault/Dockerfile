FROM hashicorp/vault:latest

RUN apk add --no-cache --upgrade bash

ENTRYPOINT ["docker-entrypoint.sh"]

WORKDIR /work_dir

# Use the Vault user as the default user for starting this container.
USER vault

# # By default you'll get a single-node development server that stores everything
# # in RAM and bootstraps itself. Don't use this configuration for production.
#CMD ["server", "-dev"]