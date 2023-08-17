#!/bin/bash

# Prompt the user to enter the image file path
read -p "Enter the image file path: " image_path

# Check if the file exists
if [ ! -f "$image_path" ]; then
  echo "Image file not found."
  exit 1
fi

# Get the directory path from the image file path
directory_path=$(dirname "$image_path")

# Create a folder with the same name as the image file (without extension) in the directory path
folder_name=$(basename "$image_path")
folder_name="${folder_name%.*}"
folder_name="${folder_name//./_}"
mkdir -p "$directory_path/$folder_name"

# Read the image file content as binary data
content=$(cat "$image_path" | xxd -p -c1)

# Calculate the length of the content
length=${#content}

# Calculate the number of .dat files (n)
n=3

# Initialize the starting index
i=0

for ((i = 0; i < length; i++)); do
  char="${content:i:2}"  # Read two characters at a time for binary data

  # Calculate the file index
  file_index=$(( (i % n) + 1 ))

  # Generate the .dat file name
  file_name="${folder_name}_part${file_index}.dat"

  # Write the character to a separate .dat file within the created folder
  echo -n "$char" | xxd -p -r >> "$directory_path/$folder_name/$file_name"
done

echo "Splitting image into chunks is complete."

