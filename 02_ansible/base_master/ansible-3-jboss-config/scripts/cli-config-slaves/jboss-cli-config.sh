#!/bin/bash

function echo_message() {
  echo -e "--------------------------------------------------------";
  echo -e "=> $1";
  echo -e "- -------------------------------------------------------";
  echo -e "";
}
  
file="file.properties"
touch $file

APPLY_TO_SLAVE=$1
JBOSS_SERVER_GROUP=$2
JBOSS_SERVER_CONFIG=$3

echo "SLAVE=${APPLY_TO_SLAVE}" > "$file"
echo "SERVER_GROUP=${JBOSS_SERVER_GROUP}" >> "$file"
echo "SERVER_CONFIG=${JBOSS_SERVER_CONFIG}" >> "$file"

# echo SLAVE=${APPLY_TO_SLAVE}
# echo SERVER_GROUP=${JBOSS_SERVER_GROUP}
# echo SERVER_CONFIG=${JBOSS_SERVER_CONFIG}

for CLI in *.cli; do
    echo_message "applying CLI :$CLI"

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