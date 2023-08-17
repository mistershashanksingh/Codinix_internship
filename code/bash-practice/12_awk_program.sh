#!/bin/bash

data="
Alice, 25, F
Bob, 32, M
Charlie, 40, M
"

# Print the data to the console
echo "Original data:"
echo "$data"

# Use awk to print only the second column of data (the numbers)
echo "name or age or gender"
echo "$data" | awk '{print $2}'

