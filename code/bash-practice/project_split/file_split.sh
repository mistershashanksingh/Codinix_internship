#!/bin/bash

# Prompt the user to enter the file path
read -p "Enter the file path: " file_path

# Check if the file exists
if [ ! -f "$file_path" ]; then
      echo "File not found."
          exit 1
fi

# Check if the file contains a newline character
if grep -qF $'\n' "$file_path"; then
      echo -e "\n"
    else
          echo ""
fi

# Split the file into two parts
filename=$(basename "$file_path")
extension="${filename##*.}"
filename="${filename%.*}"

file1="${filename}_part1.${extension}"
file2="${filename}_part2.${extension}"

# Read the file content
content=$(cat "$file_path")

# Split the content into two parts
length=${#content}
part1=""
part2=""

for ((i=0; i<$length; i++)); do
      char="${content:i:1}"

          if grep -qF $'\n' "$file_path"; then
                    echo -e "\n"
                        else
                                  echo ""
                                      fi

                                          if (( i % 2 == 0 )); then
                                                    part1+="$char"
                                                        else
                                                                  part2+="$char"
                                                                      fi
                                                                    done

                                                                    # Write the parts to separate files
                                                                    echo "$part1" > "$file1"
                                                                    echo "$part2" > "$file2"

                                                                    echo "File has been split into two parts."
                                                                    echo "Part 1: $file1"
                                                                    echo "Part 2: $file2"

