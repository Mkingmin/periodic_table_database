#!/bin/bash
PSQL="psql -X --username=mking --dbname=periodic_table --no-align --tuples-only -c"
if [[ -z $1 ]]
then
echo -e "\nPlease provide an element as an argument.\n"
fi