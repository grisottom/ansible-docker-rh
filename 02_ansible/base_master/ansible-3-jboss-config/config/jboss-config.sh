
#!/bin/bash

# ---------------- AUXILIAR TEMPORARY FOLDER for Jboss configuration ----------------

TMP_DIR="$JBOSS_HOME/tmp/jboss_cs";
TMP_DIR_DOMAIN="$TMP_DIR/domain";

#**************************************************************************************************
# LIMPA CONFIGURAÇÃO PREVIA, recurso usado para fazer reset: descomentar, usar e comentar novamente
#sudo rm -Rf $TMP_DIR_DOMAIN/*;
#**************************************************************************************************

# ---------------- CHECKING PREVIOUS CONFIGURATION ---------------

if [ -f $TMP_DIR_DOMAIN/configuration/domain.xml ] ; then
  echo "jboss already configured, to reconfigure remove ~$TMP_DIR_DOMAIN from host and 'docker-run' again, exiting";
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
  else

    echo_message "config-db";
    jboss-cli.sh -c --file=./config-db/db.cli;

    #---------------------- COPY THE CONFIGURATION TO SHARED dir --------------------
    echo_message "COPY OF CONFIGURATION from $JBOSS_DOMAIN_DIR to dir $TMP_DIR_DOMAIN";
    #
    cp -r $JBOSS_DOMAIN_DIR/* $TMP_DIR_DOMAIN/;
  fi
fi