#!/bin/bash

echo -e " Please enter the name of file: \c"
read filename

echo -e "Please Enter a pattern to search for: \c"
read pattern

grep "$pattern" "$filename"
