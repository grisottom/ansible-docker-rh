FROM registry.access.redhat.com/ubi8/ubi-init
# 2024-02, ubu-init:8.2 a 8.9 bug 'https://issues.redhat.com/browse/RHEL-5863', 'systemd-239-31 prevents some units from stopping'

#install common packages, required by Ansible
RUN ["dnf","update", "-y"]
RUN ["dnf", "install", "python3.11", "-y"]
# ubi8 image, sudo not present, needed by ansible 
RUN ["dnf", "install", "sudo", "-y"] 

# install utilitary net-tools (netstat), ncat (telnet substitute), iputils (ping)
RUN ["dnf", "install", "net-tools", "-y"] 
RUN ["dnf", "install", "nmap", "-y"] 
RUN ["dnf", "install", "nmap-ncat", "-y"] 
RUN ["dnf", "install", "iputils", "-y"] 

RUN ["python3","-V"]

RUN ["dnf","install","openssh-server","-y"]
RUN ["systemctl","enable","sshd"]

#and create Ansible required directories for ssh connection
RUN ["mkdir","-p","/var/run/ssh"]
RUN ["mkdir","-p","/root/.ssh"]
RUN ["chmod", "0700", "/root/.ssh"]
RUN ["touch","/root/.ssh/authorized_keys"]

#Accept root login, pubkey authentication
RUN echo -e "PasswordAuthentication no\nPermitRootLogin yes\nPubKeyAuthentication yes\nPubkeyAcceptedKeyTypes ssh-ed25519\nUsePAM yes" >> /etc/ssh/sshd_config

#root folder for default app instalation, /u01
RUN ["mkdir","-p","/u01"]
#usually /u01 is a separated mount

#Red Hat Enterprise Linux 9 does not have the initscripts package in the default build. This package includes the /etc/init.d/functions file used by the jboss-eap-rhel.sh service. The /etc/init.d/functions file is required to start JBoss EAP as a service; therefore, install the initscripts package using the following command:
#https://access.redhat.com/documentation/pt-br/red_hat_jboss_enterprise_application_platform/7.4/html-single/installation_guide/index#configuring-jboss-eap-archive-installation-as-a-service-on-rhel_default
RUN ["dnf", "install", "initscripts", "-y"] 

ENTRYPOINT ["/sbin/init"]
#https://www.linkedin.com/pulse/hackers-guide-moving-linux-services-containers-scott-mccarty
