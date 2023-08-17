#!/bin/bash

# Prompt the user to enter the input file paths
read -p "Enter the path of the first input file: " file1
read -p "Enter the path of the second input file: " file2
read -p "Enter the path of the output file: " output_file

# Check if both files exist
if [ ! -f "$file1" ]; then
    echo "File '$file1' does not exist."
    exit 1
fi

if [ ! -f "$file2" ]; then
    echo "File '$file2' does not exist."
    exit 1
fi

# Read the characters from each file
chars1=$(cat "$file1")
chars2=$(cat "$file2")

# Get the length of the longest string
len=$(( ${#chars1} > ${#chars2} ? ${#chars1} : ${#chars2} ))

# Combining the characters
combine=""
for ((i=0; i<len; i++)); do
    if [ $i -lt ${#chars1} ]; then
        combine+="${chars1:i:1}"
    fi

    if [ $i -lt ${#chars2} ]; then
        combine+="${chars2:i:1}"
    fi
done

# Write the combined characters to the output file
echo "$combine" > "$output_file"

echo "combine characters have been written to '$output_file'."


