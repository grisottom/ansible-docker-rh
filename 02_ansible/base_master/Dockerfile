FROM alpine:latest
#alpine was chosen for ansible, dificult task in 'rpm' distros (ex. rhel, alma, rocky)

#install common required packages
RUN ["apk","update"]
RUN ["apk","add","--no-cache","ansible"]
RUN ["apk","add","--no-cache","openssh-client"]
RUN ["apk","add","--no-cache","git"]

#and create required directories
RUN ["mkdir","-p","/var/run/ssh"]
RUN ["mkdir","-p","/root/.ssh"]
RUN ["chmod", "0700", "/root/.ssh"]

#COPY ./private_ssh_key/master_id_ed25519 /root/.ssh/id_ed25519
RUN echo -e "StrictHostKeyChecking no\nUserKnownHostsFile=/dev/null" >> /etc/ssh/ssh_config

WORKDIR /ansible
