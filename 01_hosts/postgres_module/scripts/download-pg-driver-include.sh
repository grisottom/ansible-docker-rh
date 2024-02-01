
function echo_message() {
  echo "--------------------------------------------------------"
  echo "=> $1"
  echo "--------------------------------------------------------"
  echo ""
}

# ---------------- DOWNLOAD POSTGRES DRIVER -------------------

#DOWNLOAD_TO_DIR defined in including shell (module-config.sh)

PG_DRV_VERSION="42.6.0"
POSTGRES_JDBC_DRIVER="postgresql-$PG_DRV_VERSION.jar"
POSTGRES_REPO="https://repo1.maven.org/maven2/org/postgresql/postgresql"

URL_POSTGRES_JAR=$POSTGRES_REPO/$PG_DRV_VERSION/postgresql-$PG_DRV_VERSION.jar

if [ -d $DOWNLOAD_TO_DIR ]; then

  if [ -f $DOWNLOAD_TO_DIR/postgresql.jar ]; then
    echo_message "Postgres JDBC Driver already downloaded to $DOWNLOAD_TO_DIR"
  else
    echo_message "Downloading Postgresql JDBC Driver to $DOWNLOAD_TO_DIR/postgresql.jar"
    echo wget -O $DOWNLOAD_TO_DIR/postgresql.jar --no-check-certificate $URL_POSTGRES_JAR
    wget -O $DOWNLOAD_TO_DIR/postgresql.jar --no-check-certificate $URL_POSTGRES_JAR

    if [ -f $DOWNLOAD_TO_DIR/postgresql.jar ]; then
      echo_message "ERROR, failed to download postgres jdbc driver"
      exit
    fi
  fi
else
  echo_message "ERROR, folder $DOWNLOAD_TO_DIR does not exists"
fi