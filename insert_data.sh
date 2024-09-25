#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

# UPDATE TYPE_ID FOR PROPERTIES

: '

TYPE_PROPERTIES=$($PSQL "SELECT atomic_number,type FROM properties");
TYPES=$($PSQL "SELECT * FROM types")
echo "$TYPES" | while read TYPE_ID BAR TYPE
do
  echo 
  UPDATE_TYPE_ID_PROPERTIES=$($PSQL "UPDATE properties SET type_id='$TYPE_ID' WHERE type='$TYPE'")
  echo "$UPDATE_TYPE_ID_PROPERTIES"
done

'
# CHANGE FIRST LETTER CAPITALIZE

: '
SYMBOL_FIRST_CAPITALIZE=$($PSQL "SELECT atomic_number,CONCAT(UPPER(SUBSTRING(symbol,1,1)),SUBSTRING(symbol,2,LENGTH(symbol))) FROM elements")

echo "$SYMBOL_FIRST_CAPITALIZE" | while read ATOMIC_NUMBER BAR SYMBOL_FIRST_CAPITALIZE
do
  UPDATE_SYMBOL=$($PSQL "UPDATE elements SET symbol='$SYMBOL_FIRST_CAPITALIZE' WHERE atomic_number='$ATOMIC_NUMBER'")
  echo "$UPDATE_SYMBOL"
done
'

# CLEAR TRAILING ZEROS NUMERIC ATOMIC_MASS

# ENTER COMMAND TERMINAL UPDATE properties SET atomic_mass=TRIM(TRAILING '0' FROM atomic_mass::text)::DECIMAL;

