#!/bin/bash

echo -e " Please enter the name of file: \c"
read filename

echo -e "Please Enter an extended pattern to search for: \c"
read ext_pattern

egrep "$ext_pattern" "$filename"
