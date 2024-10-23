#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"
if [[ -z $1 ]]
then
echo -e "\nPlease provide an element as an argument.\n"
else
# check if argument belongs to existing atomic
if [[ $1 =~ ^[0-9]+$ ]]
then
  ATOMIC_INFO=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$1")
else
  ATOMIC_INFO=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol='$1' OR name='$1'")
fi
# if it doesn't not belong to databse
if [[ -z $ATOMIC_INFO ]]
then
echo -e "\nI could not find that element in the database.\n"
else
  # Parse the result
  echo "$ATOMIC_INFO" | while IFS="|" read TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE
  do
    echo -e "\nThe element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius.\n"
  done
fi
fi