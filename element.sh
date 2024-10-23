#!/bin/bash
PSQL="psql -X --username=mking --dbname=periodic_table --no-align --tuples-only -c"
if [[ -z $1 ]]
then
echo -e "\nPlease provide an element as an argument.\n"
fi
# check if argument belongs to existing atomic
CHECK=$($PSQL "SELECT atomic_number, symbol, name FROM elements WHERE $1=atomic_number OR '$1'=symbol OR '$1'=name")
# if it doesn't not belong to databse
if [[ -z $CHECK ]]
then
echo -e "\nI could not find that element in the database.\n"
fi