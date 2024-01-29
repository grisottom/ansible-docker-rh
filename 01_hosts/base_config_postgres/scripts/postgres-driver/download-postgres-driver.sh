
function echo_message() {
  echo "--------------------------------------------------------"
  echo "=> $1"
  echo "--------------------------------------------------------"
  echo ""
}

# ---------------- DOWNLOAD POSTGRES DRIVER -------------------

TMP_DIR_DOWNLOADS="/tmp/Downloads/org/postgres/main"

PG_DRV_VERSION="42.6.0"
POSTGRES_JDBC_DRIVER="postgresql-$PG_DRV_VERSION.jar"
POSTGRES_REPO="https://repo1.maven.org/maven2/org/postgresql/postgresql"

URL_POSTGRES_JAR=$POSTGRES_REPO/$PG_DRV_VERSION/postgresql-$PG_DRV_VERSION.jar

if [ -f $TMP_DIR_DOWNLOADS/postgresql.jar ]; then
  echo_message "Postgres JDBC Driver already downloaded to ~$TMP_DIR_DOWNLOADS"
else
  echo_message "Downloading Postgresql JDBC Driver to $TMP_DIR_DOWNLOADS/postgresql.jar"
  echo wget -O $TMP_DIR_DOWNLOADS/postgresql.jar --no-check-certificate $URL_POSTGRES_JAR
  wget -O $TMP_DIR_DOWNLOADS/postgresql.jar --no-check-certificate $URL_POSTGRES_JAR

  if [ -f $TMP_DIR_JARS/$POSTGRES_JDBC_DRIVER ]; then
    echo_message "FAILED TO DOWNLOAD POSTGRES JDBD DRIVER"
    exit
  fi
fi