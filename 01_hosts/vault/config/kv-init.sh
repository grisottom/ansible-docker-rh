##!/bin/bash

vault secrets enable -path=MyCompany kv

vault kv put -mount=MyCompany MyContext/jboss/product @kv-jboss.json
vault kv put -mount=MyCompany MyContext/postgres/product/db1 @kv-postgres-db1.json
vault kv put -mount=MyCompany MyContext/postgres/product/db2 @kv-postgres-db2.json