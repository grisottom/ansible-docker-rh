
TMP_DIR_DOWNLOADS="/tmp/Downloads"
MODULES_DIR=$TMP_DIR_DOWNLOADS/jboss-eap/modules

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