FROM alpine:latest
#alpine was chosen for ansible, dificult task in 'rpm' distros (ex. rhel, alma, rocky)

#install common required packages
RUN ["apk","update"]
RUN ["apk","add","--no-cache","ansible"]
RUN ["apk","add","--no-cache","openssh-client"]
RUN ["apk","add","--no-cache","git"]

#Passlib is a password hashing library for Python 2 & 3, which provides cross-platform implementations of over 30 password hashing algorithms, as well as a framework for managing existing password hashes
RUN ["apk","add","--no-cache","py3-pip"]
RUN ["pip3","install","passlib"]

#and create required directories
RUN ["mkdir","-p","/var/run/ssh"]
RUN ["mkdir","-p","/root/.ssh"]
RUN ["chmod", "0700", "/root/.ssh"]

RUN echo -e "StrictHostKeyChecking no\nUserKnownHostsFile=/dev/null" >> /etc/ssh/ssh_config

WORKDIR /ansible
