#!/bin/bash

# Prompt the user to enter the path of the first input file
read -p "Enter the path of the first input file: " first_file

# Check if the first input file exists
if [ ! -f "$first_file" ]; then
    echo "Invalid first input file."
    exit 1
fi

# Get the directory of the first input file
directory=$(dirname "$first_file")

# Array to store the paths of each file
file_paths=()

# Loop through each file in the same directory as the first input file
for file in "$directory"/*.{jpg,mkv,mp4}; do
    # Check if the file exists
    if [ ! -f "$file" ]; then
        continue
    fi

    # Append the file path to the array
    file_paths+=("$file")
done

# Sort the input files numerically based on filenames
sorted_files=($(printf "%s\n" "${file_paths[@]}" | sort -V))

# Check if any input files were found
if [ ${#sorted_files[@]} -eq 0 ]; then
    echo "No input files found in the directory."
    exit 1
fi

# Prompt the user to enter the path of the output file
read -p "Enter the path of the output file: " output_file

# Check if the output file path is valid
if [ -z "$output_file" ]; then
    echo "Invalid output file path."
    exit 1
fi

# Get the length of the longest string
max_len=0
for file in "${sorted_files[@]}"; do
    chars=$(cat "$file")
    len=${#chars}
    if [ $len -gt $max_len ]; then
        max_len=$len
    fi
done

# Combining the characters
combine=""
for ((i = 0; i < max_len; i++)); do
    for file in "${sorted_files[@]}"; do
        chars=$(cat "$file")
        if [ $i -lt ${#chars} ]; then
            combine+="${chars:i:1}"
        fi
    done
done

# Write the combined characters to the output file
echo "$combine" > "$output_file"

echo "Combined characters have been written to '$output_file'."

