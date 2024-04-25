FROM alpine:latest
#alpine was chosen for ansible, dificult task in 'rpm' distros (ex. rhel, alma, rocky)

#install common required packages
RUN ["apk","update"]
RUN ["apk","add","--no-cache","ansible"]
RUN ["apk","add","--no-cache","openssh-client"]
RUN ["apk","add","--no-cache","git"]
#RUN ["apk","add","--no-cache","jq"]

#add utilitary curl and net-tools
RUN ["apk","add","--no-cache","curl"]
RUN ["apk","add","--no-cache","net-tools"]

#Passlib is a password hashing library for Python 2 & 3, which provides cross-platform implementations of over 30 password hashing algorithms, as well as a framework for managing existing password hashes
RUN ["apk","add","--no-cache","py3-pip"]
RUN ["pip3","install","passlib"]

#and create required directories
RUN ["mkdir","-p","/var/run/ssh"]
RUN ["mkdir","-p","/root/.ssh"]
RUN ["chmod", "0700", "/root/.ssh"]

#echo -e     enable interpretation of backslash escapes
RUN echo -e "StrictHostKeyChecking no\nUserKnownHostsFile=/dev/null" >> /etc/ssh/ssh_config

WORKDIR /ansible

#add hvac (python library) needed by hashi_vault
RUN ["pip","install","hvac"]

#ENV var, vault token and addres used for lookup
ENV VAULT_TOKEN=vault_root_token
ENV VAULT_ADDR=http://vault.local:8200