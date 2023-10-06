#!/bin/bash

# add a master public key to authorized_keys on host in order to allow SSH connections
cat /root/.ssh/id_ed25519.pub >> /root/.ssh/authorized_keys

# start services, including SSH server
/sbin/init
#https://www.linkedin.com/pulse/hackers-guide-moving-linux-services-containers-scott-mccarty
