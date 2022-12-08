#!/bin/bash

# variable for accessing database
PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"

# generate random number
SECRET_NUMBER=$(($RANDOM % 1000 + 1))

# initialize guesses
TOTAL_GUESSES=0

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
    # save new user to db
    NEW_USER_RESULT=$($PSQL "INSERT INTO users (user_name) VALUES ('$USERNAME')")
  else
    USER_DETAILS_RESULT=$($PSQL "SELECT games_played, best_game FROM users WHERE user_name = '$USERNAME'")

    IFS="|" read -r GAMES_PLAYED BEST_GAME <<< $USER_DETAILS_RESULT

    GAMES_PLAYED=$(echo $GAMES_PLAYED | sed -E 's/^ *| *$//g')
    BEST_GAME=$(echo $BEST_GAME | sed -E 's/^ *| *$//g')

    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

HANDLE_GUESS() {
  read GUESS

  # if input was an integer
  if [[ $GUESS =~ ^[0-9]+$ ]]
    then
      # increment number of guesses
      TOTAL_GUESSES=$(($TOTAL_GUESSES + 1))

      if [[ $GUESS == $SECRET_NUMBER ]]
        then
          # increment games_played
          GAMES_PLAYED=$(($GAMES_PLAYED + 1))
          # update user record
          if [[ $TOTAL_GUESSES -le $BEST_GAME ]]
          then
            # set games played and best_game
            USER_UPDATE_RESULT=$($PSQL "UPDATE users SET games_played = $GAMES_PLAYED, best_game = $TOTAL_GUESSES WHERE user_name = '$USERNAME'")
          else
            # update games_played
            USER_UPDATE_RESULT=$($PSQL "UPDATE users SET games_played = $GAMES_PLAYED WHERE user_name = '$USERNAME'")
          fi
          echo "You guessed it in $TOTAL_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
      elif [[ $GUESS -lt $SECRET_NUMBER ]]
        then
          echo "It's higher than that, guess again:"
          # try again
          HANDLE_GUESS
      elif [[ $GUESS -gt $SECRET_NUMBER ]]
        then
          echo "It's lower than that, guess again:"
          # try again
          HANDLE_GUESS
      fi
    else
      echo "That is not an integer, guess again:"
      # try again
      HANDLE_GUESS
fi
}

# prompt for number 
echo "Guess the secret number between 1 and 1000:"
HANDLE_GUESS