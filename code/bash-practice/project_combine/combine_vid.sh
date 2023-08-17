#!/bin/bash

# Ask the user for the directory containing the split files
read -p "Enter the directory containing the split files: " split_files_dir

# Validate the split files directory
if [ ! -d "$split_files_dir" ]; then
  echo "Invalid directory. Please enter a valid directory path."
  exit 1
fi

# Ask the user for the first portion binary file name
read -p "Enter the name of the first portion binary file: " first_file_name

# Validate the first file name
if [ -z "$first_file_name" ]; then
  echo "Invalid file name. Please enter a non-empty file name."
  exit 1
fi

# Ask the user for the output file path
read -p "Enter the output file path (including extension): " output_file

# Validate the output file path
output_dir=$(dirname "$output_file")
if [ ! -d "$output_dir" ]; then
  echo "Invalid output directory. Please enter a valid directory path."
  exit 1
fi

# Combine the split files

# Get the file extension from the first portion binary file
file_extension="${first_file_name##*.}"

# Get the split file prefix
split_file_prefix="${first_file_name%.*}"

# Generate the split file names and sort them numerically
split_files=("$split_files_dir/$first_file_name")
while true; do
  next_file=$(ls "$split_files_dir" | grep "$split_file_prefix" | sort -V | grep -A 1 "$split_files_dir/$first_file_name" | tail -n 1)
  if [ -n "$next_file" ]; then
    split_files+=("$next_file")
    first_file_name=$(basename "$next_file")
  else
    break
  fi
done

# Concatenate the split files into a single binary data
binary_data=""
for split_file in "${split_files[@]}"; do
  while IFS= read -r -d '' line; do
    binary_data+="$line"
  done < <(tr -d '\0' < "$split_file")
done

# Convert the binary data back to hexadecimal
hex_data=$(echo -n "$binary_data" | xxd -r -p)

# Write the hexadecimal data to the output file
echo -n "$hex_data" > "$output_file"

echo "Video parts combined into $output_file."

