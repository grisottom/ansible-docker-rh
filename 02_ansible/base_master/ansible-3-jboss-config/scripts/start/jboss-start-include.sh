
#!/bin/bash

function echo_message() {
  echo "--------------------------------------------------------";
  echo "=> $1";
  echo "--------------------------------------------------------";
  echo "";
}


JBOSS_DOMAIN_DIR=$JBOSS_HOME/domain;
#sudo chown -R jboss:jboss $JBOSS_DOMAIN_DIR #bind mount from host, owned by root

JBOSS_DOMAIN_TMP_DIR=$JBOSS_DOMAIN_DIR/tmp; #inner jboss dir
JBOSS_MARKERFILE="${JBOSS_DOMAIN_TMP_DIR}/startup-marker";

#-----------------------  FUNCTIONS ----------------------------

function jboss_already_started() {
  BOOTED_TIMESTAMP=`stat -c %Y /proc/`;

  if [ -f  $JBOSS_MARKERFILE ] ; then

    MARKERFILE_TIMESTAMP=`stat -c %Y $JBOSS_MARKERFILE`;

    echo "boot time: $BOOTED_TIMESTAMP";
    echo "markerfile time: $MARKERFILE_TIMESTAMP";

    if [ "$BOOTED_TIMESTAMP" -ge "$MARKERFILE_TIMESTAMP" ] ; then
      # ---------------- CLEANING PREVIOUS CRASHED START ---------------
      echo_message "System Booted after Jboss markerfile creation (system crashed?), deleting file $JBOSS_MARKERFILE";
      sudo rm $JBOSS_MARKERFILE;
      return 1; #false
    else
      echo_message "Jboss already started - domain mode";
      return 0; #true
    fi
  else
    return 1; #false
  fi
}

function is_jboss_fully_started() {
  if [ -f  $JBOSS_MARKERFILE ] ; then

    MARKERFILE_TIMESTAMP=`stat -c %Y $JBOSS_MARKERFILE`;

    echo_message "markerfile found timestamp: $MARKERFILE_TIMESTAMP";
    
    if [ "$MARKERFILE_TIMESTAMP" -gt "$currenttime" ] ; then
      return 0;  #true
    fi
  fi
  return 1;  #false
}

function wait_for_server() {
  i=0;
  timeOut=30;
  while ( ! is_jboss_fully_started ) && [ $i -lt $timeOut ] ; do
    sleep 1;
    ((i=i+1));
    echo_message "wait jboss server to start: $i";
  done
  if [ $i -eq $timeOut ] ; then
    echo_message "Jboss not started, timeout reached: $timeOut s";
    return 1; #false
  fi
  return 0; #true
}

function start_jboss() {
  jboss_already_started;
  JBOSS_STARTED=$?;

  JBOSS_STARTED_=$([ "$JBOSS_STARTED" == 0 ] && echo "true" || echo "false");
  echo "JBOSS_ALREADY_STARTED: $JBOSS_STARTED_";

  if [ "$JBOSS_STARTED" == 1 ] ; then  #not started

    # ---------------- START JBOSS --------------------
    echo_message "starting jboss, domain mode, --host-config=$host_config, --host-config=$HOST_CONFIG";

    domain.sh -b 0.0.0.0 -bmanagement 0.0.0.0 --host-config=$HOST_CONFIG $JBOSS_OPTION &

    currenttime=$(date +%s);
    echo "currenttime: $currenttime";

    echo_message 'waiting for the server to boot';
    wait_for_server;

    JBOSS_STARTED=$?;
  fi

  return $JBOSS_STARTED;
}
