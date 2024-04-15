##!/bin/bash

#============ 

function get_vault_status_initialized()  {
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
  while ( ! get_vault_status_initialized ) && [ $i -lt $timeOut ] ; do
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
  #start unattached
  #vault server -dev &

  wait_for_server;
  VAULT_STARTED=$?;

  return $VAULT_STARTED;
}

start_vault;
VAULT_STARTED=$?;

if ["$JBOSS_STARTED" == 1]; then
  exit 1
fi

#============== initialize Vault, dev variables

tee in.json -<<EOF
{
  "admin_user": "jboss",
  "admin_pwd": "jboss00",
  "app_user": "user",
  "app_user_pwd": "user00"
}
EOF

vault kv put -mount=MyCompany MyContext/jboss @in.json

rm in.json

