#!/bin/bash

DB_NAME=<your database name>
DB_USER=<your database username>
DB_PASS=<your database password>
TABLES=$(mysql -u $DB_USER -p$DB_PASS -e "USE $DB_NAME;SHOW TABLES;" | grep -v "Tables_in")

while true
do
    echo "----------------------"
    echo "Database: $DB_NAME"
    if [ $(echo $TABLES | wc -w) -eq 1 ]; then
        echo "1 table on the database"
    else
        echo "$(echo $TABLES | wc -w) tables on the database"
    fi
    echo "----------------------"
    for table in $TABLES
    do
        echo "Table: $table"
        mysql -u $DB_USER -p$DB_PASS -e "USE $DB_NAME;SELECT * FROM $table;"
        echo "----------------------"
    done
    sleep 3
done

