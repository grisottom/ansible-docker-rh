FROM registry.access.redhat.com/ubi8/ubi-init

#install common required packages
RUN ["dnf","update", "-y"]
RUN ["dnf", "install", "python3.11", "-y"]

RUN ["python3","-V"]

RUN ["dnf","install","openssh-server","-y"]
RUN ["systemctl","enable","sshd"]

#and create required directories
RUN ["mkdir","-p","/var/run/ssh"]
RUN ["mkdir","-p","/root/.ssh"]
RUN ["chmod", "0700", "/root/.ssh"]
RUN ["touch","/root/.ssh/authorized_keys"]

#RUN ln -s /run/secrets/user_ssh_key /root/.ssh/id_ed25519
#COPY ./public_ssh_key/master_id_ed25519.pub /root/.ssh/authorized_keys

RUN echo -e "PasswordAuthentication no\nPermitRootLogin yes\nPubKeyAuthentication yes\nPubkeyAcceptedKeyTypes ssh-ed25519\nUsePAM yes" >> /etc/ssh/sshd_config

ENTRYPOINT ["/sbin/init"]
#https://www.linkedin.com/pulse/hackers-guide-moving-linux-services-containers-scott-mccarty
