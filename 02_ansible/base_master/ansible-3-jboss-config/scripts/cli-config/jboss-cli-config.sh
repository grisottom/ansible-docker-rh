#!/bin/bash

function echo_message() {
  echo "--------------------------------------------------------";
  echo "=> $1";
  echo "--------------------------------------------------------";
  echo "";
}
  
  #echo_message "config-db";
  # jboss-cli.sh -c --file=./config-db/db.cli;
  # JBOSS_CLI_RESULT=$?;
  # JBOSS_CLI_RESULT_=$([ "$JBOSS_CLI_RESULT" == 0 ] && echo "true" || echo "false");
  # echo "JBOSS_CLI_RESULT: $JBOSS_CLI_RESULT_";

  # if [ ! "$JBOSS_CLI_RESULT" == 0 ] ; then
  #   echo_message "End of 'start-jboss', CONFIGURATION FAILURE";
  #   exit $JBOSS_CLI_RESULT
  # fi

TMP_DIR="$JBOSS_HOME/tmp/jboss_cs";
TMP_DIR_DOMAIN="$TMP_DIR/domain";

mkdir -p "$TMP_DIR_DOMAIN"

for CLI in *.cli; do
  TMP_COPY_OF_CLI=$TMP_DIR_DOMAIN/$CLI
  if [ ! -f  $TMP_COPY_OF_CLI ] ; then
    echo_message "applying CLI :$CLI"

    jboss-cli.sh -c --file=$CLI;
    JBOSS_CLI_RESULT=$?;
    JBOSS_CLI_RESULT_=$([ "$JBOSS_CLI_RESULT" == 0 ] && echo "true" || echo "false");
    echo "JBOSS_CLI_RESULT: $JBOSS_CLI_RESULT_";

    if [ "$JBOSS_CLI_RESULT" == 0 ] ; then
      echo_message "cli SUCESSFUL: $CLI ";
      cp $CLI $TMP_COPY_OF_CLI
    else
      echo_message "cli FAILUTE: $CLI ";    
      exit $JBOSS_CLI_RESULT
    fi
  else
    echo_message "cli $CLI has already been applied"
  fi
done