#!/bin/bash

# variable for accessing database
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

# if an argument is passed
if [[ $1 ]]
  then
    # if input was number
    if [[ $1 =~ ^[0-9]+$ ]]
    then
      # get result by atomic number
      ELEMENT_NUMBER_RESULT=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1")
    else 
      # get result by symbol or name
      ELEMENT_NUMBER_RESULT=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1' OR name = '$1'")
    fi

    # if element not found
    if [[ -z $ELEMENT_NUMBER_RESULT ]]
    then
      echo "I could not find that element in the database."
    else
      # remove excess whitespace
      ATOMIC_NUMBER=$(echo $ELEMENT_NUMBER_RESULT | sed -E 's/^ *| *$//g')

      # query element details
      ELEMENT_DETAILS_RESULT=$($PSQL "SELECT name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties ON elements.atomic_number = properties.atomic_number INNER JOIN types ON properties.type_id = types.type_id WHERE elements.atomic_number = $ELEMENT_NUMBER_RESULT")

      # print element details
      echo "$ELEMENT_DETAILS_RESULT" | while read NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS
      do
        echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
      done
    fi
  # ask for an argument
  else 
    echo "Please provide an element as an argument."
fi
