#!/bin/bash

# Determine the directory where the script is running from and echo it to the terminal
dir=$(pwd)
echo "The script is running from: $dir"

# Write a function that takes two arguments and echo's them concatenated together
concatenate() {
    result=$1$2
    echo "The concatenation of the two arguments is: $result"
}

# Call the function with two arguments
concatenate "Hello " "World!"
