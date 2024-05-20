##!/bin/bash

vault secrets enable -path=MyCompany kv

vault kv put -mount=MyCompany MyContext/jboss/MyInstance @kv-jboss.json
vault kv put -mount=MyCompany MyContext/postgresql/MyInstance/db1 @kv-postgres-db1.json
vault kv put -mount=MyCompany MyContext/postgresql/MyInstance/db2 @kv-postgres-db2.json