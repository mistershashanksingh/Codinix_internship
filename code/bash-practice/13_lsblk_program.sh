#!/bin/bash

echo -e "Do you want to list all block devices? (y/n) \c"
read answer
if [ "$answer" == "y" ]; then
  lsblk
else
  echo -e "listing block devices cancelled.\n"
fi
