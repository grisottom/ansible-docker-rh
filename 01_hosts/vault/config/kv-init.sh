##!/bin/bash

vault secrets enable -path=MyCompany kv
vault kv put -mount=MyCompany MyContext/jboss @kv.json