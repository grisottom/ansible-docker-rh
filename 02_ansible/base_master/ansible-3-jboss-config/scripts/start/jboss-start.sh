
#!/bin/bash

source ./jboss-start-include.sh

# ---------------- START JBOSS --------------------
start_jboss;
JBOSS_STARTED=$?;

JBOSS_STARTED_=$([ "$JBOSS_STARTED" == 0 ] && echo "true" || echo "false");
echo "JBOSS_STARTED: $JBOSS_STARTED_";

# ---------------- CONFIGURAR JBOSS --------------------

if [ "$JBOSS_STARTED" == 0 ]; then  #started

  echo_message "End of 'start-jboss', RUNNING";
  exit 0
else
  echo_message "End of 'start-jboss', FAILED TO START";
  exit 1
fi