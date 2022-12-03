#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"

echo -e "Welcome to My Salon, how can I help you?\n"
  
MAIN_MENU() {
  # get available services
  AVAILABLE_SERVICES=$($PSQL "SELECT service_id, name FROM services")

  # list services
  echo "$AVAILABLE_SERVICES" | while read SERVICE_ID BAR NAME
  do
    echo "$SERVICE_ID) $NAME"
  done
  
  # accept service id
  read SERVICE_ID_SELECTED

  # check for service
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")

  if [[ -z $SERVICE_NAME ]]
  then
    echo -e "\nI could not find that service. What would you like today?"
    MAIN_MENU
  else 
    # get customer phone number
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE
    CUSTOMER_PHONE=$(echo $CUSTOMER_PHONE | sed -E 's/^ *| *$//g')

    # check for customer
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

    if [[ -z $CUSTOMER_NAME ]]
    then
      echo -e "\nI don't have a record for that phone number, what's your name?"

      # create new customer record
      read CUSTOMER_NAME
      CUSTOMER_NAME=$(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')

      NEW_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
    fi
    
    # get customer id
    CUSTOMER_ID_RESULT=$($PSQL "SELECT customer_id from customers WHERE name = '$CUSTOMER_NAME'")
    CUSTOMER_ID=$(echo $CUSTOMER_ID_RESULT | sed -E 's/^ *| *$//g')

    echo -e "\nWhat time would you like your $(echo $SERVICE_NAME | sed -E 's/^ *| *$//g'), $CUSTOMER_NAME?"

    # get appointment time
    read SERVICE_TIME
    SERVICE_TIME=$(echo $SERVICE_TIME | sed -E 's/^ *| *$//g')

    APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')") 

    echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
  fi
} 

MAIN_MENU
 