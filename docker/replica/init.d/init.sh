#!/bin/bash
rm -f /var/lib/mysql/auto.cnf
while [ ! -f "/docker/master_db.sql" ]
do
    sleep 3;
done
mysql -u root -prootpass database < /docker/master_db.sql
MASTER_LOG_FILE=`head -n 100 /docker/master_db.sql | grep -o "MASTER_LOG_FILE='mysql-bin.[0-9]\+'"`
MASTER_LOG_POS=`head -n 100 /docker/master_db.sql | grep -o "MASTER_LOG_POS=[0-9]\+"`
mysql -u root -prootpass database -e"CHANGE MASTER TO MASTER_HOST='master', MASTER_PORT=3306, MASTER_USER='repl', MASTER_PASSWORD='replpass', ${MASTER_LOG_FILE}, ${MASTER_LOG_POS};"
mysql -u root -prootpass database -e"START SLAVE;"
