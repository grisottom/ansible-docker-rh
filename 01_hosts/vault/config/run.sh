##!/bin/bash

#============ 

function is_vault_status_initialized()  {
  VAULT_STATUS=`vault operator init -status`;
  echo "result = $VAULT_STATUS"
  if [ "$VAULT_STATUS" == "Vault is initialized" ] ; then
    return 0; #true
  fi

  return 1; #false
}

function wait_for_server() {
  i=0;
  timeOut=3;
  while ( ! is_vault_status_initialized ) && [ $i -lt $timeOut ] ; do
    sleep 1;
    ((i=i+1));

    echo "wait vault server to start: $i";
  done

  if [ $i -eq $timeOut ] ; then
    echo_message "Vault not started, timeout reached: $timeOut s";
    return 1; #false
  fi
  return 0; #true  
}

function start_vault() {
  is_vault_status_initialized;
  VAULT_STARTED=$?;

  if [ "$VAULT_STARTED" == 1 ]; then
    #start vault unattached
    vault server -dev &

    wait_for_server;
    VAULT_STARTED=$?;
  fi

  return $VAULT_STARTED;
}

start_vault;
VAULT_STARTED=$?;

if [ "$VAULT_STARTED" == 0 ]; then
  echo "End of 'start-vault', RUNNING";
else
  echo "End of 'start-vault', FAILED TO START"
  exit 1
fi

#============== initialize kv, dev variables

source ./kv-init.sh

#============= Keep Process running
tail -f /dev/null;
