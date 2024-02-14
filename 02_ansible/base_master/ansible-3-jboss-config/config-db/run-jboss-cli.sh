#!/bin/bash
jboss-cli.sh -c 

echo ~>1, full, ativar driver postgres 
/profile=full/subsystem=datasources/jdbc-driver=postgres:add(driver-name="postgres",driver-module-name="org.postgres",driver-class-name=org.postgresql.Driver)

echo ~>2 data-source, add 'db1DS'
data-source add \
    --profile=full \
    --name=db1DS \
    --jndi-name=java:/db1DS \
    --driver-name=postgres \
    --driver-class=org.postgresql.Driver \
    --connection-url=jdbc:postgresql://pg_host:5433/db1 \
    --user-name=user0 \
    --password=user0 \
    --initial-pool-size=1 \
    --max-pool-size=10 \
    --use-ccm=true \
    --blocking-timeout-wait-millis=5000 \
    --new-connection-sql="set datestyle = ISO, European;"

jboss-cli.sh -d