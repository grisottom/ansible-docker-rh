#!/bin/bash

#files needed by ansible scripts, store then locally in order to avoid repetitive downloads

#jboss from corporate URL
declare -A obj0=(
    [file]="jboss-eap-7.4.tar.gz"
    [repo]="http://nfs.prj.configdtp/dataprev/linux/x86_64"
    [is_repo_remote]=true
    [download_to_dir]="/tmp/ansible-tmp/jboss/downloads"
    [local_file_name]=''
)

#jboss previous from local file
# declare -A obj0=(
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

declare -A obj1=(
    [file]="$POSTGRES_JDBC_DRIVER"
    [repo]="$POSTGRES_REPO"
    [is_repo_remote]=true
    [download_to_dir]="/tmp/ansible-tmp/postgresql/driver"
    [local_file_name]='postgresql.jar'
)

# official postgres RPM
#https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm

#alternative postgres RPM 
declare -A obj2=(
    [file]="pgdg-redhat-repo-latest.noarch.rpm"
    [repo]="https://ftp.unicamp.br/pub/postgresql/repos/yum/reporpms/EL-8-x86_64"
    [is_repo_remote]=true
    [download_to_dir]="/tmp/ansible-tmp/postgresql/rpm"
    [local_file_name]=''
)

# alternative postgres RPM dependency, needed only by RHEL8
declare -A obj3=(
    [file]="libicu-60.3-2.el8_1.x86_64.rpm"
    [repo]="https://ftp.unicamp.br/pub/rocky/8/BaseOS/x86_64/os/Packages/l/"
    [is_repo_remote]=true
    [download_to_dir]="/tmp/ansible-tmp/postgresql/rpm"
    [local_file_name]=''
)

# alternative postgres RPM dependency, needed only by RHEL8
declare -A obj4=(
    [file]="perl-Data-Dumper-2.167-399.el8.x86_64.rpm"
    [repo]="https://ftp.unicamp.br/pub/rocky/8/BaseOS/x86_64/os/Packages/p/"
    [is_repo_remote]=true
    [download_to_dir]="/tmp/ansible-tmp/postgresql/rpm"
    [local_file_name]=''
)

declare -n obj
for obj in ${!obj@}; do
    ./get-one-file.sh ${obj[file]} ${obj[repo]} ${obj[is_repo_remote]} ${obj[download_to_dir]} ${obj[local_file_name]}
done