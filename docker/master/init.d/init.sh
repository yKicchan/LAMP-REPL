#!/bin/bash
if [ -e /replica/master_db.sql ]; then
    rm /replica/master_db.sql
fi
mysql -u root -prootpass database -e"GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%' IDENTIFIED BY 'replpass';"
mysqldump -u root -prootpass --all-databases --events --single-transaction --flush-logs --master-data=2 --hex-blob --default-character-set=utf8 > /replica/master_db.sql
