#!/bin/bash

# Prompt the user to enter the folder path containing the .dat files
read -p "Enter the folder path containing the .dat files: " folder_path

# Check if the folder exists
if [ ! -d "$folder_path" ]; then
  echo "Folder not found."
  exit 1
fi

# Get the directory path from the folder path
directory_path=$(dirname "$folder_path")

# Get the folder name
folder_name=$(basename "$folder_path")

# Create the output image file path
output_image_path="$directory_path/${folder_name}_combined.jpg"

# Initialize the combined content variable
combined_content=""

# Iterate through the .dat files
for file_path in "$folder_path"/*.dat; do
  # Read the content of each .dat file
  content=$(cat "$file_path" | xxd -p -c2)

  # Append the content to the combined content
  combined_content+="$content"
done

# Convert the combined content from hex to binary
echo -n "$combined_content" | xxd -p -r > "$output_image_path"

echo "Combining chunks into the image file is complete. Output file: $output_image_path"

