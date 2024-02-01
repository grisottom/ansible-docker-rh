FROM alpine:latest
#alpine was chosen for ansible, dificult task in 'rpm' distros (ex. rhel, alma, rocky)

#install common required packages
RUN ["apk","update"]
RUN ["apk","add","--no-cache","wget"]

WORKDIR /scripts
