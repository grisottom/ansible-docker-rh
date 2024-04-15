FROM hashicorp/vault:latest

#WORKDIR /work_dir

ENTRYPOINT ["docker-entrypoint.sh"]

# Use the Vault user as the default user for starting this container.
USER vault

# # By default you'll get a single-node development server that stores everything
# # in RAM and bootstraps itself. Don't use this configuration for production.
CMD ["server", "-dev"]

#run run.sh, after container start.
#CMD ["/bin/sh","/work_dir/run.sh"]

#CMD ["/bin/sh"]