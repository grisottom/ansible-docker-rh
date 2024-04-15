##!/bin/bash
function get_vault_status_initialized()  {
  vault operator init -status
  result=$0
  if [ "$result" == "Vault is initialized" ] ; then
    return 0;
  fi

  return 1;
}
