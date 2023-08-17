# Prompt the user to enter the file path
read -p "Enter the file path: " file_path

# Check if the file exists
if [ ! -f "$file_path" ]; then
  echo "File not found."
  exit 1
fi

# Check if the file contains a newline character
#new_line=""
#if grep -qF $'\n' "$file_path"; then
#  new_line=$'\n'
#fi

# Get the directory path from the file path
directory_path=$(dirname "$file_path")

# Create a folder with the same name as the file in the directory path
folder_name=$(basename "$file_path")
folder_name="${folder_name//./_}"
mkdir -p "$directory_path/$folder_name"

# Read the file content
content=$(cat "$file_path")

# Calculate the length of the content
length=${#content}

# Calculate the number of files based on user input
read -p "Enter the number of files (n): " n

# Calculate the step size to iterate through the content
step=$((length / n))

# Initialize the starting index
i=0

for ((i = 0; i < length; i++)); do
  char="${content:i:1}"

  # Calculate the file index
  file_index=$(( (i % n) + 1 ))

  # Generate the file name
  file_name="${folder_name}_part${file_index}.dat"

  # Write the character to a separate file within the created folder
  echo -n "$char" >> "$directory_path/$folder_name/$file_name"
  echo "Character '$char' written to file: $directory_path/$folder_name/$file_name"

  # Check if the character is a newline and if a newline character is present in the file
  if [[ "$char" == $'\n' ]] && [[ "$new_line" == $'\n' ]]; then
    # Increment the starting index by the step size
    i=$((i + step))
  fi
done

