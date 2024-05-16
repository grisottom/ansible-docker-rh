FROM alpine:latest
#alpine was chosen for ansible, dificult task in 'rpm' distros (ex. rhel, alma, rocky)

#install common required packages
RUN ["apk","update"]

RUN ["apk","add","--no-cache","python3"]
RUN ["apk","add","--no-cache","py3-pip"]

#https://www.redhat.com/sysadmin/python-venv-ansible
#https://docs.python.org/3/tutorial/venv.html

#Create a new Python virtual environment
ENV VIRTUAL_ENV=/tmp/ansible_base_master/
RUN ["python3","-m","venv","${VIRTUAL_ENV}"]
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
#Activate a Python virtual environment
#https://pythonspeed.com/articles/activate-virtualenv-dockerfile/

#Install Ansible in a virtual environment
RUN ["python3","-m","pip","install","ansible==9.5.1"]

#RUN ["apk","add","--no-cache","ansible"]
RUN ["apk","add","--no-cache","openssh-client"]
RUN ["apk","add","--no-cache","git"]
#RUN ["apk","add","--no-cache","jq"]

#add utilitary curl and net-tools
RUN ["apk","add","--no-cache","curl"]
RUN ["apk","add","--no-cache","net-tools"]

#Passlib is a password hashing library for Python 2 & 3, which provides cross-platform implementations of over 30 password hashing algorithms, as well as a framework for managing existing password hashes
#used by 'passwork_hash' filter in 'create-user'
RUN ["pip","install","passlib"]

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