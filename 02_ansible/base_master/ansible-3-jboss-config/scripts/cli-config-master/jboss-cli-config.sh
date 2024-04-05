#!/bin/bash

function echo_message() {
  echo -e "--------------------------------------------------------";
  echo -e "=> $1";
  echo -e "--------------------------------------------------------";
  echo -e "";
}

file="file.properties"
touch $file

JBOSS_PROFILE_TO=$1
JBOSS_PROFILE_FROM=$2
JBOSS_SERVER_GROUP=$3

echo "PROFILE=${JBOSS_PROFILE_TO}" > "$file"
echo "PROFILE_FROM=${JBOSS_PROFILE_FROM}" >> "$file"
echo "SERVER_GROUP=${JBOSS_SERVER_GROUP}" >> "$file"

# echo PROFILE_TO=${JBOSS_PROFILE_TO}
# echo PROFILE_FROM=${JBOSS_PROFILE_FROM}
# echo SERVER_GROUP=${JBOSS_SERVER_GROUP}

for CLI in *.cli; do
  TMP_COPY_OF_CLI=$TMP_DIR_DOMAIN/$CLI
    #echo_message "applying CLI :$CLI"

    jboss-cli.sh -c --file=$CLI --resolve-parameter-values --properties=$file;
    JBOSS_CLI_RESULT=$?;
    JBOSS_CLI_RESULT_=$([ "$JBOSS_CLI_RESULT" == 0 ] && echo "true" || echo "false");
    #echo "JBOSS_CLI_RESULT: $JBOSS_CLI_RESULT_";

    if [ "$JBOSS_CLI_RESULT" == 0 ] ; then
      echo_message "cli SUCCESS: $CLI ";
    else
      echo_message "cli FAILURE: $CLI ";    
      exit $JBOSS_CLI_RESULT
    fi
done

exit 0