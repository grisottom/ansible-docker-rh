function echo_message() {
  echo "--------------------------------------------------------"
  echo "=> $1"
  echo "--------------------------------------------------------"
  echo ""
}

# FORCE_NEW_TAR_GZ=$1
# if [ ! "$FORCE_NEW_TAR_GZ" == "true" ]; then
#   FORCE_NEW_TAR_GZ=false
# fi

#make pg driver avalilable to jboss as jboss module, compressed as tar.gz
TMP_DIR_DOWNLOADS="/tmp/ansible-tmp"

#previously downloaded 'postgresql.jar' driver
DRIVER_JAR=$TMP_DIR_DOWNLOADS/downloads/postgresql/driver/postgresql.jar
if [ ! -f $DRIVER_JAR ]; then
  echo_message "Postgres Driver not found in $DRIVER_JAR"
  exit 1
fi

#module to be created
TMP_MODULE_DIR=$TMP_DIR_DOWNLOADS/jboss/module-pg
TAR_GZ="modules.tar.gz"

#check if compressed module is already available
if [ ! -f $TMP_MODULE_DIR/$TAR_GZ ]; then
  rm $TMP_MODULE_DIR/$TAR_GZ
fi
  
MODULE_PG_DIR=$TMP_MODULE_DIR/modules/org/postgres/main

#create pg module folder
mkdir -p $MODULE_PG_DIR

#copy postgres module 'module.xml' configuration to $MODULE_PG_DIR
cp module.xml $MODULE_PG_DIR/

#copy previously downloaded 'postgresql.jar' driver to $MODULE_PG_DIR
cp $DRIVER_JAR $MODULE_PG_DIR/

#compress modules folder
#make module avalilable as compresed file, best option for download
cd $TMP_MODULE_DIR
tar -czvf $TAR_GZ modules