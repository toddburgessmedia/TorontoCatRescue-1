#!/bin/sh
# script to create the db schema
# by: Todd Burgess (toddburgess@torontocatrescue.ca)
echo "Creating the Datasbase"
mysql --user=root --password=root torontocatrescue < schema.sql
echo "Database created. Now run populate.sh"
