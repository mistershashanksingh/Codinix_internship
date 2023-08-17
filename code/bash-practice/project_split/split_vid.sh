#!/bin/bash

# Ask the user for the video file path
read -p "Enter the path to the video file: " video_file

# Validate the video file path
if [ ! -f "$video_file" ]; then
  echo "Invalid video file path. Please enter a valid file path."
  exit 1
fi

# Ask the user for the number of portions to split the video into
read -p "Enter the number of portions to split the video into: " num_portions

# Validate the user input
if ! [[ "$num_portions" =~ ^[0-9]+$ ]] || [ "$num_portions" -lt 1 ]; then
  echo "Invalid input. Please enter a positive integer."
  exit 1
fi

# Ask the user for the split file name prefix
read -p "Enter the split file name prefix: " split_file_prefix

# Validate the split file name prefix
if [ -z "$split_file_prefix" ]; then
  echo "Invalid split file name prefix. Please enter a non-empty prefix."
  exit 1
fi

# Get the directory of the video file
video_dir=$(dirname "$video_file")

# Create the directory with the name of the video file
directory_name=$(basename "$video_file" | cut -d. -f1)
mkdir -p "$video_dir/$directory_name"

# Splitting the video into binary parts

# Generate the split file names
split_files=()
for ((i=1; i<=num_portions; i++)); do
  split_files+=("$video_dir/$directory_name/$split_file_prefix$i.bin")
done

# Read the video file as binary data
video_data=$(cat "$video_file" | xxd -b -p)

# Iterate through each byte of binary data and split into files
index=0
for byte in $video_data; do
  for ((i=0; i<8; i++)); do
    bit="${byte:i:1}"
    echo "$bit" >> "${split_files[index % num_portions]}"
    ((index++))
  done
done

echo "Video split into $num_portions parts."

