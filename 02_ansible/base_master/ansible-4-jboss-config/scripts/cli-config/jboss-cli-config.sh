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

echo " PAREI -----------> $1"
#env

exit 1   # -------------------

echo $SLAVES_HOSTNAMES
echo "$SLAVES_HOSTNAMES" | tr "'" '"'

#https://linuxsimply.com/bash-scripting-tutorial/array/array-operations/json-to-array/
json_array= $(echo "$SLAVES_HOSTNAMES" | tr "'" '"')
echo "2"
echo $json_array

echo "3"
echo "$json_array" | jq -r '.[]' 

bash_array=($(echo "$json_array" | jq -r '.[]' ))
echo "4"
echo "${bash_array[@]}"

echo "5"
for slave_hostname in "${bash_array[@]}"; do
    echo "key -------------> $slave_hostname"
don

exit 0

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
      echo_message "cli SUCCESS: $CLI ";
      cp $CLI $TMP_COPY_OF_CLI
    else
      echo_message "cli FAILURE: $CLI ";    
      exit $JBOSS_CLI_RESULT
    fi
  else
    echo_message "cli $CLI has already been applied"
  fi
done