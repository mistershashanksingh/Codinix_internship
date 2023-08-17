#!/bin/bash

# Ask the user for file paths
read -p "Enter the path of the first file: " file1_path
read -p "Enter the path of the second file: " file2_path

# Check if both files exist
if [[ ! -f "$file1_path" ]]; then
  echo "Error: First file does not exist."
  exit 1
fi

if [[ ! -f "$file2_path" ]]; then
  echo "Error: Second file does not exist."
  exit 1
fi

# Extract the first column from each file
file1_column1=$(cut -d ',' -f1 "$file1_path")
file2_column1=$(cut -d ',' -f1 "$file2_path")

# Compare the two columns and store the differences
differences=$(comm -23 <(echo "$file1_column1") <(echo "$file2_column1"))

# Print the differences, if any, without the first line
if [[ -n $differences ]]; then
  echo "Values present in the first file but not in the second file:"
  first_line=true
  while IFS= read -r line; do
    if [ "$first_line" = true ]; then
      first_line=false
      continue
    fi
    echo "$line" | cut -d ',' -f1
  done <<< "$differences"
else
  echo "No differences found."
fi
