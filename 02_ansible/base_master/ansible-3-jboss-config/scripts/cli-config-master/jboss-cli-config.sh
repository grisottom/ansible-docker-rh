#!/bin/bash

function echo_message() {
  echo "--------------------------------------------------------";
  echo "=> $1";
  echo "--------------------------------------------------------";
  echo "";
}

file="file.properties"
touch $file

JBOSS_PROFILE_FROM=$1
JBOSS_PROFILE_TO=$2
JBOSS_SERVER_GROUP=$1

echo "PROFILE_FROM=${JBOSS_PROFILE_FROM}" > "$file"
echo "PROFILE=${JBOSS_PROFILE_TO}" >> "$file"
echo "PROFILE=${JBOSS_SERVER_GROUP}" >> "$file"

for CLI in *.cli; do
  TMP_COPY_OF_CLI=$TMP_DIR_DOMAIN/$CLI
    echo_message "applying CLI :$CLI"

    jboss-cli.sh -c --file=$CLI --properties=$file;
    JBOSS_CLI_RESULT=$?;
    JBOSS_CLI_RESULT_=$([ "$JBOSS_CLI_RESULT" == 0 ] && echo "true" || echo "false");
    echo "JBOSS_CLI_RESULT: $JBOSS_CLI_RESULT_";

    if [ "$JBOSS_CLI_RESULT" == 0 ] ; then
      echo_message "cli SUCCESS: $CLI ";
    else
      echo_message "cli FAILURE: $CLI ";    
      exit $JBOSS_CLI_RESULT
    fi
done

exit 0