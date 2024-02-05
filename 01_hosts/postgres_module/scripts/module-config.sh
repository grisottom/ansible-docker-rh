
TMP_DIR_DOWNLOADS="/tmp/Downloads"
JBOSS_DIR=$TMP_DIR_DOWNLOADS/jboss-eap
MODULES_DIR=$JBOSS_DIR/modules

MODULE_PG=org/postgres/main
MODULE_PG_DIR=$MODULES_DIR/$MODULE_PG

#create MODULE PG DIR
mkdir -p $MODULE_PG_DIR

#postgres module 'module.xml' configuration to $MODULE_PG_DIR
#copy path to /tmp/Downloads, docker volume
cp module.xml $MODULE_PG_DIR/

#download pg driver 'postgresql.jar' to m
DOWNLOAD_TO_DIR=$MODULE_PG_DIR
source download-pg-driver-include.sh

if [ -f $DOWNLOAD_TO_DIR/postgresql.jar ]; then
    #make moduleS avalilable as Zip file, best option for download
    cd $JBOSS_DIR
    tar -czvf modules.tar.gz modules
fi