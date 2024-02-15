
#!/bin/bash

source jboss-start-include.sh

# ---------------- START JBOSS --------------------
start_jboss;
JBOSS_STARTED=$?;

JBOSS_STARTED_=$([ "$JBOSS_STARTED" == 0 ] && echo "true" || echo "false");
echo "JBOSS_STARTED: $JBOSS_STARTED_";

# ---------------- CONFIGURAR JBOSS --------------------

if [ "$JBOSS_STARTED" == 0 ]; then  #started

  echo_message "End of 'start-jboss', KEEP PROCESS RUNNING";
  #The container will "exit" when the process itself exits 
  #keep process running:
  tail -f /dev/null;
else
  echo_message "End of 'start-jboss', FAILED TO START";
fi
