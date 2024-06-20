#!/bin/bash


#files needed by ansible scripts, store then locally in order to avoid repetitive downloads

#openjdk11 from corporate URL
declare -A obj0=(
    [file]="openjdk11.0.2.tgz"
    [repo]="http://v151p444.prevnet/dataprev/automacao/pacotes/java/"
    [is_repo_remote]=true
    [download_to_dir]="/tmp/ansible-tmp/downloads/java"
    [local_file_name]=''
)

#openjdk17 from Oracle
#declare -A obj0=(
#    [file]="jdk-17_linux-x64_bin.tar.gz"
#    [repo]="https://download.oracle.com/java/17/latest/"
#    [is_repo_remote]=true
#    [download_to_dir]="/tmp/ansible-tmp/downloads/java"
#    [local_file_name]=''
#)

#jboss from corporate URL
declare -A obj1=(
    [file]="jboss-eap-7.4.tar.gz"
#    [repo]="http://nfs.prj.configdtp/dataprev/linux/x86_64"
    [repo]="http://v151p444.prevnet/dataprev/linux/x86_64"
    [is_repo_remote]=true
    [download_to_dir]="/tmp/ansible-tmp/downloads/jboss"
    [local_file_name]=''
)

#jboss previous from local file
# declare -A obj1=(
#     [file]="jboss-eap-7.4.tar.gz"
#     [repo]="~/Downloads/jboss"
#     [is_repo_remote]=false
#     [download_to_dir]="/tmp/ansible-tmp/jboss"
#     [local_file_name]=''
# )

# postgres driver from maven repo
PG_DRV_VERSION="42.6.0"
POSTGRES_JDBC_DRIVER="postgresql-$PG_DRV_VERSION.jar"
POSTGRES_REPO="https://repo1.maven.org/maven2/org/postgresql/postgresql/$PG_DRV_VERSION"

declare -A obj2=(
    [file]="$POSTGRES_JDBC_DRIVER"
    [repo]="$POSTGRES_REPO"
    [is_repo_remote]=true
    [download_to_dir]="/tmp/ansible-tmp/downloads/postgresql/driver"
    [local_file_name]='postgresql.jar'
)

# official postgres RPM
#https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm

#alternative postgres RPM 
declare -A obj3=(
    [file]="pgdg-redhat-repo-latest.noarch.rpm"
    [repo]="https://ftp.unicamp.br/pub/postgresql/repos/yum/reporpms/EL-8-x86_64"
    [is_repo_remote]=true
    [download_to_dir]="/tmp/ansible-tmp/downloads/postgresql/rpm"
    [local_file_name]=''
)

# alternative postgres RPM dependency, needed only by RHEL8
declare -A obj4=(
    [file]="libicu-60.3-2.el8_1.x86_64.rpm"
    [repo]="https://ftp.unicamp.br/pub/rocky/8/BaseOS/x86_64/os/Packages/l/"
    [is_repo_remote]=true
    [download_to_dir]="/tmp/ansible-tmp/downloads/postgresql/rpm"
    [local_file_name]=''
)

# alternative postgres RPM dependency, needed only by RHEL8
declare -A obj5=(
    [file]="perl-Data-Dumper-2.167-399.el8.x86_64.rpm"
    [repo]="https://ftp.unicamp.br/pub/rocky/8/BaseOS/x86_64/os/Packages/p/"
    [is_repo_remote]=true
    [download_to_dir]="/tmp/ansible-tmp/downloads/postgresql/rpm"
    [local_file_name]=''
)

#delete previous obsolete scripted downloads
rm -Rf /tmp/ansible-tmp/jboss/downloads
rm -Rf /tmp/ansible-tmp/postgresql

declare -n obj
for obj in ${!obj@}; do
    ./get-one-file.sh ${obj[file]} ${obj[repo]} ${obj[is_repo_remote]} ${obj[download_to_dir]} ${obj[local_file_name]}
    retorno=$?
    if [ $retorno == 1 ]; then
        echo "Fail to download, aborting download loop ..."
        exit 1
    fi
done
