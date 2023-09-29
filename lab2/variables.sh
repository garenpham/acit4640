#!/bin/bash

# Storing the output of whoami and echo the variable to the terminal
user=$(whoami)
echo "The current user is: $user"

# Get the date, store it in a variable, and write the contents of the variable to a file named date_now.txt
date_now=$(date)
echo "The current date is: $date_now"
echo $date_now > date_now.txt

# Write a conditional statement that asks the user for a letter and echo's 'Yes!!" if the letter is "Y"
read -p "Please enter a letter: " letter
if [[ "$letter" == "Y" ]]; then
    echo "Yes!!"
else
    echo "You entered: $letter"
fi
