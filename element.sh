#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"
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
else
ATOMIC_INFO=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE $1=atomic_number OR '$1'=symbol OR '$1'=name")
  # Parse the result
  echo "$ATOMIC_INFO" | while IFS="|" read TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE
  do
    echo -e "\nThe element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius.\n"
  done
fi