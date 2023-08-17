#!/bin/bash

echo -e " Program for decision making i.e, if / else statement\n"

directory="./lesson"

if [ -d $directory ]; then
  echo " Directory is here"
else
  echo " Directory is not exist"
fi
