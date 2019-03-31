#!/bin/sh
# script to populate the db
# by: Todd Burgess (toddburgess@torontocatrescue.ca)
./loadtable.sh Cat
./loadtable.sh FosterCoordinator
./loadtable.sh FosterHome
./loadtable.sh CatFosterHome
./loadtable.sh PetStore
./loadtable.sh VetClinic
./loadtable.sh UserLogin
echo "The database is now populated with test data"
