
#!/bin/bash

# ---------------- AUXILIAR TEMPORARY FOLDER for Jboss configuration ----------------

TMP_DIR="$JBOSS_HOME/tmp/jboss_cs";
TMP_DIR_DOMAIN="$TMP_DIR/domain";

mkdir -p "$TMP_DIR_DOMAIN"

#**************************************************************************************************
# LIMPA CONFIGURAÇÃO PREVIA, recurso usado para fazer reset: descomentar, usar e comentar novamente
rm -Rf $TMP_DIR_DOMAIN/*;
#**************************************************************************************************

# ---------------- CHECKING PREVIOUS CONFIGURATION ---------------

if [ -f $TMP_DIR_DOMAIN/configuration/domain.xml ] ; then
  echo "jboss already configured, to reconfigure remove ~$TMP_DIR_DOMAIN and run again, exiting";
  exit;
else
  # Add User
  add-user.sh jboss jboss00;
  add-user.sh -a user user00;
fi

# ---------------- START JBOSS --------------

source ./jboss-start-include.sh

# ---------------- START JBOSS --------------------
start_jboss;
JBOSS_STARTED=$?;

JBOSS_STARTED_=$([ "$JBOSS_STARTED" == 0 ] && echo "true" || echo "false");
echo "JBOSS_STARTED: $JBOSS_STARTED_";

# ---------------- CONFIGURAR JBOSS --------------------

if [ "$JBOSS_STARTED" == 0 ] ; then

  if [ -f $TMP_DIR_DOMAIN/configuration/domain.xml ] ; then
    echo_message "jboss already configured, to reconfigure remove ~$TMP_DIR_DOMAIN from host and 'docker-run' again, exiting";
    exit 0
  else

    echo_message "config-db";
    jboss-cli.sh -c --file=./config-db/db.cli;
    JBOSS_CLI_RESULT=$?;
    JBOSS_CLI_RESULT_=$([ "$JBOSS_CLI_RESULT" == 0 ] && echo "true" || echo "false");
    echo "JBOSS_CLI_RESULT: $JBOSS_CLI_RESULT_";

    if [ ! "$JBOSS_CLI_RESULT" == 0 ] ; then
      echo_message "End of 'start-jboss', CONFIGURATION FAILURE";
      exit $JBOSS_CLI_RESULT
    fi
    #---------------------- COPY THE CONFIGURATION TO TMP_DIR_DOMAIN dir --------------------
    echo_message "End of 'start-jboss', CONFIGURATION SUCESSFULL, COPY OF CONFIGURATION from $JBOSS_DOMAIN_DIR to dir $TMP_DIR_DOMAIN";
    cp -r $JBOSS_DOMAIN_DIR/* $TMP_DIR_DOMAIN/;
    exit 0
  fi
else
  echo_message "End of 'start-jboss', FAILED TO START";
  exit $JBOSS_STARTED
fi