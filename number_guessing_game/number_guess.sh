#!/bin/bash

# variable for accessing database
PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"

# generate random number
SECRET_NUMBER=$(($RANDOM % 1000 + 1))

PLAY_GAME() {
  # get username
  echo "Enter your username:"
  read USERNAME

  # remove excess whitespace
  USERNAME=$(echo $USERNAME | sed -E 's/^ *| *$//g')

  # check for username in db
  USERNAME_RESULT=$($PSQL "SELECT user_name FROM users WHERE user_name = '$USERNAME'")

  # if username not found
  if [[ -z $USERNAME_RESULT ]]
    then
      echo "Welcome, $USERNAME! It looks like this is your first time here."
      # initialize games_played
      GAMES_PLAYED=0
      # save new user to db
      NEW_USER_RESULT=$($PSQL "INSERT INTO users (user_name) VALUES ('$USERNAME')")
  else
    # get existing user details
    USER_DETAILS_RESULT=$($PSQL "SELECT games_played, best_game FROM users WHERE user_name = '$USERNAME'")

    IFS="|" read -r GAMES_PLAYED BEST_GAME <<< $USER_DETAILS_RESULT

    # remove excess whitespace
    GAMES_PLAYED=$(echo $GAMES_PLAYED | sed -E 's/^ *| *$//g')
    BEST_GAME=$(echo $BEST_GAME | sed -E 's/^ *| *$//g')
    
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  fi

  # initialize guesses
  TOTAL_GUESSES=0

  # prompt for guess
  echo "Guess the secret number between 1 and 1000:"
  read GUESS

  TOTAL_GUESSES=$(( TOTAL_GUESSES + 1 ))

  # make sure guess is integer
  while [[ ! $GUESS =~ ^[0-9]+$ ]] 
  do
    echo "That is not an integer, guess again:"
    read GUESS
  done

  # loop until correct guess
  while [[ $GUESS != $SECRET_NUMBER ]]
  do
    if [[ $GUESS -gt $SECRET_NUMBER ]]
    then
      TOTAL_GUESSES=$(( TOTAL_GUESSES + 1 ))
      echo "It's lower than that, guess again:"
      read GUESS
    else 
      TOTAL_GUESSES=$(( TOTAL_GUESSES + 1 ))
      echo "It's higher than that, guess again:"
      read GUESS
    fi
  done

  echo "You guessed it in $TOTAL_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"

  # increment games_played
  GAMES_PLAYED=$(($GAMES_PLAYED + 1))

  # update best_game, if necessary
  BEST_GAME_RESULT=$($PSQL "SELECT best_game FROM users WHERE user_name = '$USERNAME'")

  # remove excess whitespace
  BEST_GAME_RESULT=$(echo $BEST_GAME_RESULT | sed -E 's/^ *| *$//g')

  # update user record
  if [[ $BEST_GAME_RESULT == 0 ]]
    then
      # set games_played and best_game
      USER_UPDATE_RESULT=$($PSQL "UPDATE users SET games_played = $GAMES_PLAYED, best_game = $TOTAL_GUESSES WHERE user_name = '$USERNAME'")
  elif [[ $TOTAL_GUESSES -le $BEST_GAME ]]
    then
      # update games_played and best_game
      USER_UPDATE_RESULT=$($PSQL "UPDATE users SET games_played = $GAMES_PLAYED, best_game = $TOTAL_GUESSES WHERE user_name = '$USERNAME'")
  else
      # update games_played
      USER_UPDATE_RESULT=$($PSQL "UPDATE users SET games_played = $GAMES_PLAYED WHERE user_name = '$USERNAME'")
  fi
}

PLAY_GAME
